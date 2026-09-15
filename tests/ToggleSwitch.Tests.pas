unit ToggleSwitch.Tests;

interface

uses
  DUnitX.TestFramework,
  Winapi.Windows,
  Winapi.Messages,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Graphics,
  ToggleSwitch;

type
  [TestFixture]
  TToggleSwitchTest = class
  private
    FForm: TForm;
    FToggle: TFluentToggleSwitch;
    FOnChangeFired: Boolean;
    procedure HandleOnChange(Sender: TObject);
    procedure Render(Toggle: TFluentToggleSwitch);
    procedure CreateRenderDestroy;
    procedure Press(X: Integer);
    procedure MoveTo(X: Integer);
    procedure Release(X: Integer);
    procedure CopyThroughStream(Source, Target: TFluentToggleSwitch);
    function StreamFormWithSwitch(out Loaded: TFluentToggleSwitch;
      out SourceWidth: Integer): TForm;
    function AsText(Source: TFluentToggleSwitch): string;
    procedure LoadText(const Dfm: string; Target: TFluentToggleSwitch);
  public
    [SetupFixture]
    procedure SetupFixture;
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    // --- Color properties ---

    [Test]
    procedure DefaultColorsShouldBeClDefault;

    [Test]
    procedure SetTrackFrameColor_ShouldStoreValue;

    [Test]
    procedure SetTrackColorOff_ShouldStoreValue;

    [Test]
    procedure SetTrackColorOn_ShouldStoreValue;

    [Test]
    procedure SetThumbColorOff_ShouldStoreValue;

    [Test]
    procedure SetThumbColorOn_ShouldStoreValue;

    // --- Text properties ---

    [Test]
    procedure DefaultShowText_ShouldBeFalse;

    [Test]
    procedure DefaultTextValues;

    [Test]
    procedure DefaultTextPosition_ShouldBeTpRight;

    [Test]
    procedure DefaultTextSpacing_ShouldBe12;

    [Test]
    procedure SetShowText_True_ShouldIncreaseWidth;

    [Test]
    procedure SetShowText_False_ShouldResetWidth;

    [Test]
    procedure SetTextPosition_ShouldStoreValue;

    [Test]
    procedure SetTextSpacing_ShouldStoreValue;

    [Test]
    procedure SetTextSpacing_Negative_ShouldClampToZero;

    [Test]
    procedure SetTextOn_ShouldAffectWidth;

    [Test]
    procedure TextPosition_Left_WithShowText_ShouldStoreValue;

    // --- Toggle and events ---

    [Test]
    procedure SetTextOn_BeforeParent_ShouldNotRaise;

    [Test]
    procedure Toggle_ShouldChangeChecked;

    [Test]
    procedure SetChecked_ShouldNotFireOnChange;

    [Test]
    procedure SpaceKey_ShouldNotToggle;

    [Test]
    procedure DragPastMiddle_ShouldTurnOnAndFireOnChange;

    [Test]
    procedure DragShort_ShouldSnapBack;

    [Test]
    procedure Click_ShouldToggleAndFireOnChange;

    [Test]
    procedure Click_ReleasedOutside_ShouldNotToggle;

    [Test]
    procedure Click_OnLabel_ShouldToggle;

    [Test]
    procedure DragBackPastMiddle_ShouldTurnOffAndFireOnChange;

    [Test]
    procedure RightButton_ShouldNotToggle;

    [Test]
    procedure Enabled_False_Click_ShouldNotToggle;

    [Test]
    procedure Enabled_False_WhilePressed_ShouldCancelThePress;

    [Test]
    procedure ParentColor_ShouldBeTrueByDefault;

    [Test]
    procedure DefaultChecked_ShouldBeFalse;

    [Test]
    procedure DefaultAnimationDuration_ShouldMatchWinUI;

    [Test]
    procedure AnimationDuration_ShouldClampToPositive;

    [Test]
    procedure Paint_ShouldNotChangeSize;

    [Test]
    procedure CreateAndDestroy_ShouldNotLeak;

    // --- Scaling ---

    [Test]
    procedure Scale_96_ShouldUseTheDesignSize;

    [Test]
    procedure Scale_120_ShouldGrowWithTheScale;

    [Test]
    procedure Scale_144_ShouldGrowWithTheScale;

    [Test]
    procedure Scale_192_ShouldGrowWithTheScale;

    [Test]
    procedure Scale_ThereAndBack_ShouldNotDrift;

    [Test]
    procedure AutoSize_False_ShouldKeepTheGivenSize;

    [Test]
    procedure AutoSize_True_ShouldMeasureAgain;

    // --- Header ---

    [Test]
    procedure DefaultHeaderValues;

    [Test]
    procedure ShowHeader_True_ShouldMakeRoomAbove;

    [Test]
    procedure ShowHeader_LongText_ShouldWidenTheControl;

    [Test]
    procedure HeaderPosition_ShouldNotChangeTheSize;

    // --- Streaming ---

    [Test]
    procedure Stream_RoundTrip_ShouldRestoreEveryPublishedProperty;

    [Test]
    procedure Stream_Defaults_ShouldWriteNoOwnProperty;

    [Test]
    procedure Stream_Load_ShouldNotFireOnChange;

    [Test]
    procedure Stream_HeaderFont_Custom_ShouldRoundTrip;

    [Test]
    procedure Stream_HeaderFont_Default_ShouldNotBeStored;

    [Test]
    procedure Stream_Load_WithShowText_ShouldMeasureAfterLoad;

    [Test]
    procedure Stream_Font_WithHeaderFollowing_ShouldRoundTrip;

    [Test]
    procedure Stream_InsideForm_ShouldRestoreParentAndSize;
  end;

