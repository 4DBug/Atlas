return {
    Type = "Window",
    Name = "Test",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Callback = function()
        ImGui:Connect(function()
            ImGui.Window({"Lorem Ipsum"})
                ImGui.Text({"Lorem Ipsum odor amet."})
            ImGui.End()
        end)
    end
}