# TToggleSwitch

A VCL component for Delphi that replicates the look and behavior of the Windows 11 ToggleSwitch (WinUI 3 / Fluent Design).

Works on **any version of Windows** (7, 8, 10, 11) with no dependency on system controls or themes. Fully custom-drawn via GDI+.

## Why

Standard VCL does not include a toggle switch. Existing third-party solutions either look outdated or pull in external dependencies. This component:

- Looks like a native Windows 11 toggle — pill-shape track, round thumb, smooth animation
- Independent of Windows version and system theme
- Zero external dependencies — only RTL, VCL, GDI+
- Installs into the Delphi IDE component palette as a standard component

## Features

- Smooth On/Off transition animation (EaseOutCubic, 150 ms) with position and color interpolation
- 8 visual states: Normal / Hover / Pressed / Disabled × On / Off
- WinUI 3 Light Theme color scheme (AccentColor `#0078D4`)
- Mouse support (click, hover, pressed) and keyboard support (Space, Enter, Tab)
- Anti-aliased rendering via GDI+
- DoubleBuffered — flicker-free

## Requirements

- **Delphi 12.1** (RAD Studio 12.1 Athens) or compatible version
- Platform: **Win32**

## Project Structure

```
source/ToggleSwitch.pas         — component source code
packages/ToggleSwitch.dpk       — design-time package for IDE installation
demo/Demo.dpr                   — demo application
tests/Tests.dpr                 — test project (DUnitX)
ToggleSwitch-PG.groupproj       — project group (package + demo + tests)
docs/SPEC-ToggleSwitch.md       — technical specification
```

## Quick Start

### 1. Clone the repository

```
git clone https://github.com/Abduction-Lamp/VCL-ToggleSwitch.git
```

### 2. Open in Delphi IDE

Open the project group file:

```
ToggleSwitch-PG.groupproj
```

This will load all three projects: package, demo, and tests.

### 3. Install the component into the IDE palette

1. In Project Manager, find the **ToggleSwitch.bpl** project (packages)
2. Right-click → **Compile**
3. Right-click → **Install**
4. The component `TToggleSwitch` will appear in the **"ToggleSwitch"** tab of the component palette

### 4. Run the demo

1. In Project Manager, select the **Demo** project
2. Right-click → **Set as Active Project**
3. **Run** (F9)

The demo includes 5 toggle variants: default, initially on, disabled off, disabled on, and no animation.

## Usage

### Design-time (visual)

After installing the package:
1. Drag `TToggleSwitch` from the **"ToggleSwitch"** palette tab onto your form
2. Configure properties in the Object Inspector
3. Assign an `OnChange` event handler

### Runtime (programmatic)

```pascal
uses
  ToggleSwitch;

// Creation
var
  Toggle: TToggleSwitch;
begin
  Toggle := TToggleSwitch.Create(Self);
  Toggle.Parent := Self;
  Toggle.Left := 20;
  Toggle.Top := 20;
  Toggle.OnChange := HandleToggleChange;
end;

// Handling state change
procedure TForm1.HandleToggleChange(Sender: TObject);
begin
  if TToggleSwitch(Sender).Checked then
    ShowMessage('On')
  else
    ShowMessage('Off');
end;
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `Checked` | `Boolean` | `False` | Toggle state (On/Off) |
| `Animated` | `Boolean` | `True` | Enable smooth transition animation |
| `AnimationDuration` | `Integer` | `150` | Animation duration in milliseconds |
| `Enabled` | `Boolean` | `True` | Whether the component is interactive |
| `TabStop` | `Boolean` | `True` | Include in Tab key navigation |
| `Color` | `TColor` | `clNone` | Background color (clNone = parent color) |

## Events

| Event | Type | Description |
|-------|------|-------------|
| `OnChange` | `TNotifyEvent` | Fires when the toggle state changes |
| `OnClick` | `TNotifyEvent` | Standard click event (inherited) |

## Keyboard

| Key | Action |
|-----|--------|
| `Tab` | Move focus to/from the component |
| `Space` | Toggle state |
| `Enter` | Toggle state |

## Adding to an Existing Project (without IDE installation)

If you prefer not to install the package, add the source path directly:

1. Open your project in Delphi
2. Go to **Project → Options → Delphi Compiler → Search Path**
3. Add the path to the `source/` folder of this repository
4. Add `uses ToggleSwitch;` to the desired unit

## License

MIT
