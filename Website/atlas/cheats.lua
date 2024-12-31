
return {
    Type = "Window",
    Name = "Cheats",
    Description = "Shitty temporary Cheats UI",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function()
        local WalkSpeed = ImGui.State(16)

        ImGui.SliderNum({ "Walk Speed", 1, 0, 250 }, { number = WalkSpeed })
        
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed:get()
        end)
    end
}