implementation

uses
  System.SysUtils;

const
  // Design pixels the expectations below are written in. Setup pins the
  // control to this scale, so the numbers hold on any machine.
  DesignPPI = 96;
  // Thumb centers and the drag threshold of the component, at DesignPPI
  ThumbOffX = 12;
  ThumbOnX = 32;
  DragThreshold = 4;

procedure TToggleSwitchTest.Setup;
begin
  FForm := TForm.CreateNew(nil);
  FToggle := TFluentToggleSwitch.Create(FForm);
  FToggle.Parent := FForm;
  // Every expectation below is in design pixels, so the suite has to say at
  // which scale it reads them instead of inheriting the machine's
  FToggle.ScaleForPPI(DesignPPI);
end;

procedure TToggleSwitchTest.TearDown;
begin
  FForm.Free;
end;

// The first window, paint and mouse input of the process fill VCL caches
// (screen lists, font handles, focus and hint bookkeeping) that live until
// shutdown. Taking that hit once here keeps the per-test leak monitor
// focused on what each test itself leaves behind. A test that opens a new
// first-time VCL path fails once with a bogus leak: extend this warm-up
// rather than ignore the test.
procedure TToggleSwitchTest.SetupFixture;
var
  Tmp: TFluentToggleSwitch;
  Width: Integer;
