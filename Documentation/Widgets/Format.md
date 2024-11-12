# Format
## Properties

### Separator
###### Format.Separator: ImGui.Separator
A vertical or horizonal line, depending on the context, which visually seperates widgets.

```lua
hasChildren = false
hasState = false
```

### Indent
###### Format.Indent: ImGui.Indent
Indents its child widgets.

```lua
hasChildren = true
hasState = false
Arguments = {
    Width: number? = Iris._config.IndentSpacing -- indent width ammount.
}
```

### SameLine
###### Format.SameLine: ImGui.SameLine
Positions its children in a row, horizontally.

```lua
hasChildren = true
hasState = false
Arguments = {
    Width: number? = Iris._config.ItemSpacing.X, -- horizontal spacing between child widgets.
    VerticalAlignment: Enum.VerticalAlignment? = Enum.VerticalAlignment.Center -- how widgets vertically to each other.
    HorizontalAlignment: Enum.HorizontalAlignment? = Enum.HorizontalAlignment.Center -- how widgets are horizontally.
}
```

### Group
###### Format.Group: ImGui.Group
Layout widget which contains its children as a single group.

```lua
hasChildren = true
hasState = false
```