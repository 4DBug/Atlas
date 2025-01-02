return {
    Type = "Window",
    Name = "Executor",
    Description = "VERY BUGGY TEMPORARY Executor UI",
    Version = "v1.0.0",
    Creator = "4DBug",
    Data = {},
    Callback = function(Executor, deltaTime)
        Executor.Data.Index = (Executor.Data.Index or 0) + deltaTime

        --[[
        Executor.Data.Index = (Executor.Data.Index or 0) + deltaTime
        Executor.Data.Tabs = Executor.Data.Tabs or {}
        
        if #Executor.Data.Tabs == 0 then
            Executor.Data.Tabs = {
                {
                    Name = "Script",
                    Content = "print(\"Hello, World!\")"
                }
            }
        end
        ]]--

        local Content = ImGui.State(Executor.Data.Content or "print(\"Hello, World!\")")

        --[[
        ImGui.TabBar()
            for _, Tab in next, Executor.Data.Tabs do
                local Tab = ImGui.Tab(Tab.Name)

                if Tab.clicked() then
                    Content:set(Tab.Content)
                end

                if Tab.opened() then
                    Tab.Content = Content:get()
                end

                ImGui.PushConfig({ContentHeight = UDim.new(0, -32), ContentWidth = UDim.new(1, 0)})
                    ImGui.InputText({"", "", false, true}, {text = Content})
                ImGui.PopConfig()

                ImGui.End()
            end

            if ImGui.Tab("+").clicked() then
                table.insert(Executor.Data.Tabs, {
                    {
                        Name = "Script" .. #Executor.Data.Tabs + 1,
                        Content = "print(\"Hello, World!\")"
                    }
                })
            end
            ImGui.End()
        ImGui.End()
        ]]--

        ImGui.Text({Executor.Data.Index})

        ImGui.PushConfig({ContentHeight = UDim.new(0, -32), ContentWidth = UDim.new(1, 0)})
            ImGui.InputText({"", "", false, true}, {text = Content})
        ImGui.PopConfig()

        Executor.Data.Content = Content:get()

        ImGui.SameLine()
            if ImGui.Button("Execute").clicked() then
                task.spawn(function()
                    loadstring(Content:get())()
                end)
            end

            if ImGui.Button("Clear").clicked() then
                Content:set("")
            end
            
            ImGui.Button("Open File")
            ImGui.Button("Save File")
        ImGui.End()
    end
}