begin
  Setup;
  try
    FToggle.ShowText := True;
    Render(FToggle);
    Press(ThumbOffX);
    MoveTo(ThumbOnX);
    Release(ThumbOnX);
    // Destroying a child while its parent lives is a path of its own
    CreateRenderDestroy;
    // Parsing a text DFM brings up the RTL encoding singletons
    Tmp := TFluentToggleSwitch.Create(nil);
    try
      LoadText('object TFluentToggleSwitch'#13#10'  ShowText = True'#13#10'end', Tmp);
    finally
      Tmp.Free;
    end;
    // Streaming a whole form brings up the class registry entry and the
    // reader's path for creating children
    StreamFormWithSwitch(Tmp, Width).Free;
  finally
    TearDown;
  end;
end;

procedure TToggleSwitchTest.Render(Toggle: TFluentToggleSwitch);
var
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  try
    Bmp.SetSize(Toggle.Width, Toggle.Height);
    Toggle.PaintTo(Bmp.Canvas.Handle, 0, 0);
  finally
    Bmp.Free;
  end;
end;

// Painting is what builds the GDI+ objects, so a lifetime worth checking
// has to render
procedure TToggleSwitchTest.CreateRenderDestroy;
var
  Tmp: TFluentToggleSwitch;
begin
  Tmp := TFluentToggleSwitch.Create(nil);
  try
    Tmp.Parent := FForm;
    Tmp.ShowText := True;
    Render(Tmp);
  finally
    Tmp.Free;
  end;
end;

// Mouse messages land at the vertical middle of the control
procedure TToggleSwitchTest.Press(X: Integer);
begin
  FToggle.Perform(WM_LBUTTONDOWN, MK_LBUTTON, MakeLParam(X, FToggle.Height div 2));
end;

procedure TToggleSwitchTest.MoveTo(X: Integer);
begin
  FToggle.Perform(WM_MOUSEMOVE, MK_LBUTTON, MakeLParam(X, FToggle.Height div 2));
end;

procedure TToggleSwitchTest.Release(X: Integer);
begin
  FToggle.Perform(WM_LBUTTONUP, 0, MakeLParam(X, FToggle.Height div 2));
end;

// --- Color tests ---

procedure TToggleSwitchTest.DefaultColorsShouldBeClDefault;
begin
  Assert.AreEqual(TColor(clDefault), FToggle.TrackFrameColor);
  Assert.AreEqual(TColor(clDefault), FToggle.TrackColorOff);
  Assert.AreEqual(TColor(clDefault), FToggle.TrackColorOn);
  Assert.AreEqual(TColor(clDefault), FToggle.ThumbColorOff);
  Assert.AreEqual(TColor(clDefault), FToggle.ThumbColorOn);
end;

procedure TToggleSwitchTest.SetTrackFrameColor_ShouldStoreValue;
begin
  FToggle.TrackFrameColor := clRed;
  Assert.AreEqual(TColor(clRed), FToggle.TrackFrameColor);
end;

procedure TToggleSwitchTest.SetTrackColorOff_ShouldStoreValue;
begin
  FToggle.TrackColorOff := clGreen;
  Assert.AreEqual(TColor(clGreen), FToggle.TrackColorOff);
end;

procedure TToggleSwitchTest.SetTrackColorOn_ShouldStoreValue;
begin
  FToggle.TrackColorOn := clBlue;
  Assert.AreEqual(TColor(clBlue), FToggle.TrackColorOn);
end;

procedure TToggleSwitchTest.SetThumbColorOff_ShouldStoreValue;
begin
  FToggle.ThumbColorOff := clYellow;
  Assert.AreEqual(TColor(clYellow), FToggle.ThumbColorOff);
end;

procedure TToggleSwitchTest.SetThumbColorOn_ShouldStoreValue;
begin
  FToggle.ThumbColorOn := clWhite;
  Assert.AreEqual(TColor(clWhite), FToggle.ThumbColorOn);
end;

// --- Text tests ---

procedure TToggleSwitchTest.DefaultShowText_ShouldBeFalse;
begin
  Assert.IsFalse(FToggle.ShowText);
end;

procedure TToggleSwitchTest.DefaultTextValues;
begin
  Assert.AreEqual('On', FToggle.TextOn);
  Assert.AreEqual('Off', FToggle.TextOff);
end;

procedure TToggleSwitchTest.DefaultTextPosition_ShouldBeTpRight;
begin
  Assert.AreEqual(Ord(tpRight), Ord(FToggle.TextPosition));
end;

procedure TToggleSwitchTest.DefaultTextSpacing_ShouldBe12;
begin
  Assert.AreEqual(12, FToggle.TextSpacing);
end;

procedure TToggleSwitchTest.SetShowText_True_ShouldIncreaseWidth;
var
  WidthBefore: Integer;
begin
  WidthBefore := FToggle.Width;
  FToggle.ShowText := True;
  Assert.IsTrue(FToggle.Width > WidthBefore, 'Width should increase when ShowText is True');
end;

procedure TToggleSwitchTest.SetShowText_False_ShouldResetWidth;
begin
  FToggle.ShowText := True;
  FToggle.ShowText := False;
  Assert.AreEqual(44, FToggle.Width);
end;

procedure TToggleSwitchTest.SetTextPosition_ShouldStoreValue;
begin
  FToggle.TextPosition := tpLeft;
  Assert.AreEqual(Ord(tpLeft), Ord(FToggle.TextPosition));
end;

procedure TToggleSwitchTest.SetTextSpacing_ShouldStoreValue;
begin
  FToggle.TextSpacing := 16;
  Assert.AreEqual(16, FToggle.TextSpacing);
end;

procedure TToggleSwitchTest.SetTextSpacing_Negative_ShouldClampToZero;
begin
  FToggle.TextSpacing := -5;
  Assert.AreEqual(0, FToggle.TextSpacing);
end;

procedure TToggleSwitchTest.SetTextOn_ShouldAffectWidth;
var
  WidthBefore, WidthAfter: Integer;
begin
  FToggle.ShowText := True;
  WidthBefore := FToggle.Width;
  FToggle.TextOn := 'Long text value for testing';
  WidthAfter := FToggle.Width;
  Assert.IsTrue(WidthAfter > WidthBefore, 'Width should increase with longer TextOn');
end;

procedure TToggleSwitchTest.TextPosition_Left_WithShowText_ShouldStoreValue;
begin
  FToggle.ShowText := True;
  FToggle.TextPosition := tpLeft;
  Assert.AreEqual(Ord(tpLeft), Ord(FToggle.TextPosition));
  Assert.IsTrue(FToggle.ShowText, 'ShowText should remain True');
end;

// --- Toggle and event tests ---

procedure TToggleSwitchTest.HandleOnChange(Sender: TObject);
begin
  FOnChangeFired := True;
end;

procedure TToggleSwitchTest.SetTextOn_BeforeParent_ShouldNotRaise;
begin
  Assert.WillNotRaise(
    procedure
    var
      Tmp: TFluentToggleSwitch;
    begin
      Tmp := TFluentToggleSwitch.Create(nil);
      try
        Tmp.ShowText := True;
        Tmp.TextOn := 'Test';
        Tmp.TextOff := 'Off test';
        Tmp.TextPosition := tpLeft;
        Tmp.TextSpacing := 12;
      finally
        Tmp.Free;
      end;
    end, nil, 'Text properties are usable before the control has a parent');
end;

procedure TToggleSwitchTest.Toggle_ShouldChangeChecked;
begin
  Assert.IsFalse(FToggle.Checked);
  FToggle.Checked := True;
  Assert.IsTrue(FToggle.Checked);
  FToggle.Checked := False;
  Assert.IsFalse(FToggle.Checked);
end;

procedure TToggleSwitchTest.SetChecked_ShouldNotFireOnChange;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  FToggle.Checked := True;
  FToggle.Checked := False;
  Assert.IsFalse(FOnChangeFired, 'OnChange is for user actions only');
end;

procedure TToggleSwitchTest.SpaceKey_ShouldNotToggle;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  FToggle.Perform(WM_KEYDOWN, VK_SPACE, 0);
  Assert.IsFalse(FToggle.Checked, 'Keyboard does not toggle the switch');
  Assert.IsFalse(FOnChangeFired, 'OnChange does not fire on keyboard input');
end;

procedure TToggleSwitchTest.DragPastMiddle_ShouldTurnOnAndFireOnChange;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  MoveTo(ThumbOnX);
  Release(ThumbOnX);
  Assert.IsTrue(FToggle.Checked, 'Thumb released past the middle turns the switch on');
  Assert.IsTrue(FOnChangeFired, 'OnChange fires on a user drag');
end;

procedure TToggleSwitchTest.DragShort_ShouldSnapBack;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  MoveTo(ThumbOffX + DragThreshold + 1);
  Release(ThumbOffX + DragThreshold + 1);
  Assert.IsFalse(FToggle.Checked, 'Thumb released before the middle snaps back');
  Assert.IsFalse(FOnChangeFired, 'and nothing changed, so OnChange stays quiet');
end;

procedure TToggleSwitchTest.Click_ShouldToggleAndFireOnChange;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  Release(ThumbOffX);
  Assert.IsTrue(FToggle.Checked, 'A click without any travel toggles the switch');
  Assert.IsTrue(FOnChangeFired, 'and fires OnChange');
end;

procedure TToggleSwitchTest.Click_ReleasedOutside_ShouldNotToggle;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  Release(FToggle.Width + 10);
  Assert.IsFalse(FToggle.Checked, 'A press let go outside the control is no click');
  Assert.IsFalse(FOnChangeFired, 'and fires nothing');
end;

procedure TToggleSwitchTest.Click_OnLabel_ShouldToggle;
begin
  FToggle.ShowText := True;
  // The caption belongs to the control, which is why it is drawn rather than
  // parked in a TLabel: clicking it has to work
  Press(FToggle.Width - 1);
  Release(FToggle.Width - 1);
  Assert.IsTrue(FToggle.Checked, 'Clicking the caption toggles the switch');
end;

procedure TToggleSwitchTest.DragBackPastMiddle_ShouldTurnOffAndFireOnChange;
begin
  FToggle.Checked := True;
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOnX);
  MoveTo(ThumbOffX);
  Release(ThumbOffX);
  Assert.IsFalse(FToggle.Checked, 'Thumb dragged back past the middle turns the switch off');
  Assert.IsTrue(FOnChangeFired, 'and fires OnChange');
