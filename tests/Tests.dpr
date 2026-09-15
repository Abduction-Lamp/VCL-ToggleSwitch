program Tests;

{$IFNDEF TESTINSIGHT}
  {$APPTYPE CONSOLE}
{$ENDIF}

{$STRONGLINKTYPES ON}
{$WARN SYMBOL_PLATFORM OFF}

uses
  System.SysUtils,
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
{$ELSE}
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
{$ENDIF }
  DUnitX.TestFramework,
  ToggleSwitch in '..\source\ToggleSwitch.pas',
  ToggleSwitch.Tests.LeakMonitor in 'ToggleSwitch.Tests.LeakMonitor.pas',
  ToggleSwitch.Tests in 'ToggleSwitch.Tests.pas';

{$IFNDEF TESTINSIGHT}
var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger : ITestLogger;
{$ENDIF}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    TDUnitX.CheckCommandLine;
    runner := TDUnitX.CreateRunner;
    runner.UseRTTI := True;
    runner.FailsOnNoAsserts := True;

    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;

    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;

  {$IFNDEF CI}
  System.Write('Done.. press <Enter> key to quit.');
  System.Readln;
  {$ENDIF}
{$ENDIF}
end.
