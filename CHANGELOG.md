# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-09-10

### Changed

- Drawing reuses one path, one brush and one pen instead of allocating seven to eight GDI+ objects per frame. At 60 frames per second that removed roughly 450 allocations per second per animating switch.
- The animation timer, and the hidden window it owns, are created on first use rather than for every instance. A form full of switches no longer pays for timers nothing has started.
- Animations no longer run while the switch is not showing, for example on an inactive tab page. The state applies immediately instead.
- Text height is measured when the font or the text changes rather than on every frame, and the font is assigned to the canvas once per paint instead of twice. Vertical centering now uses the same metric the auto-sizing uses.
- The track is positioned on whole pixels so its outline stays crisp when the text makes the control an odd number of pixels tall.
- Fully transparent fills and strokes are skipped instead of being rasterized.

## [1.4.0] - 2026-09-10

### Fixed

- A click that nudged the pointer by less than the drag threshold left the thumb permanently offset by those few pixels.
- Disabling the component while it was pressed left it stuck in the pressed state, because a disabled window never receives the matching mouse release.
- A DPI change measured the layout once at the old scale before correcting itself.

### Changed

- Animation timings now follow the WinUI template. The thumb waits 33 ms, then slides for 367 ms along a cubic Bezier curve, replacing the previous 150 ms ease-out. `AnimationDuration` now defaults to 367.
- Hover, press and disabled changes cross-fade over 83 ms (250 ms into disabled) instead of taking effect instantly. Thumb size and position animate along with the colors.
- The On track uses the accent color configured in Windows, read from the system palette. Without it the component falls back to `#0067C0`, the Windows 11 default.
- Hover and press lighten the On track toward the background by lowering opacity to 0.9 and 0.8. Previously they darkened it, which is the opposite of the WinUI behavior. The previous shades came from the Windows 10 palette.

## [1.3.0] - 2026-09-10

### Added

- The thumb can be dragged within the track. Releasing it past the middle switches the state; otherwise it snaps back.
- The pressed thumb stretches into a 17×14 pill hugging the track edge, as in WinUI 3.

### Changed

- Off-state colors follow the WinUI 3 Light theme: translucent fill, stroke and thumb are blended over the parent background. Hover darkens the track fill instead of the stroke and thumb.
- Off and On tracks cross-fade during the transition instead of interpolating colors.
- The track stroke is centered on the outline and scaled with DPI. Previously it was a fixed 1 px inset stroke.
- `OnChange` fires only when the user toggles the switch. Setting `Checked` in code no longer raises it.
- Clicking anywhere on the component, including the text label, toggles it and focuses the control.
- Sizes are recomputed from the base constants on every DPI change instead of rescaling rounded values.

### Removed

- Space and Enter no longer toggle the switch.
- The focus rectangle.

## [1.2.0] - 2026-03-13

### Added

- Tests for the no-parent scenario, toggle logic, `OnChange` firing and default state.
- Demo screenshot in the README.

### Changed

- The demo computes its layout from control heights, so nothing overlaps on high-DPI displays.
- Platform list updated to Win32/Win64.

### Fixed

- DPI-aware scaling: correct rendering on high-DPI displays (per-monitor V2).
- Text properties can be set before `Parent` is assigned.
- Space and Enter fire `OnClick` in addition to `OnChange`.
- The background uses the parent color when `Color` is `clNone`.
- Only the track responds to clicks; the text label is passive.
- Compiler warnings: missing units and unused variables.

## [1.1.0] - 2026-03-12

### Added

- Color properties `TrackFrameColor`, `TrackColorOff`, `TrackColorOn`, `ThumbColorOff` and `ThumbColorOn`. `clNone` keeps the built-in scheme.
- Text label: `ShowText`, `TextOn`, `TextOff`, `TextPosition` and `TextSpacing`. The component auto-sizes to the text.
- `Font` republished for the text label.
- 17 DUnitX tests covering color and text properties, auto-sizing and input validation.

### Fixed

- The click area is restricted to the track.
- Bounds are recalculated after DPI scaling (`ChangeScale`).
- Negative `TextSpacing` is clamped to 0.
- The test runner waits for input before closing; FastMM4 is compiled conditionally.

## [1.0.1] - 2026-03-12

### Added

- README with setup instructions.
- MIT license.

### Fixed

- `TToggleSwitch` renamed to `TFluentToggleSwitch` to avoid the conflict with `Vcl.WinXCtrls`.
- Compiled units go to the global Dcp directory, so `uses ToggleSwitch;` works without a Search Path entry.

## [1.0.0] - 2026-03-12

First public release: GDI+ rendering, EaseOutCubic animation, 8 visual states, WinUI 3 Light colors, mouse and keyboard input, design-time package.

[1.5.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/Abduction-Lamp/VCL-ToggleSwitch/releases/tag/v1.0.0