end;

procedure TToggleSwitchTest.RightButton_ShouldNotToggle;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  FToggle.Perform(WM_RBUTTONDOWN, MK_RBUTTON, MakeLParam(ThumbOffX, FToggle.Height div 2));
  FToggle.Perform(WM_RBUTTONUP, 0, MakeLParam(ThumbOffX, FToggle.Height div 2));
  Assert.IsFalse(FToggle.Checked, 'Only the left button toggles the switch');
  Assert.IsFalse(FOnChangeFired, 'and fires nothing');
end;

procedure TToggleSwitchTest.Enabled_False_Click_ShouldNotToggle;
begin
  FToggle.Enabled := False;
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  Release(ThumbOffX);
  Assert.IsFalse(FToggle.Checked, 'A disabled switch ignores the pointer');
  Assert.IsFalse(FOnChangeFired, 'and fires nothing');
end;

procedure TToggleSwitchTest.Enabled_False_WhilePressed_ShouldCancelThePress;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  Press(ThumbOffX);
  FToggle.Enabled := False;
  Release(ThumbOffX);
  Assert.IsFalse(FToggle.Checked, 'Being disabled mid-press drops the press');
  Assert.IsFalse(FOnChangeFired, 'and fires nothing');
end;

procedure TToggleSwitchTest.DefaultAnimationDuration_ShouldMatchWinUI;
begin
  Assert.AreEqual(367, FToggle.AnimationDuration, 'Thumb slide lasts as long as in WinUI');
