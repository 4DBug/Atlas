# Tree
## Properties

### Tree
###### Tree.Tree: ImGui.Tree
A collapsable container for other widgets, to organise and hide widgets when not needed. The state determines whether the child widgets are visible or not. Clicking on the widget will collapse or uncollapse it.

```lua
hasChildren: true
hasState: true
Arguments = {
    Text: string,
    SpanAvailWidth: boolean? = false, -- the tree title will fill all horizontal space to the end its parent container.
    NoIndent: boolean? = false -- the child widgets will not be indented underneath.
}
Events = {
    collapsed: () -> boolean,
    uncollapsed: () -> boolean,
    hovered: () -> boolean
}
State = {
    isUncollapsed: State<boolean>? -- whether the widget is collapsed.
}
```

### CollapsingHeader
###### Tree.CollapsingHeader: ImGui.CollapsingHeader
The same as a Tree Widget, but with a larger title and clearer, used mainly for organsing widgets on the first level of a window.

```lua
hasChildren: true
hasState: true
Arguments = {
    Text: string
}
Events = {
    collapsed: () -> boolean,
    uncollapsed: () -> boolean,
    hovered: () -> boolean
}
State = {
    isUncollapsed: State<boolean>? -- whether the widget is collapsed.
}
```