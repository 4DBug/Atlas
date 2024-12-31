
return {
    Type = "Window",
    Name = "Test",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function()
        ImGui.Text({"Lorem Ipsum odor amet."})
        ImGui.Custom(Color3.fromHSV(os.clock() % 1, 1, 1))
    end
}