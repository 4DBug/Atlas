# Basic
## Properties

### Button
###### Basic.Button: ImGui.Button
A clickable button the size of the text with padding. Can listen to the clicked() event to determine if it was pressed.

```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string,
    Size: UDim2? = 0,
}
Events = {
    clicked: () -> boolean,
    rightClicked: () -> boolean,
    doubleClicked: () -> boolean,
    ctrlClicked: () -> boolean, -- when the control key is down and clicked.
    hovered: () -> boolean
}
```

### SmallButton
###### Basic.SmallButton: ImGui.SmallButton
A smaller clickable button, the same as a ImGui.Button but without padding. Can listen to the clicked() event to determine if it was pressed.

```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string,
    Size: UDim2? = 0,
}
Events = {
    clicked: () -> boolean,
    rightClicked: () -> boolean,
    doubleClicked: () -> boolean,
    ctrlClicked: () -> boolean, -- when the control key is down and clicked.
    hovered: () -> boolean
}
```

### Checkbox
###### Basic.Checkbox: ImGui.Checkbox
A checkable box with a visual tick to represent a boolean true or false state.

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string
}
Events = {
    checked: () -> boolean, -- once when checked.
    unchecked: () -> boolean, -- once when unchecked.
    hovered: () -> boolean
}
State = {
    isChecked = State<boolean>? -- whether the box is checked.
}
```

### RadioButton
###### Basic.RadioButton: ImGui.RadioButton
A circular selectable button, changing the state to its index argument. Used in conjunction with multiple other RadioButtons sharing the same state to represent one value from multiple options.

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string,
    Index: any -- the state object is set to when clicked.
}
Events = {
    selected: () -> boolean,
    unselected: () -> boolean,
    active: () -> boolean, -- if the state index equals the RadioButton's index.
    hovered: () -> boolean
}
State = {
    index = State<any>? -- the state set by the index of a RadioButton.
}
```