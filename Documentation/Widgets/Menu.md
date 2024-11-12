# Menu
## Properties

### MenuBar
###### Menu.MenuBar: ImGui.MenuBar
Creates a MenuBar for the current window. Must be called directly under a Window and not within a child widget.

> [!INFO]
> This does not create any menus, just tells the window that we going to add menus within.

```lua
hasChildren = true
hasState = false
```

### Menu
###### Menu.Menu: ImGui.Menu
Creates an collapsable menu. If the Menu is created directly under a MenuBar, then the widget will be placed horizontally below the window title. If the menu Menu is created within another menu, then it will be placed vertically alongside MenuItems and display an arrow alongside.

The opened menu will be a vertically listed box below or next to the button.
> [!INFO]
> There are widgets which are designed for being parented to a menu whilst other happens to work. There is nothing preventing you from adding any widget as a child, but the behaviour is unexplained and not intended, despite allowed. 
```lua
hasChildren = true
hasState = true
Arguments = {
    Text: string -- menu text.
}
Events = {
    clicked: () -> boolean,
    opened: () -> boolean, -- once when opened.
    closed: () -> boolean, -- once when closed.
    hovered: () -> boolean
}
States = {
    isOpened: State<boolean>? -- whether the menu is open, including any sub-menus within.
}
```

### MenuItem
###### Menu.MenuItem: ImGui.MenuItem
Creates a button within a menu. The optional KeyCode and ModiferKey arguments will show the keys next to the title, but will not bind any connection to them. You will need to do this yourself. 

```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string,
    KeyCode: Enum.KeyCode? = nil, -- an optional keycode, does not actually connect an event.
    ModifierKey: Enum.ModifierKey? = nil -- an optional modifer key for the key code.
}
Events = {
    clicked: () -> boolean,
    hovered: () -> boolean
}
```

### MenuToggle
###### Menu.MenuToggle: ImGui.MenuToggle
Creates a togglable button within a menu. The optional KeyCode and ModiferKey arguments act the same as the MenuItem. It is not visually the same as a checkbox, but has the same functionality. 

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string,
    KeyCode: Enum.KeyCode? = nil, -- an optional keycode, does not actually connect an event.
    ModifierKey: Enum.ModifierKey? = nil -- an optional modifer key for the key code.
}
Events = {
    checked: () -> boolean, -- once on check.
    unchecked: () -> boolean, -- once on uncheck.
    hovered: () -> boolean
}
States = {
    isChecked: State<boolean>?
}
```