end;

procedure TToggleSwitchTest.AnimationDuration_ShouldClampToPositive;
begin
  FToggle.AnimationDuration := 0;
  Assert.AreEqual(1, FToggle.AnimationDuration, 'Duration never drops below 1 ms');
end;

procedure TToggleSwitchTest.Paint_ShouldNotChangeSize;
var
  W, H: Integer;
begin
  W := FToggle.Width;
  H := FToggle.Height;
  Render(FToggle);
  Assert.AreEqual(W, FToggle.Width, 'Painting leaves the width alone');
  Assert.AreEqual(H, FToggle.Height, 'Painting leaves the height alone');
end;

procedure TToggleSwitchTest.CreateAndDestroy_ShouldNotLeak;
begin
  // The leak itself is caught by the per-test monitor
  Assert.WillNotRaise(
    procedure
    var
      I: Integer;
    begin
      for I := 1 to 50 do
        CreateRenderDestroy;
    end, nil, 'Fifty lifetimes run clean');
end;

procedure TToggleSwitchTest.ParentColor_ShouldBeTrueByDefault;
begin
  Assert.IsTrue(FToggle.ParentColor, 'Background follows the parent');
end;

procedure TToggleSwitchTest.DefaultChecked_ShouldBeFalse;
begin
  Assert.IsFalse(FToggle.Checked);
end;

// --- Scaling tests ---

procedure TToggleSwitchTest.Scale_96_ShouldUseTheDesignSize;
begin
  FToggle.ScaleForPPI(96);
  Assert.AreEqual(44, FToggle.Width);
  Assert.AreEqual(24, FToggle.Height);
end;

procedure TToggleSwitchTest.Scale_120_ShouldGrowWithTheScale;
begin
  FToggle.ScaleForPPI(120);
  Assert.AreEqual(55, FToggle.Width);
  Assert.AreEqual(30, FToggle.Height);
end;

procedure TToggleSwitchTest.Scale_144_ShouldGrowWithTheScale;
begin
  FToggle.ScaleForPPI(144);
  Assert.AreEqual(66, FToggle.Width);
  Assert.AreEqual(36, FToggle.Height);
end;

procedure TToggleSwitchTest.Scale_192_ShouldGrowWithTheScale;
begin
  FToggle.ScaleForPPI(192);
  Assert.AreEqual(88, FToggle.Width);
  Assert.AreEqual(48, FToggle.Height);
end;

// The control used to count the scale itself, multiplying it step by step, so
// a walk across monitors drifted away from the design size
procedure TToggleSwitchTest.Scale_ThereAndBack_ShouldNotDrift;
begin
  FToggle.ScaleForPPI(120);
  FToggle.ScaleForPPI(144);
  FToggle.ScaleForPPI(192);
  FToggle.ScaleForPPI(96);
  Assert.AreEqual(44, FToggle.Width);
  Assert.AreEqual(24, FToggle.Height);
