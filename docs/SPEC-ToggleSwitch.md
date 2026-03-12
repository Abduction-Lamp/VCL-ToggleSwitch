# Техническое задание: TToggleSwitch — VCL-компонент

**Версия:** 1.0
**Дата:** 2026-03-12
**Статус:** Черновик

---

## 1. Цель

Создать VCL-компонент `TToggleSwitch`, визуально приближённый к Windows 11 ToggleSwitch (WinUI 3 / Fluent Design), работающий на **любой версии Windows** (7, 8, 10, 11) без зависимости от системных контролов и тем.

Компонент должен быть доступен в палитре компонентов Delphi IDE, поддерживать drag-and-drop на форму и настройку свойств через Object Inspector — как стандартные VCL-элементы.

---

## 2. Референс: Windows 11 ToggleSwitch (WinUI 3)

### 2.1. Размеры (при 100% DPI, в пикселях)

Источники: WinUI 3 generic.xaml, GitHub Issue microsoft/microsoft-ui-xaml#836.

| Элемент | Параметр | Значение |
|---------|----------|----------|
| **Track (дорожка)** | Ширина | 40 px |
| | Высота | 20 px |
| | Corner Radius | 10 px (полностью скруглённый, pill-shape) |
| | Border Thickness | 1 px (Off), 0 px (On — залит целиком) |
| **Thumb (ползунок)** | Диаметр (Normal) | 12 px |
| | Диаметр (Hover) | 14 px |
| | Диаметр (Pressed) | 17 px (овал, горизонт. растяжение) |
| | Форма | Круг (Ellipse), при нажатии — скруглённый прямоугольник |
| **Отступ thumb от края** | Normal (Off) | Центр thumb на X=10 от левого края track |
| | Normal (On) | Центр thumb на X=30 от левого края track |
| **Touch target** | Минимум | 40 × 40 px (хит-зона больше визуального размера) |

### 2.2. Цвета

Цвета из WinUI 3 Light Theme. В нашей реализации — через собственную палитру.

#### Off State (выключен)

| Элемент | Normal | Hover | Pressed | Disabled |
|---------|--------|-------|---------|----------|
| Track Fill | Transparent | Transparent | #F9F9F9 | Transparent |
| Track Stroke | #878787 | #6B6B6B | #6B6B6B | #CECECE |
| Thumb Fill | #5C5C5C | #1A1A1A | #1A1A1A | #ADADAD |

#### On State (включён)

| Элемент | Normal | Hover | Pressed | Disabled |
|---------|--------|-------|---------|----------|
| Track Fill | AccentColor | AccentDark1 | AccentDark2 | #CECECE |
| Track Stroke | AccentColor | AccentDark1 | AccentDark2 | #CECECE |
| Thumb Fill | #FFFFFF | #FFFFFF | #FFFFFF | #FFFFFF |

> **AccentColor** в Windows 11 по умолчанию: `#0078D4` (синий).
> В нашей реализации AccentColor = `TApperance.Scheme.Blue`.

### 2.3. Визуальные состояния (Visual States)

```
Off.Normal       — ползунок слева, 12px, серая обводка
Off.Hover        — ползунок 14px, обводка темнее
Off.Pressed      — ползунок 17px (растянут), фон слегка заполнен
Off.Disabled     — блёклые цвета

On.Normal        — ползунок справа, 12px, синяя заливка трека
On.Hover         — ползунок 14px, трек чуть темнее
On.Pressed       — ползунок 17px (растянут), трек ещё темнее
On.Disabled      — серая заливка трека
```

### 2.4. Анимация

Источники: WinUI 3 ThemeResources, Microsoft Fluent Design Motion Guidelines.

| Параметр | Значение |
|----------|----------|
| **Длительность перехода On↔Off** | 150–167 мс (`ControlFastAnimationDuration`) |
| **Длительность hover-эффектов** | 83 мс (`ControlFasterAnimationDuration`) |
| **Easing (деселерация)** | cubic-bezier(0, 0, 0, 1) — "fast out, slow in" |
| **Easing (акселерация)** | cubic-bezier(1, 0, 1, 1) — "slow out, fast in" |
| **Что анимируется** | Позиция thumb (X), размер thumb, цвет track fill, цвет track stroke |

Поведение анимации:
1. При клике — thumb плавно скользит от одного края к другому (150 мс, decelerate easing)
2. При hover — thumb плавно увеличивается 12→14 px (83 мс)
3. При нажатии — thumb растягивается до 17 px (83 мс)
4. Цвет трека и ползунка меняется одновременно с позицией

### 2.5. Поведение (UX)

