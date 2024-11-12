# Image
## Properties

### Image
###### Image.Image: ImGui.Image
An image widget for displaying an image given its texture ID and a size. The widget also supports Rect Offset and Size allowing cropping of the image and the rest of the ScaleType properties. Some of the arguments are only used depending on the ScaleType property, such as TileSize or Slice which will be ignored.

```lua
hasChildren = false
hasState = false
Arguments = {
    Image: string, -- the texture asset id
    Size: UDim2,
    Rect: Rect? = Rect.new(), -- Rect structure which is used to determine the offset or size. An empty, zeroed rect is equivalent to nil
    ScaleType: Enum.ScaleType? = Enum.ScaleType.Stretch, -- used to determine whether the TileSize, SliceCenter and SliceScale arguments are used
    ResampleMode: Enum.ResampleMode? = Enum.ResampleMode.Default,
    TileSize: UDim2? = UDim2.fromScale(1, 1), -- only used if the ScaleType is set to Tile
    SliceCenter: Rect? = Rect.new(), -- only used if the ScaleType is set to Slice
    SliceScale: number? = 1 -- only used if the ScaleType is set to Slice
}
Events = {
    hovered: () -> boolean
}
```

### ImageButton
###### Image.ImageButton: ImGui.ImageButton
An image button widget for a button as an image given its texture ID and a size. The widget also supports Rect Offset and Size allowing cropping of the image, and the rest of the ScaleType properties. Supports all of the events of a regular button. 

```lua
hasChildren = false
hasState = false
Arguments = {
    Image: string, -- the texture asset id
    Size: UDim2,
    Rect: Rect? = Rect.new(), -- Rect structure which is used to determine the offset or size. An empty, zeroed rect is equivalent to nil
    ScaleType: Enum.ScaleType? = Enum.ScaleType.Stretch, -- used to determine whether the TileSize, SliceCenter and SliceScale arguments are used
    ResampleMode: Enum.ResampleMode? = Enum.ResampleMode.Default,
    TileSize: UDim2? = UDim2.fromScale(1, 1), -- only used if the ScaleType is set to Tile
    SliceCenter: Rect? = Rect.new(), -- only used if the ScaleType is set to Slice
    SliceScale: number? = 1 -- only used if the ScaleType is set to Slice
}
Events = {
    clicked: () -> boolean,
    rightClicked: () -> boolean,
    doubleClicked: () -> boolean,
    ctrlClicked: () -> boolean, -- when the control key is down and clicked.
    hovered: () -> boolean
}
```
