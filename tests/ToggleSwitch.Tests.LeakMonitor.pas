unit ToggleSwitch.Tests.LeakMonitor;

{ Per-test memory leak monitor for DUnitX that reads the RTL memory manager
  directly, so the test project needs neither FastMM4.pas nor a DUnitX
  rebuilt with USE_FASTMM4_LEAK_MONITOR. Registering it replaces the no-op
  monitor DUnitX installs by default. }

interface

implementation

uses
  DUnitX.TestFramework,
  DUnitX.IoC;

type
  TRtlMemoryLeakMonitor = class(TInterfacedObject, IMemoryLeakMonitor)
  private
    FPreSetup: Int64;
    FPostSetup: Int64;
    FPreTest: Int64;
    FPostTest: Int64;
    FPreTearDown: Int64;
    FPostTearDown: Int64;
    class function AllocatedBytes: Int64; static;
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
  end;

{ TRtlMemoryLeakMonitor }

class function TRtlMemoryLeakMonitor.AllocatedBytes: Int64;
var
  State: TMemoryManagerState;
  Block: TSmallBlockTypeState;
begin
  GetMemoryManagerState(State);
  Result := Int64(State.TotalAllocatedMediumBlockSize) +
    Int64(State.TotalAllocatedLargeBlockSize);
  for Block in State.SmallBlockTypeStates do
    Inc(Result, Int64(Block.UseableBlockSize) * Block.AllocatedBlockCount);
end;

procedure TRtlMemoryLeakMonitor.PreSetup;
begin
  FPreSetup := AllocatedBytes;
end;

procedure TRtlMemoryLeakMonitor.PostSetUp;
begin
  FPostSetup := AllocatedBytes;
end;

procedure TRtlMemoryLeakMonitor.PreTest;
begin
  FPreTest := AllocatedBytes;
end;

procedure TRtlMemoryLeakMonitor.PostTest;
begin
  FPostTest := AllocatedBytes;
end;

procedure TRtlMemoryLeakMonitor.PreTearDown;
begin
  FPreTearDown := AllocatedBytes;
end;

procedure TRtlMemoryLeakMonitor.PostTearDown;
begin
  FPostTearDown := AllocatedBytes;
end;

function TRtlMemoryLeakMonitor.SetUpMemoryAllocated: Int64;
begin
  Result := FPostSetup - FPreSetup;
end;

function TRtlMemoryLeakMonitor.TestMemoryAllocated: Int64;
begin
  Result := FPostTest - FPreTest;
end;

function TRtlMemoryLeakMonitor.TearDownMemoryAllocated: Int64;
begin
  Result := FPostTearDown - FPreTearDown;
end;

initialization
  TDUnitXIoC.DefaultContainer.RegisterType<IMemoryLeakMonitor>(
    function: IMemoryLeakMonitor
    begin
      Result := TRtlMemoryLeakMonitor.Create;
    end);

end.