По гайдлайнам Microsoft:

- Toggle switch = **физический выключатель**. Изменение вступает в силу **немедленно**.
- Используется для **бинарных** настроек (вкл/выкл).
- Подпись: короткое существительное (WiFi, Bluetooth, "Кухня"), не глагол.
- **Не использовать**, если нужна отправка формы — для этого CheckBox.
- **Не использовать** для множественного выбора — для этого CheckBox.
- Поддерживает клик мышью, клавишу Space, и touch (drag).

### 2.6. Клавиатура и Accessibility

| Клавиша | Действие |
|---------|----------|
| Tab | Перемещает фокус на/с компонента |
| Space | Переключает состояние |
| Enter | (опционально) Переключает состояние |

Визуальная индикация фокуса — пунктирная или сплошная рамка вокруг компонента.

---

## 3. Архитектура компонента

### 3.1. Иерархия классов

```
TComponent
  └─ TControl
       └─ TWinControl
            └─ TCustomControl    ← Canvas + Handle (получает фокус, Paint)
                 └─ TToggleSwitch
```

`TCustomControl` — оптимальный предок:
- Имеет `Canvas` для GDI-отрисовки
- Имеет Windows Handle (может получать фокус и keyboard-события)
- Стандартный базовый класс для owner-draw VCL компонентов

### 3.2. Published Properties (Object Inspector)

| Свойство | Тип | Default | Описание |
|----------|-----|---------|----------|
| `Checked` | `Boolean` | `False` | Текущее состояние (On/Off) |
| `Animated` | `Boolean` | `True` | Включить/отключить анимацию |
| `AnimationDuration` | `Integer` | `150` | Длительность анимации в мс |
| `Enabled` | `Boolean` | `True` | Доступность (наследуется) |
| `TabStop` | `Boolean` | `True` | Фокусировка Tab |
| `TabOrder` | `Integer` | auto | Порядок табуляции |
| `Color` | `TColor` | `clNone` | Фон за пределами трека (по умолчанию — ParentColor) |

Пока **не** включаем:
- `OnContent`/`OffContent` (текстовые подписи рядом) — может быть добавлено позже
- Кастомные цвета — используем палитру `TApperance`

### 3.3. Events

| Событие | Тип | Описание |
|---------|-----|----------|
| `OnChange` | `TNotifyEvent` | Срабатывает при переключении состояния |
| `OnClick` | `TNotifyEvent` | Наследуется от TControl |

### 3.4. Размеры компонента

Фиксированный размер рисуемой области трека: **40 × 20 px** (как в WinUI 3).

Полный размер компонента (Width × Height) может быть больше для touch-target и удобства размещения. Рекомендуемый минимум: **44 × 24 px**. При установке меньших размеров — ограничение через `SetBounds`/`CanResize`.

Design-time: при размещении на форму — автоматический размер **44 × 24**.

### 3.5. Отрисовка (Paint)

Вся отрисовка через GDI/GDI+:

```
procedure Paint; override;
  1. Заполнить фон (Canvas.Brush.Color := Self.Color / ParentColor)
  2. Нарисовать Track:
     - RoundRect или GDI+ FillPath с pill-shape (CornerRadius = Height/2)
     - Fill + Stroke в зависимости от состояния и hover
  3. Нарисовать Thumb:
     - Ellipse или FillEllipse
     - Позиция X = анимированное значение между Off и On
     - Диаметр = анимированное значение (12/14/17)
```

Для pill-shape (полностью скруглённый прямоугольник) можно использовать:
- `Canvas.RoundRect` (GDI) — простейший вариант
- `GDI+ TGPGraphics` — для anti-aliasing и более качественной отрисовки

**Рекомендация:** GDI+ для качественных скруглённых углов с anti-aliasing.

### 3.6. Анимация (реализация)

```pascal
private
  FAnimTimer: TTimer;         // или WM_TIMER через SetTimer
  FAnimProgress: Single;      // 0.0 (Off) .. 1.0 (On)
  FAnimTarget: Single;        // Целевое значение (0.0 или 1.0)
  FAnimStartTime: Int64;      // QPC-метка старта анимации
  FAnimDuration: Integer;     // мс
```

На каждом тике таймера:
1. Вычислить `Elapsed := (Now - StartTime)` через `QueryPerformanceCounter`
2. Вычислить `T := Elapsed / Duration` (0..1)
3. Применить easing: `T := EaseOut(T)` — `cubic-bezier(0, 0, 0, 1)` ≈ `T := 1 - Power(1 - T, 3)` (кубическая деселерация)
4. Интерполировать `FAnimProgress := Lerp(Start, Target, T)`
5. `Invalidate` → перерисовка

