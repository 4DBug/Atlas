
local HttpService = game:GetService("HttpService")
local InsertService = game:GetService("InsertService")
local ScriptContext = game:GetService("ScriptContext")

local Camera = workspace.CurrentCamera
local ViewportSize = Camera.ViewportSize
local Size = Vector2.new(475, 650)

local function writefile(File, Content) 
    return ScriptContext:SaveScriptProfilingData(Content, string.format("%s/%s", InsertService:GetLocalFileContents("rbxasset://Atlas/relpath"), File))
end

local function readfile(File)
    local Content

    pcall(function()
        Content = InsertService:GetLocalFileContents(string.format("rbxasset://Atlas/%s", File))
    end)

    return Content
end

local Default = {
    "https://bug.tools/atlas/cheats.lua",
    "https://bug.tools/atlas/executor.lua"
}

local Sources = HttpService:JSONDecode(readfile("sources.json") or "[]") 
local Loaded = {}

local function main(deltaTime)
    for _, Source in pairs(Loaded) do
        if Source.Type == "Window" then
            if Source.Data then
                pcall(function()
                    Source.Data = HttpService:JSONDecode(readfile(string.format("Data/%s.json", string.lower(Source.Name))))
                end)
            end

            local Window = ImGui.Window({Source.Name})
            if Window.state.isOpened.value and Window.state.isUncollapsed.value then
                Source:Callback(deltaTime)
            end
            ImGui.End()

            if Source.Data then
                writefile(string.format("Data/%s.json", string.lower(Source.Name)), HttpService:JSONEncode(Source.Data))
            end
        end
    end
end

if #Sources == 0 then
    __main = main
    
    for Index, Source in next, Default do
        Sources[Index] = Source

        Loaded[Index] = loadstring(request({
            Url = Source
        }))()
    end

    table.foreach(Sources, print)

    main = function()
        ImGui.Window({"Welcome to Atlas, by @4DBug"}, {position = ViewportSize / 2 - Size / 2, size = Size})
            ImGui.Text({""})

            ImGui.SameLine({nil, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center})
                ImGui.Image({"rbxassetid://82040623470397", UDim2.fromOffset(150, 150), Rect.new(), Enum.ScaleType.Stretch, false})
            ImGui.End()

            ImGui.Text({""})
            ImGui.Separator()
            ImGui.Text({""})

            ImGui.SameLine({nil, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center})
                ImGui.Text({"Atlas is a manager for devtools and utilties, based on an Immediate mode GUI Library, that is derived from Dear ImGui.", true})
            ImGui.End()

            ImGui.SameLine({nil, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center})
                ImGui.Text({"It appears to be your first time using Atlas, lets get you started with some default source files, these are used to configure, and extend Atlas.", true})
            ImGui.End()

            ImGui.SameLine({nil, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center})
                ImGui.Text({"⚠️ Unoffical plugins, libraries and themes may contain malcious code, please look at the code before adding it to your sources.", true})
            ImGui.End()

            ImGui.Text({""})

            ImGui.SameLine({nil, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center})
                if ImGui.Button("Continue").clicked() then
                    writefile("sources.json", HttpService:JSONEncode(Sources))

                    main = __main
                end
            ImGui.End()

            ImGui.Text({""})

            ImGui.Separator()

            ImGui.SameLine()
                local InputSource = ImGui.State("")

                if ImGui.Button("+").clicked() then
                    print(InputSource:get())
                    task.spawn(function()
                        local Success, Error = pcall(function()
                            local Source = InputSource:get()

                            table.insert(Loaded, loadstring(request({
                                Url = Source
                            }))())

                            table.insert(Sources, Source)
                        end)

                        if not Success then
                            warn(Error)
                        end
                    end)
                end

                ImGui.InputText({"", "", false, true}, {text = InputSource})
            ImGui.End()

            ImGui.Separator()

            for Index, Source in next, Loaded do
                ImGui.SameLine()
                    if ImGui.Button({"-"}).clicked() then
                        Sources[Index] = nil
                        Loaded[Index] = nil
                    end

                    ImGui.Group()   
                        ImGui.Text({Source.Name .. " - " .. Source.Version})

                        ImGui.SeparatorText("by " .. (Source.Creator or "Anonymous"))
                        ImGui.Text({Source.Description, true})
                    ImGui.End()
                ImGui.End()

                ImGui.Separator()
            end
        ImGui.End()
    end
else
    for Index, Source in next, Sources do
        Loaded[Index] = loadstring(request({
            Url = Source
        }))()
    end
end

for Index, Source in next, Loaded do
    if Source.Type == "Widget" then
        for _, Widget in next, Source.Widgets do
            ImGui.Internal.WidgetConstructor(Widget.Name, Widget.Constructor)

            ImGui[Widget.Name] = function(arguments, states)
                return ImGui.Internal._Insert(Widget.Name, arguments, states)
            end
        end
    end
end

local t = os.clock()

ImGui:Connect(function()
    local deltaTime = os.clock() - t

    main(deltaTime)

    t = os.clock()
end)
