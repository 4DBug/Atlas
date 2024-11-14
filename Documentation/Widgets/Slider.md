# Slider
A draggable widget with a visual bar constrained between a min and max for each datatype. Allows direct typing input but also dragging the slider by clicking and holding anywhere in the box.

See Input for more details on the arguments.
## Properties

### SliderNum
###### Slider.SliderNum: ImGui.SliderNum
A field which allows the user to slide a grip to enter a number within a range. You can ctrl + click to directly input a number, like InputNum. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderNum",
    Increment: number? = 1,
    Min: number? = 0,
    Max: number? = 100,
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<number>?,
    editingText: State<boolean>?
}
```

### SliderVector2
###### Slider.SliderVector2: ImGui.SliderVector2
A field which allows the user to slide a grip to enter a Vector2 within a range. You can ctrl + click to directly input a Vector2, like InputVector2. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderVector2",
    Increment: Vector2? = { 1, 1 },
    Min: Vector2? = { 0, 0 },
    Max: Vector2? = { 100, 100 },
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<Vector2>?,
    editingText: State<boolean>?
}
```

### SliderVector3
###### Slider.SliderVector3: ImGui.SliderVector3
A field which allows the user to slide a grip to enter a Vector3 within a range. You can ctrl + click to directly input a Vector3, like InputVector3. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderVector3",
    Increment: Vector3? = { 1, 1, 1 },
    Min: Vector3? = { 0, 0, 0 },
    Max: Vector3? = { 100, 100, 100 },
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<Vector3>?,
    editingText: State<boolean>?
}
```

### SliderUDim
###### Slider.SliderUDim: ImGui.SliderUDim
A field which allows the user to slide a grip to enter a UDim within a range. You can ctrl + click to directly input a UDim, like InputUDim. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderUDim",
    Increment: UDim? = { 0.01, 1 },
    Min: UDim? = { 0, 0 },
    Max: UDim? = { 1, 960 },
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<UDim>?,
    editingText: State<boolean>?
}
```

### SliderUDim2
###### Slider.SliderUDim2: ImGui.SliderUDim2
A field which allows the user to slide a grip to enter a UDim2 within a range. You can ctrl + click to directly input a UDim2, like InputUDim2. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderUDim2",
    Increment: UDim2? = { 0.01, 1, 0.01, 1 },
    Min: UDim2? = { 0, 0, 0, 0 },
    Max: UDim2? = { 1, 960, 1, 960 },
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<UDim2>?,
    editingText: State<boolean>?
}
```

### SliderRect
###### Slider.SliderRect: ImGui.SliderRect
A field which allows the user to slide a grip to enter a Rect within a range. You can ctrl + click to directly input a Rect, like InputRect. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "SliderRect",
    Increment: Rect? = { 1, 1, 1, 1 },
    Min: Rect? = { 0, 0, 0, 0 },
    Max: Rect? = { 960, 960, 960, 960 },
    Format: string? | { string }? = [DYNAMIC] -- ImGui will dynamically generate an approriate format.
}
Events = {
    numberChanged: () -> boolean,
    hovered: () -> boolean
}
States = {
    number: State<Rect>?,
    editingText: State<boolean>?
}
```