end;

procedure TToggleSwitchTest.AutoSize_False_ShouldKeepTheGivenSize;
begin
  FToggle.AutoSize := False;
  FToggle.SetBounds(0, 0, 100, 50);
  Assert.AreEqual(100, FToggle.Width);
  Assert.AreEqual(50, FToggle.Height);
end;

procedure TToggleSwitchTest.AutoSize_True_ShouldMeasureAgain;
begin
  FToggle.ScaleForPPI(96);
  FToggle.AutoSize := False;
  FToggle.SetBounds(0, 0, 100, 50);
  FToggle.AutoSize := True;
  Assert.AreEqual(44, FToggle.Width);
  Assert.AreEqual(24, FToggle.Height);
end;

// --- Header tests ---

procedure TToggleSwitchTest.DefaultHeaderValues;
begin
  Assert.IsFalse(FToggle.ShowHeader);
  Assert.AreEqual('', FToggle.HeaderText);
  Assert.IsTrue(FToggle.HeaderPosition = hpTop);
  Assert.IsTrue(FToggle.HeaderAlignment = taLeftJustify);
  Assert.AreEqual(7, FToggle.HeaderSpacing);
end;

procedure TToggleSwitchTest.ShowHeader_True_ShouldMakeRoomAbove;
var
  HeightBefore: Integer;
begin
  HeightBefore := FToggle.Height;
  FToggle.HeaderText := 'Header';
  FToggle.ShowHeader := True;
  Assert.IsTrue(FToggle.Height > HeightBefore,
    'Height should grow by the header and its gap');
end;

procedure TToggleSwitchTest.ShowHeader_LongText_ShouldWidenTheControl;
var
  WidthBefore: Integer;
begin
  WidthBefore := FToggle.Width;
  FToggle.HeaderText := 'A header far wider than the switch itself';
  FToggle.ShowHeader := True;
  Assert.IsTrue(FToggle.Width > WidthBefore,
    'A header wider than the row should widen the control');
end;

procedure TToggleSwitchTest.HeaderPosition_ShouldNotChangeTheSize;
var
  W, H: Integer;
begin
  FToggle.HeaderText := 'Header';
  FToggle.ShowHeader := True;
  W := FToggle.Width;
  H := FToggle.Height;
  FToggle.HeaderPosition := hpBottom;
  Assert.AreEqual(W, FToggle.Width);
  Assert.AreEqual(H, FToggle.Height);
end;

// --- Streaming ---

procedure TToggleSwitchTest.CopyThroughStream(Source, Target: TFluentToggleSwitch);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Stream.WriteComponent(Source);
    Stream.Position := 0;
    Stream.ReadComponent(Target);
  finally
    Stream.Free;
  end;
end;

function TToggleSwitchTest.AsText(Source: TFluentToggleSwitch): string;
var
  Binary: TMemoryStream;
  Written: TStringStream;
begin
  Binary := TMemoryStream.Create;
  Written := TStringStream.Create;
  try
    Binary.WriteComponent(Source);
    Binary.Position := 0;
    ObjectBinaryToText(Binary, Written);
    Result := Written.DataString;
  finally
    Written.Free;
    Binary.Free;
  end;
end;

procedure TToggleSwitchTest.LoadText(const Dfm: string; Target: TFluentToggleSwitch);
var
  Source: TStringStream;
  Binary: TMemoryStream;
begin
  Source := TStringStream.Create(Dfm);
  Binary := TMemoryStream.Create;
  try
    ObjectTextToBinary(Source, Binary);
    Binary.Position := 0;
    Binary.ReadComponent(Target);
  finally
    Binary.Free;
    Source.Free;
  end;
end;

// Writes a form holding one switch and reads it back into a fresh form: the
// path every real form takes, where the switch is a child created by the
// reader rather than a root read into an instance of its own. The caller owns
// the form that comes back
function TToggleSwitchTest.StreamFormWithSwitch(out Loaded: TFluentToggleSwitch;
  out SourceWidth: Integer): TForm;
