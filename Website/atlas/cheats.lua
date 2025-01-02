
return {
    Type = "Window",
    Name = "Cheats",
    Description = "Shitty temporary Cheats UI",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function()
        local WalkSpeed = ImGui.State(16)
        local JumpPower = ImGui.State(50)

        ImGui.TabBar()
            ImGui.Tab({"Aimbot"})
                ImGui.Text("Lorem Ipsum")
            ImGui.End()

            ImGui.Tab({"ESP & Chams"})
                ImGui.Text("Lorem Ipsum")
            ImGui.End()

            ImGui.Tab({"Character"})
                ImGui.SliderNum({ "Walk Speed", 1, 0, 250 }, { number = WalkSpeed })
                ImGui.SliderNum({ "Jump Power", 1, 0, 250 }, { number = JumpPower })
                
                pcall(function()
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed:get()
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = JumpPower:get()
                end)

                ImGui.Checkbox({"Lag Switch"})
            ImGui.End()
        ImGui.End()
    end
}


