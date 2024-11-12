# Tab
## Properties

### TabBar
###### Tab.TabBar: ImGui.TabBar
Creates a TabBar for putting tabs under. This does not create the tabs but just the container for them to be in. The index state is used to control the current tab and is based on an index starting from 1 rather than the text provided to a Tab. The TabBar will replicate the index to the Tab children. 

```lua
hasChildren: true
hasState: true
Arguments = {}
Events = {}
State = {
    index: State<number>? -- whether the widget is collapsed.
}
```

### Tab
###### Tab.Tab: ImGui.Tab
The tab item for use under a TabBar. The TabBar must be the parent and determines the index value. You cannot provide a state for this tab. The optional Hideable argument determines if a tab can be closed, which is controlled by the isOpened state.

A tab will take up the full horizontal width of the parent and hide any other tabs in the TabBar.

```lua
hasChildren: true
hasState: true
Arguments = {
    Text: string,
    Hideable: boolean? = nil -- determines whether a tab can be closed/hidden
}
Events = {
    clicked: () -> boolean,
    hovered: () -> boolean
    selected: () -> boolean
    unselected: () -> boolean
    active: () -> boolean
    opened: () -> boolean
    closed: () -> boolean
}
State = {
    isOpened: State<boolean>?
}
```
