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

// Lists the block sizes still allocated after TearDown; the size alone often
// tells a grown list from a leaked object
function TRtlMemoryLeakMonitor.GetReport: string;
var
  I: Integer;
  Delta: Int64;
begin
  Result := '';
  for I := Low(FPreSetup.SmallBlockTypeStates) to High(FPreSetup.SmallBlockTypeStates) do
  begin
    Delta := Int64(FPostTearDown.SmallBlockTypeStates[I].AllocatedBlockCount)
      - Int64(FPreSetup.SmallBlockTypeStates[I].AllocatedBlockCount);
    if Delta <> 0 then
      Result := Result + Format(' %d x %d B,',
        [Delta, FPreSetup.SmallBlockTypeStates[I].UseableBlockSize]);
  end;
  Delta := Int64(FPostTearDown.AllocatedMediumBlockCount)
    - Int64(FPreSetup.AllocatedMediumBlockCount);
  if Delta <> 0 then
    Result := Result + Format(' %d medium,', [Delta]);
  Delta := Int64(FPostTearDown.AllocatedLargeBlockCount)
    - Int64(FPreSetup.AllocatedLargeBlockCount);
  if Delta <> 0 then
    Result := Result + Format(' %d large,', [Delta]);
  if Result <> '' then
    Result := ' [blocks:' + Copy(Result, 1, Length(Result) - 1) + ']';
end;

initialization
  TDUnitXIoC.DefaultContainer.RegisterType<IMemoryLeakMonitor>(
    function: IMemoryLeakMonitor
    begin
      Result := TRtlMemoryLeakMonitor.Create;
    end);

end.