var
  Source: TForm;
  Child: TFluentToggleSwitch;
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    Source := TForm.CreateNew(nil);
    try
      Child := TFluentToggleSwitch.Create(Source);
      Child.Name := 'Switch';
      Child.Parent := Source;
      Child.ShowText := True;
      Child.TextOn := 'Yes';
      SourceWidth := Child.Width;
      Stream.WriteComponent(Source);
    finally
      Source.Free;
    end;
    Stream.Position := 0;
    Result := TForm.CreateNew(nil);
    try
      Stream.ReadComponent(Result);
      Loaded := Result.FindComponent('Switch') as TFluentToggleSwitch;
    except
      Result.Free;
      raise;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_RoundTrip_ShouldRestoreEveryPublishedProperty;
var
  Loaded: TFluentToggleSwitch;
begin
  FToggle.Checked := True;
  FToggle.Animated := False;
  FToggle.AnimationDuration := 100;
  FToggle.TabStop := True;
  FToggle.TrackFrameColor := clRed;
  FToggle.TrackColorOff := clGreen;
  FToggle.TrackColorOn := clBlue;
  FToggle.ThumbColorOff := clYellow;
  FToggle.ThumbColorOn := clPurple;
  FToggle.ShowText := True;
  FToggle.TextOn := 'Yes';
  FToggle.TextOff := 'No';
  FToggle.TextPosition := tpLeft;
  FToggle.TextSpacing := 5;
  FToggle.ShowHeader := True;
  FToggle.HeaderText := 'Header';
  FToggle.HeaderPosition := hpBottom;
  FToggle.HeaderAlignment := taCenter;
  FToggle.HeaderSpacing := 3;
  FToggle.HeaderFont.Style := [fsBold];
  Loaded := TFluentToggleSwitch.Create(nil);
  try
    CopyThroughStream(FToggle, Loaded);
    Assert.IsTrue(Loaded.Checked, 'Checked');
    Assert.IsFalse(Loaded.Animated, 'Animated');
    Assert.AreEqual(100, Loaded.AnimationDuration, 'AnimationDuration');
    Assert.IsTrue(Loaded.TabStop, 'TabStop');
    Assert.AreEqual(TColor(clRed), Loaded.TrackFrameColor, 'TrackFrameColor');
    Assert.AreEqual(TColor(clGreen), Loaded.TrackColorOff, 'TrackColorOff');
    Assert.AreEqual(TColor(clBlue), Loaded.TrackColorOn, 'TrackColorOn');
    Assert.AreEqual(TColor(clYellow), Loaded.ThumbColorOff, 'ThumbColorOff');
    Assert.AreEqual(TColor(clPurple), Loaded.ThumbColorOn, 'ThumbColorOn');
    Assert.IsTrue(Loaded.ShowText, 'ShowText');
    Assert.AreEqual('Yes', Loaded.TextOn, 'TextOn');
    Assert.AreEqual('No', Loaded.TextOff, 'TextOff');
    Assert.AreEqual<TTextPosition>(tpLeft, Loaded.TextPosition, 'TextPosition');
    Assert.AreEqual(5, Loaded.TextSpacing, 'TextSpacing');
    Assert.IsTrue(Loaded.ShowHeader, 'ShowHeader');
    Assert.AreEqual('Header', Loaded.HeaderText, 'HeaderText');
    Assert.AreEqual<THeaderPosition>(hpBottom, Loaded.HeaderPosition, 'HeaderPosition');
    Assert.AreEqual<TAlignment>(taCenter, Loaded.HeaderAlignment, 'HeaderAlignment');
    Assert.AreEqual(3, Loaded.HeaderSpacing, 'HeaderSpacing');
    Assert.IsTrue(fsBold in Loaded.HeaderFont.Style, 'HeaderFont.Style');
  finally
    Loaded.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_Defaults_ShouldWriteNoOwnProperty;
const
  OwnProperties: array[0..19] of string = ('Checked', 'Animated',
    'AnimationDuration', 'TabStop', 'TrackFrameColor', 'TrackColorOff',
    'TrackColorOn', 'ThumbColorOff', 'ThumbColorOn', 'ShowText', 'TextOn',
    'TextOff', 'TextPosition', 'TextSpacing', 'ShowHeader', 'HeaderText',
    'HeaderPosition', 'HeaderAlignment', 'HeaderSpacing', 'HeaderFont');
var
  Dfm: string;
  Name: string;
begin
  Dfm := AsText(FToggle);
  for Name in OwnProperties do
    // HeaderFont streams as HeaderFont.Name and friends, the rest as Name =
    Assert.AreEqual(0, Pos('  ' + Name + ' =', Dfm) + Pos('  ' + Name + '.', Dfm),
      Name + ' stays out of a default DFM');
