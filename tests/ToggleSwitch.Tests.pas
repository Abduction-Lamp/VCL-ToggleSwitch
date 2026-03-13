unit ToggleSwitch.Tests;

interface

uses
  DUnitX.TestFramework,
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
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    // --- Color properties ---

    [Test]
    procedure DefaultColorsShouldBeClNone;

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
    procedure DefaultTextSpacing_ShouldBe8;

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
    procedure SetChecked_ShouldFireOnChange;

    [Test]
    procedure DefaultChecked_ShouldBeFalse;
  end;

implementation

uses
  System.SysUtils;

procedure TToggleSwitchTest.Setup;
begin
  FForm := TForm.CreateNew(nil);
  FToggle := TFluentToggleSwitch.Create(FForm);
  FToggle.Parent := FForm;
end;

procedure TToggleSwitchTest.TearDown;
begin
  FForm.Free;
end;

// --- Color tests ---

procedure TToggleSwitchTest.DefaultColorsShouldBeClNone;
begin
  Assert.AreEqual(TColor(clNone), FToggle.TrackFrameColor);
  Assert.AreEqual(TColor(clNone), FToggle.TrackColorOff);
  Assert.AreEqual(TColor(clNone), FToggle.TrackColorOn);
  Assert.AreEqual(TColor(clNone), FToggle.ThumbColorOff);
  Assert.AreEqual(TColor(clNone), FToggle.ThumbColorOn);
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

procedure TToggleSwitchTest.DefaultTextSpacing_ShouldBe8;
begin
  Assert.AreEqual(8, FToggle.TextSpacing);
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
var
  Tmp: TFluentToggleSwitch;
begin
  Tmp := TFluentToggleSwitch.Create(nil);
  try
    // Should not raise "Control has no parent window"
    Tmp.ShowText := True;
    Tmp.TextOn := 'Test';
    Tmp.TextOff := 'Off test';
    Tmp.TextPosition := tpLeft;
    Tmp.TextSpacing := 12;
    Assert.IsTrue(True, 'No exception raised');
  finally
    Tmp.Free;
  end;
end;

procedure TToggleSwitchTest.Toggle_ShouldChangeChecked;
begin
  Assert.IsFalse(FToggle.Checked);
  FToggle.Checked := True;
  Assert.IsTrue(FToggle.Checked);
  FToggle.Checked := False;
  Assert.IsFalse(FToggle.Checked);
end;

procedure TToggleSwitchTest.SetChecked_ShouldFireOnChange;
begin
  FOnChangeFired := False;
  FToggle.OnChange := HandleOnChange;
  FToggle.Checked := True;
  Assert.IsTrue(FOnChangeFired, 'OnChange should fire when Checked changes');
end;

procedure TToggleSwitchTest.DefaultChecked_ShouldBeFalse;
begin
  Assert.IsFalse(FToggle.Checked);
end;

initialization
  TDUnitX.RegisterTestFixture(TToggleSwitchTest);

end.
