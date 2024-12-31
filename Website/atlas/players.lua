
local Players = game:GetService("Players")

return {
    Type = "Window",
    Name = "Players",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function(Executor, deltaTime)
        local TextHeight = ImGui._config.TextSize + 2 * ImGui._config.FramePadding.Y

        for _, Player in next, Players:GetPlayers() do
            ImGui.SameLine()
                ImGui.Image({
                    string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150", Player.UserId),
                    UDim2.fromOffset(TextHeight, TextHeight), Rect.new(0, 0, 0, 0), Enum.ScaleType.Stretch, false
                })

                ImGui.Text(Player.Name)

                ImGui.SameLine({nil, nil, Enum.HorizontalAlignment.Right})
                    ImGui.Button({"Spectate"})

                    if ImGui.Button({"Goto"}).clicked() then
                        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame
                    end

                    if ImGui.Button({"Fling"}).clicked() then

                    end

                    ImGui.Button({"More"})

                    ImGui.Text(Player.Name)

                    ImGui.Image({
                        string.format("rbxthumb://type=AvatarHeadShot&id=%s&w=150&h=150", Player.UserId),
                        UDim2.fromOffset(TextHeight, TextHeight), Rect.new(0, 0, 0, 0), Enum.ScaleType.Stretch, false
                    })
                ImGui.End()
            ImGui.End()
        end
    end
}