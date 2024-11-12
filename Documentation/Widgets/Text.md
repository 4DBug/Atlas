# Text
## Properties

### Text
###### Text.Text: ImGui.Text
A text label to display the text argument. The Wrapped argument will make the text wrap around if it is cut off by its parent. The Color argument will change the color of the text, by default it is defined in the configuration file. 

```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string,
    Wrapped: boolean? = [CONFIG] = false, -- whether the text will wrap around inside the parent container. If not specified, then equal to the config
    Color: Color3? = Iris._config.TextColor, -- the colour of the text.
    RichText: boolean? = [CONFIG] = false -- enable RichText. If not specified, then equal to the config
}
Events = {
    hovered: () -> boolean
}
```

### SeparatorText
###### Text.SeparatorText: ImGui.SeparatorText
Similar to ImGui.Separator but with a text label to be used as a header when an ImGui.Tree or ImGui.CollapsingHeader is not appropriate.

Visually a full width thin line with a text label clipping out part of the line.

```lua
hasChildren = false
hasState = false
Arguments = {
    Text: string
}
```

### InputText
###### Text.InputText: ImGui.InputText
A field which allows the user to enter text.

```lua
hasChildren = false
hasState = true
Arguments = {
    Text: string? = "InputText",
    TextHint: string? = "", -- a hint to display when the text box is empty.
    ReadOnly: boolean? = false,
    MultiLine: boolean? = false
}
Events = {
    textChanged: () -> boolean, -- whenever the textbox looses focus and a change was made.
    hovered: () -> boolean
}
States = {
    text: State<string>?
}
```
