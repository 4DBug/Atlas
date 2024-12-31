
return {
    Type = "Widget",
    Name = "Custom Widget",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Creator = "4DBug",
    Widgets = {
        {
            Name = "Custom",
            Constructor = {
                hasState = false,
                hasChildren = false,
                Args = {
                    ["Color"] = 1
                },
                Events = {},
                Generate = function(Widget)
                    local Custom = Instance.new("Frame")
                    Custom.Name = "ImGui_Custom"
                    Custom.Size = UDim2.fromOffset(300, 300)
                    Custom.BackgroundTransparency = 0
                    Custom.BackgroundColor3 = Color3.new(1, 0, 0)
                    Custom.BorderSizePixel = 0
                    Custom.ZIndex = Widget.ZIndex
                    Custom.LayoutOrder = Widget.ZIndex
            
                    return Custom
                end,
                Update = function(Widget)
                    local Custom = Widget.Instance
            
                    Custom.BackgroundColor3 = Widget.arguments.Color
                end,
                Discard = function(Widget)
                    Widget.Instance:Destroy()
                end
            }
        }
    }
}