Интервал таймера: **16 мс** (~60 FPS). Использовать `TTimer` (VCL) или `SetTimer` (WinAPI).

### 3.7. Обработка ввода

```pascal
procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  → Установить FPressed := True; Invalidate;

procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  → FPressed := False;
  → if PtInRect(ClientRect, Point(X, Y)) then Toggle;

procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  → Обновить FHovered; Invalidate если изменилось;

procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
  → FHovered := True; Invalidate;

procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
  → FHovered := False; FPressed := False; Invalidate;

procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  → if Key = VK_SPACE then Toggle;
```

---

## 4. Интеграция в палитру Delphi IDE (Design-Time)

### 4.1. Как это работает

В Delphi компоненты устанавливаются через **пакеты** (.dpk/.bpl):
1. Создаётся design-time package (`.dpk`)
2. В нём вызывается `RegisterComponents('LIS', [TToggleSwitch])`
3. Package компилируется в `.bpl` и устанавливается в IDE
4. Компонент появляется во вкладке **"LIS"** палитры компонентов
5. Его можно перетащить на форму, настроить свойства в Object Inspector

### 4.2. Структура файлов

```
ToggleSwitch/                          ← Отдельная папка (или отдельный проект)
├── source/
│   ├── LIS.ToggleSwitch.pas           ← Юнит компонента
│   └── LIS.ToggleSwitch.Reg.pas       ← Процедура Register (design-time)
├── packages/
│   ├── LIS.ToggleSwitch.Delphi12.dpk  ← Design-time package
│   └── LIS.ToggleSwitch.Delphi12.dproj
├── resources/
│   └── LIS.ToggleSwitch.dcr           ← Иконка для палитры (24×24 bitmap)
├── tests/
│   ├── Test.ToggleSwitch.pas           ← Unit-тесты
│   └── ToggleSwitch.Tests.dproj
├── demo/
│   ├── Demo.dpr                        ← Демо-приложение для визуальной проверки
│   ├── Demo.dproj
│   └── MainForm.pas / MainForm.dfm
└── README.md
```

### 4.3. Процедура Register

```pascal
unit LIS.ToggleSwitch.Reg;

interface

procedure Register;

implementation

uses
  System.Classes,
  LIS.ToggleSwitch;

procedure Register;
begin
  RegisterComponents('LIS', [TToggleSwitch]);
end;

end.
```

### 4.4. Package (.dpk)

```pascal
package LIS_ToggleSwitch_Delphi12;

{$DESCRIPTION 'LIS ToggleSwitch Component'}
{$DESIGNONLY}    // Только для IDE, не линкуется в runtime
{$IMPLICITBUILD ON}

requires
  rtl,
  vcl,
  designide;     // Нужен для RegisterComponents

contains
  LIS.ToggleSwitch in '..\source\LIS.ToggleSwitch.pas',
  LIS.ToggleSwitch.Reg in '..\source\LIS.ToggleSwitch.Reg.pas';

end.
```

### 4.5. Иконка для палитры

- Файл: `LIS.ToggleSwitch.dcr` (это переименованный `.res`)
- Содержит bitmap `TTOGGLESWITCH` размером **24 × 24 px**
- Имя ресурса = имя класса в верхнем регистре (`TTOGGLESWITCH`)
- Создаётся в Image Editor (RAD Studio) или внешнем редакторе + RC → BRCC32

### 4.6. Установка

```
1. Открыть packages/LIS.ToggleSwitch.Delphi12.dpk в IDE
2. ПКМ на пакете → Compile
3. ПКМ на пакете → Install
4. Компонент появится во вкладке "LIS" палитры
5. Drag-and-drop на форму, настройка свойств в Object Inspector
```

### 4.7. Использование в проекте LIS

После установки пакета — использование как любого VCL-компонента:

**В Design-time (визуально):**
- Перетащить `TToggleSwitch` из палитры "LIS" на форму
- В Object Inspector: `Checked := True/False`, `Animated := True`, и т.д.
- В Events: назначить обработчик `OnChange`

**В Runtime (программно):**
```pascal
uses
  LIS.ToggleSwitch;

ToggleSwitch1.Checked := True;
ToggleSwitch1.OnChange := HandleToggleChange;
```

---

## 5. Отдельный проект — да или нет?

### Рекомендация: **Да, отдельный проект (папка)**

Причины:

| Фактор | Внутри LIS | Отдельный проект |
|--------|-----------|------------------|
| Design-time package | Нужен отдельный .dpk в любом случае | Чистая структура |
| Переиспользование | Привязан к LIS | Можно использовать в других проектах |
| Тестирование | Тесты в общем пуле LIS | Изолированные тесты + демо-приложение |
| Зависимости | Может случайно зацепить LIS-модули | Zero dependencies (только RTL/VCL) |
| Компиляция | Компилируется с LIS | Компилируется отдельно |

**Вариант реализации:**

```
LIS-master/
├── src/...                          ← Основной проект (не трогаем)
├── components/
│   └── ToggleSwitch/                ← Отдельный компонент
│       ├── source/
│       ├── packages/
│       ├── resources/
│       ├── tests/
│       └── demo/
├── tests/...
└── ...
```

Или как полностью отдельный репозиторий, подключённый через:
- Search Path в настройках проекта LIS
- Или git submodule

**Для начала:** папка `components/ToggleSwitch/` внутри LIS-master — проще, а вынести в отдельный репозиторий можно позже при необходимости.

---

## 6. План реализации

### Этап 1: Базовый компонент (MVP)
- [ ] Класс `TToggleSwitch`, наследник `TCustomControl`
- [ ] Отрисовка track + thumb через GDI (RoundRect + Ellipse)
- [ ] Состояния: Normal, Hover, Pressed, Disabled × On/Off
- [ ] Переключение по клику и Space
- [ ] Published свойство `Checked` + событие `OnChange`
- [ ] Фиксированные цвета (без интеграции с `TApperance`)

### Этап 2: Анимация
- [ ] Плавное перемещение thumb (Timer + Lerp + Easing)
- [ ] Анимация размера thumb при Hover/Pressed
- [ ] Анимация цвета track при переключении

### Этап 3: Качество отрисовки
- [ ] Переход на GDI+ для anti-aliasing
- [ ] Double Buffering (canvas buffer)
- [ ] DPI Awareness (масштабирование размеров)

### Этап 4: Design-time интеграция
- [ ] Процедура Register + .dpk package
- [ ] Иконка палитры (.dcr)
- [ ] Тестовая установка в IDE

### Этап 5: Тесты и демо
- [ ] Unit-тесты (состояния, Toggle, свойства)
- [ ] Демо-приложение для визуальной верификации
- [ ] Тест на Windows 7 / 10 / 11

### Этап 6: Интеграция с LIS
- [ ] Привязка цветов к `TApperance.Scheme`
- [ ] Использование в формах LIS
- [ ] Обновление Search Path проекта

---

## 7. Зависимости

| Зависимость | Обязательная | Описание |
|-------------|--------------|----------|
| RTL | Да | System, SysUtils, Classes |
| VCL | Да | Controls, Graphics, Forms |
| GDI+ (Winapi.GDIPOBJ) | Рекомендуется | Anti-aliased отрисовка |
| TApperance | Нет (этап 6) | Цветовая схема LIS |
| DesignIDE | Только design-time | Для RegisterComponents |

Zero внешних зависимостей. Только стандартные модули Delphi.

---

## Источники

- [Guidelines for toggle switch controls — Microsoft Learn](https://learn.microsoft.com/en-us/windows/apps/develop/ui/controls/toggles)
- [Timing and easing — Microsoft Learn](https://learn.microsoft.com/en-us/windows/apps/design/motion/timing-and-easing)
- [Motion in practice — Microsoft Learn](https://learn.microsoft.com/en-us/windows/apps/design/motion/motion-in-practice)
- [Spacing and Sizes — Microsoft Learn](https://learn.microsoft.com/en-us/windows/apps/design/style/spacing)
- [WinUI 3 ToggleSwitch width update (Issue #836)](https://github.com/microsoft/microsoft-ui-xaml/issues/836)
- [WinUI 3 ToggleSwitch sizing (Q&A)](https://learn.microsoft.com/en-us/answers/questions/1465788/winui-3-toggleswitch-height-and-internal-padding-s)
- [ToggleSwitch brush resources (Issue #7225)](https://github.com/microsoft/microsoft-ui-xaml/issues/7225)
- [Windows 11 UI Kit — Figma](https://www.figma.com/community/file/1083153685442292050/windows-11-ui-kit)
- [Windows UI Kit (Official) — Figma](https://www.figma.com/community/file/1440832812269040007/windows-ui-kit)
- [Fluent 2 Design System — Motion](https://fluent2.microsoft.design/motion)
- [ModernWpf ToggleSwitch XAML template](https://github.com/Kinnara/ModernWpf/blob/master/ModernWpf.Controls/ToggleSwitch/ToggleSwitch.xaml)