end;

procedure TToggleSwitchTest.Stream_Load_ShouldNotFireOnChange;
var
  Loaded: TFluentToggleSwitch;
begin
  FToggle.Checked := True;
  Loaded := TFluentToggleSwitch.Create(nil);
  try
    FOnChangeFired := False;
    Loaded.OnChange := HandleOnChange;
    CopyThroughStream(FToggle, Loaded);
    Assert.IsTrue(Loaded.Checked, 'Checked came back from the stream');
    Assert.IsFalse(FOnChangeFired, 'Loading a DFM is not a change');
  finally
    Loaded.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_HeaderFont_Custom_ShouldRoundTrip;
var
  Loaded: TFluentToggleSwitch;
begin
  FToggle.HeaderFont.Style := [fsBold];
  Loaded := TFluentToggleSwitch.Create(nil);
  try
    CopyThroughStream(FToggle, Loaded);
    Assert.IsTrue(fsBold in Loaded.HeaderFont.Style, 'A header font of its own comes back');
    Assert.IsTrue(Pos('  HeaderFont.', AsText(Loaded)) > 0,
      'and is written again, so the load marked it as custom');
  finally
    Loaded.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_HeaderFont_Default_ShouldNotBeStored;
var
  Dfm: string;
begin
  FToggle.Font.Size := 14;
  Dfm := AsText(FToggle);
  Assert.IsTrue(Pos('  Font.', Dfm) > 0, 'The control font itself is written');
  Assert.AreEqual(0, Pos('  HeaderFont.', Dfm),
    'A header font that only follows Font stays out of the DFM');
end;

procedure TToggleSwitchTest.Stream_Load_WithShowText_ShouldMeasureAfterLoad;
var
  Loaded, Reference: TFluentToggleSwitch;
begin
  // Both stay parentless, so nothing but Loaded can measure them
  Reference := TFluentToggleSwitch.Create(nil);
  Loaded := TFluentToggleSwitch.Create(nil);
  try
    Reference.ShowText := True;
    // The size in the DFM is deliberately wrong
    LoadText('object TFluentToggleSwitch'#13#10 +
      '  Width = 10'#13#10 +
      '  Height = 10'#13#10 +
      '  ShowText = True'#13#10 +
      'end', Loaded);
    Assert.AreEqual(Reference.Width, Loaded.Width, 'Loading measures the width');
    Assert.AreEqual(Reference.Height, Loaded.Height, 'and the height');
  finally
    Loaded.Free;
    Reference.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_Font_WithHeaderFollowing_ShouldRoundTrip;
var
  Loaded: TFluentToggleSwitch;
begin
  FToggle.ShowHeader := True;
  FToggle.HeaderText := 'Header';
  FToggle.Font.Size := 14;
  Loaded := TFluentToggleSwitch.Create(nil);
  try
    CopyThroughStream(FToggle, Loaded);
    Assert.AreEqual(14, Loaded.Font.Size, 'The control font comes back');
    Assert.IsFalse(Loaded.ParentFont, 'and stops following the parent');
    Assert.AreEqual(14, Loaded.HeaderFont.Size,
      'A header font of its own was never set, so it follows the loaded font');
    Assert.AreEqual(0, Pos('  HeaderFont.', AsText(Loaded)),
      'and is still not worth writing');
  finally
    Loaded.Free;
  end;
end;

procedure TToggleSwitchTest.Stream_InsideForm_ShouldRestoreParentAndSize;
var
  Target: TForm;
  Loaded: TFluentToggleSwitch;
  SourceWidth: Integer;
begin
  Target := StreamFormWithSwitch(Loaded, SourceWidth);
  try
    Assert.IsNotNull(Loaded, 'The child came back');
    Assert.IsTrue(Loaded.Parent = Target, 'and it belongs to the form that read it');
    Assert.AreEqual('Yes', Loaded.TextOn, 'with its properties');
    Assert.AreEqual(SourceWidth, Loaded.Width, 'and the size it was measured at');
  finally
    Target.Free;
  end;
end;

initialization
  // The reader needs the class by name to create the switch inside a form
  RegisterClass(TFluentToggleSwitch);
  TDUnitX.RegisterTestFixture(TToggleSwitchTest);

end.
