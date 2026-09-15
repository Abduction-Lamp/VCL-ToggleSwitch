unit ToggleSwitch.Tests.LeakMonitor;

{ Per-test memory leak monitor for DUnitX that reads the RTL memory manager
  directly, so the test project needs neither FastMM4.pas nor a DUnitX
  rebuilt with USE_FASTMM4_LEAK_MONITOR. Registering it replaces the no-op
  monitor DUnitX installs by default. }

{$WARN SYMBOL_PLATFORM OFF}

interface

implementation

uses
  System.SysUtils,
  DUnitX.TestFramework,
  DUnitX.IoC;

type
  TBlockClass = (bcSmall, bcMedium, bcLarge);

  TRtlMemoryLeakMonitor = class(TInterfacedObject, IMemoryLeakMonitor, IMemoryLeakMonitor2)
  private
    FPreSetup: TMemoryManagerState;
    FPostSetup: TMemoryManagerState;
    FPreTest: TMemoryManagerState;
    FPostTest: TMemoryManagerState;
    FPreTearDown: TMemoryManagerState;
    FPostTearDown: TMemoryManagerState;
    class function AllocatedBytes(const State: TMemoryManagerState): Int64; static;
  public
    procedure PreSetup;
    procedure PostSetUp;
    procedure PreTest;
    procedure PostTest;
    procedure PreTearDown;
    procedure PostTearDown;
    function SetUpMemoryAllocated: Int64;
    function TestMemoryAllocated: Int64;
    function TearDownMemoryAllocated: Int64;
    function GetReport: string;
  end;

{ TRtlMemoryLeakMonitor }

class function TRtlMemoryLeakMonitor.AllocatedBytes(const State: TMemoryManagerState): Int64;
var
  Block: TSmallBlockTypeState;
begin
  Result := Int64(State.TotalAllocatedMediumBlockSize) +
    Int64(State.TotalAllocatedLargeBlockSize);
  for Block in State.SmallBlockTypeStates do
    Inc(Result, Int64(Block.UseableBlockSize) * Block.AllocatedBlockCount);
end;

procedure TRtlMemoryLeakMonitor.PreSetup;
begin
  GetMemoryManagerState(FPreSetup);
end;

procedure TRtlMemoryLeakMonitor.PostSetUp;
begin
  GetMemoryManagerState(FPostSetup);
end;

procedure TRtlMemoryLeakMonitor.PreTest;
begin
  GetMemoryManagerState(FPreTest);
end;

procedure TRtlMemoryLeakMonitor.PostTest;
begin
  GetMemoryManagerState(FPostTest);
end;

procedure TRtlMemoryLeakMonitor.PreTearDown;
begin
  GetMemoryManagerState(FPreTearDown);
end;

procedure TRtlMemoryLeakMonitor.PostTearDown;
begin
  GetMemoryManagerState(FPostTearDown);
end;

function TRtlMemoryLeakMonitor.SetUpMemoryAllocated: Int64;
begin
  Result := AllocatedBytes(FPostSetup) - AllocatedBytes(FPreSetup);
end;

function TRtlMemoryLeakMonitor.TestMemoryAllocated: Int64;
begin
  Result := AllocatedBytes(FPostTest) - AllocatedBytes(FPreTest);
end;

function TRtlMemoryLeakMonitor.TearDownMemoryAllocated: Int64;
begin
  Result := AllocatedBytes(FPostTearDown) - AllocatedBytes(FPreTearDown);
end;

// Lists the block classes left over across the same three spans DUnitX sums
// up (Setup, Test, TearDown), so the runner's own bookkeeping between them
// stays out. The size is the usable size of the block class, not of the
// object; it still tells a grown list from a leaked object most of the time
function TRtlMemoryLeakMonitor.GetReport: string;

  function Delta(const Pre, Post: TMemoryManagerState; What: TBlockClass;
    Index: Integer): Int64;
  begin
    case What of
      bcSmall:
        Result := Int64(Post.SmallBlockTypeStates[Index].AllocatedBlockCount)
          - Int64(Pre.SmallBlockTypeStates[Index].AllocatedBlockCount);
      bcMedium:
        Result := Int64(Post.AllocatedMediumBlockCount)
          - Int64(Pre.AllocatedMediumBlockCount);
    else
      Result := Int64(Post.AllocatedLargeBlockCount)
        - Int64(Pre.AllocatedLargeBlockCount);
    end;
  end;

  function LeftOver(What: TBlockClass; Index: Integer = 0): Int64;
  begin
    Result := Delta(FPreSetup, FPostSetup, What, Index)
      + Delta(FPreTest, FPostTest, What, Index)
      + Delta(FPreTearDown, FPostTearDown, What, Index);
  end;

var
  I: Integer;
  Count: Int64;
begin
  Result := '';
  for I := Low(FPreSetup.SmallBlockTypeStates) to High(FPreSetup.SmallBlockTypeStates) do
  begin
    Count := LeftOver(bcSmall, I);
    if Count <> 0 then
      Result := Result + Format(' %d x %d B,',
        [Count, FPreSetup.SmallBlockTypeStates[I].UseableBlockSize]);
  end;
  Count := LeftOver(bcMedium);
  if Count <> 0 then
    Result := Result + Format(' %d medium,', [Count]);
  Count := LeftOver(bcLarge);
  if Count <> 0 then
    Result := Result + Format(' %d large,', [Count]);
  if Result <> '' then
    Result := ' [blocks:' + Copy(Result, 1, Length(Result) - 1) + ']';
end;

initialization
  TDUnitXIoC.DefaultContainer.RegisterType<IMemoryLeakMonitor>(
    function: IMemoryLeakMonitor
    begin
      // A replacement memory manager would leave the RTL snapshots empty and
      // every delta at zero, which would pass for a clean run
      if IsMemoryManagerSet then
        raise Exception.Create('ToggleSwitch.Tests.LeakMonitor reads the RTL '
          + 'memory manager; a replacement one needs a monitor of its own');
      Result := TRtlMemoryLeakMonitor.Create;
    end);

end.
