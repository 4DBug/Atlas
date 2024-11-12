# Window
Windows are the fundamental widget for ImGui. Every other widget must be a descendant of a window.

```lua
Iris.Window({ "Example Window" })
    Iris.Text({ "This is an example window!" })
Iris.End()
```
```lua
Iris.RenderMarkup({"Window", {{"Example Window"}}, {
    {"Text", {{"This is an example window!"}}}
}})
```

If you do not want the code inside a window to run unless it is open then you can use the following:
```lua
local window = Iris.Window({ "Many Widgets Window" })

if window.state.isOpened.value and window.state.isUncollapsed.value then
    Iris.Text({ "I will only be created when the window is open." })
end
Iris.End() -- must always call Iris.End(), regardless of whether the window is open or not.
```

## Properties

### Window
###### Window.Window: ImGui.Window
The top-level container for all other widgets to be created within. Can be moved and resized across the screen. Cannot contain embedded windows. Menus can be appended to windows creating a menubar. 
```lua
hasChildren = true
hasState = true
Arguments = {
    Title: string,
    NoTitleBar: boolean? = false,
    NoBackground: boolean? = false, -- the background behind the widget container.
    NoCollapse: boolean? = false,
    NoClose: boolean? = false,
    NoMove: boolean? = false,
    NoScrollbar: boolean? = false, -- the scrollbar if the window is too short for all widgets.
    NoResize: boolean? = false,
    NoNav: boolean? = false, -- unimplemented.
    NoMenu: boolean? -- whether the menubar will show if created.
}
Events = {
    opened: () -> boolean, -- once when opened.
    closed: () -> boolean, -- once when closed.
    collapsed: () -> boolean, -- once when collapsed.
    uncollapsed: () -> boolean, -- once when uncollapsed.
    hovered: () -> boolean -- fires when the mouse hovers over any of the window.
}
States = {
    size = State<Vector2>? = Vector2.new(400, 300),
    position = State<Vector2>?,
    isUncollapsed = State<boolean>? = true,
    isOpened = State<boolean>? = true,
    scrollDistance = State<number>? -- vertical scroll distance, if too short.
}
```

### Tooltip
###### Window.Tooltip: ImGui.Tooltip
Displays a text label next to the cursor
```lua
Iris.Tooltip({"My custom tooltip"})
```
```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string
}
```