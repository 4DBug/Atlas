
local serializers = { }
local deserializers = { }

local typeToId = {
	CFrame = "C",
	Vector3 = "V",
	Color3 = "C3",
	EnumItem = "E",
	BrickColor = "B",
	TweenInfo = "T",
	Vector2 = "V2",
	Vector2int16 = "V2i",
	Vector3int16 = "Vi",
	UDim2 = "U2",
	UDim = "U",
	Axes = "A",
	Rect = "R",
	PhysicalProperties = "P",
	NumberRange = "N",
	Ray = "RA",
	DockWidgetPluginGuiInfo = "D",
	PathWaypoint = "PW",
	Region3 = "R3",

	Region3int16 = "R3i",
	Font = "F",
	Tuple = "TU",

	
}

local idToType = {
	C = "CFrame",
	V = "Vector3",
	C3 = "Color3",
	E = "EnumItem",
	B = "BrickColor",
	T = "TweenInfo",
	V2 = "Vector2",
	V2i = "Vector2int16",
	Vi = "Vector3int16",
	U = "UDim",
	U2 = "UDim2",
	R = "Rect",
	N = "NumberRange",
	P = "PhysicalProperties",
	RA = "Ray",
	D = "DockWidgetPluginGuiInfo",
	PW = "PathWaypoint",
	R3 = "Region3",
	R3i = "Region3int16",
	A = "Axes",
	F = "Font",
	TU = "Tuple"

}

function serializers.CFrame(value)
	return {typeToId.CFrame, value:GetComponents()}
end

function serializers.Color3(value)
	return {typeToId.Color3, value.R, value.G, value.B}
end

function serializers.EnumItem(value)
	return {typeToId.EnumItem, tostring(value.EnumType), value.Name}
end

function serializers.BrickColor(value)
	return {typeToId.BrickColor, value.Name}
end

function serializers.TweenInfo(value)
	return {typeToId.TweenInfo, value.Time, value.EasingStyle, value.EasingDirection, value.RepeatCount, value.Reverses, value.DelayTime}
end

function serializers.Vector2(value)
	return {typeToId.Vector2, value.X, value.Y}
end

function serializers.Vector2int16(value)
	return {typeToId.Vector2int16, value.X, value.Y}
end

function serializers.Vector3(value)
	return {typeToId.Vector3, value.X, value.Y, value.Z} -- it has to be hard
end

function serializers.Vector3int16(value)
	return {typeToId.Vector3int16, value.X, value.Y, value.Z}
end

function serializers.UDim(value)
	return {typeToId.UDim, value.Scale, value.Offset}
end

function serializers.UDim2(value)
	return {typeToId.UDim2, value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset}
end

function serializers.Rect(value)
	return {typeToId.Rect, value.Min.X, value.Min.Y, value.Max.X, value.Max.Y}
end

function serializers.NumberRange(value)
	return {typeToId.NumberRange, value.Min, value.Max}
end

function serializers.PhysicalProperties(value)
	return {typeToId.PhysicalProperties, value.Density, value.Friction, value.Elasticity, value.FrictionWeight, value.ElasticityWeight}
end

function serializers.Ray(value)
	return {typeToId.Ray, serializers.Vector3(value.Origin), serializers.Vector3(value.Direction)}
end

function serializers.DockWidgetPluginGuiInfo(value)
	return {typeToId.Ray, value.InitialEnabled, value.InitialEnabledShouldOverrideRestore, value.FloatingXSize, value.FloatingYSize, value.MinWidth, value.MinHeight}
end

function serializers.PathWaypoint(value)
	return {typeToId.PathWaypoint, serializers.Vector3(value.Position), serializers.EnumItem(value.Action), value.Label}
end

function serializers.Region3int16(value)
	return {typeToId.Region3int16, serializers.Vector3int16(value.Min), serializers.Vector3int16(value.Max)}
end

function serializers.Region3(value)
	return {typeToId.Region3, serializers.Vector3(value.Size), serializers.CFrame(value.CFrame)}
end

function serializers.Font(value)
	return {typeToId.Font, value.Family, serializers.EnumItem(value.Weight), serializers.EnumItem(value.Style)}
end

function serializers.Tuple(...)
	return {typeToId.Tuple, ...}
end

function serializers.Axes(value)
	return {
		typeToId.Axes,
		value.X,
		value.Y,
		value.Z,
		value.Back,
		value.Bottom,
		value.Front,
		value.Left,
		value.Right,
		value.Top
	}
end

function deserializers.CFrame(value)
	return CFrame.new(unpack(value, 2))
end

function deserializers.Vector3(value)
	return Vector3.new(unpack(value, 2))
end

function deserializers.Color3(value)
	return Color3.new(unpack(value, 2))
end

function deserializers.EnumItem(value)
	return Enum[value[2]][value[3]]
end

function deserializers.BrickColor(value)
	return BrickColor.new(value[2])
end

function deserializers.TweenInfo(value)
	return TweenInfo.new(unpack(value, 2))
end

function deserializers.Vector2(value)
	return Vector2.new(unpack(value, 2))
end

function deserializers.Vector2int16(value)
	return Vector2int16.new(unpack(value, 2))
end

function deserializers.Vector3int16(value)
	return Vector3int16.new(unpack(value, 2))
end

function deserializers.UDim(value)
	return UDim.new(unpack(value, 2))
end

function deserializers.UDim2(value)
	return UDim2.new(unpack(value, 2))
end

function deserializers.Rect(value)
	return Rect.new(unpack(value, 2))
end

function deserializers.NumberRange(value)
	return NumberRange.new(unpack(value, 2))
end

function deserializers.PhysicalProperties(value)
	return PhysicalProperties.new(unpack(value, 2))
end

function deserializers.Ray(value)
	return Ray.new(deserializers.Vector3(value[2]), deserializers.Vector3(value[3]))
end

function deserializers.DockWidgetPluginGuiInfo(value)
	return DockWidgetPluginGuiInfo.new(nil, unpack(value, 2))
end

function deserializers.PathWaypoint(value)
	return PathWaypoint.new(deserializers.Vector3(value[2]), deserializers.EnumItem(value[3]), value[4])
end

function deserializers.Region3int16(value)
	return Region3int16.new(deserializers.Vector3int16(value[2]), deserializers.Vector3int16(value[3])) 
end

function deserializers.Region3(value)
	local Size = deserializers.Vector3(value[2])
	local CFrame = deserializers.CFrame(value[3])

	return Region3.new(CFrame.Position - Size/2, CFrame.Position + Size/2)
end

function deserializers.Font(value)
	return Font.new(value[2], deserializers.EnumItem(value[3]), deserializers.EnumItem(value[4]))
end

function deserializers.Tuple(value)
	return unpack(value, 2)
end
function deserializers.Axes(value)
	local valueWithoutTheType = table.unpack(value)
	table.remove(valueWithoutTheType, 1)
	return Axes.new(valueWithoutTheType)

end

local Serializer = { }

function Serializer.serialize(value)
	local valueType = typeof(value)
	
	local serializer = serializers[valueType]
	if serializer then
		return serializer(value)
	end
	
	return value
end

function Serializer.deserialize(value)
	local id = value[1]
	local deserializer = deserializers[idToType[id]]
	
	if deserializer then
		return deserializer(value)
	end
	
	return value
end

local HttpService = game:GetService("HttpService")
local InsertService = game:GetService("InsertService")
local ScriptContext = game:GetService("ScriptContext")
local UserInputService = game:GetService("UserInputService")

local Camera = workspace.CurrentCamera
local ViewportSize = Camera.ViewportSize
local Size = Vector2.new(475, 650)

local function writefile(File, Content) 
    return ScriptContext:SaveScriptProfilingData(Content, string.format("%s/%s", InsertService:GetLocalFileContents("rbxasset://relpath"), File))
end

local function readfile(File)
    local Content

    pcall(function()
        Content = InsertService:GetLocalFileContents(string.format("rbxasset://%s", File))
    end)

    return Content
end

function Format(json)
    local indent = 0
    local formatted = {}
    local in_string = false

    local function add_indent()
        return string.rep("  ", indent)
    end

    for i = 1, #json do
        local char = json:sub(i, i)

        if char == '"' then
            local escaped = i > 1 and json:sub(i - 1, i - 1) == "\\"
            if not escaped then
                in_string = not in_string
            end
        end

        if not in_string then
            if char == "{" or char == "[" then
                table.insert(formatted, char)
                table.insert(formatted, "\n")
                indent = indent + 1
                table.insert(formatted, add_indent())
            elseif char == "}" or char == "]" then
                table.insert(formatted, "\n")
                indent = indent - 1
                table.insert(formatted, add_indent())
                table.insert(formatted, char)
            elseif char == "," then
                table.insert(formatted, char)
                table.insert(formatted, "\n")
                table.insert(formatted, add_indent())
            elseif char == ":" then
                table.insert(formatted, ": ")
            else
                table.insert(formatted, char)
            end
        else
            table.insert(formatted, char)
        end
    end

    return table.concat(formatted)
end

local Default = {
    "https://bug.tools/atlas/cheats.lua",
    "https://bug.tools/atlas/executor.lua",
    "https://bug.tools/atlas/chatlog.lua"
}

local Atlas = HttpService:JSONDecode(readfile("atlas.json") or "[]")
Atlas.Sources = Atlas.Sources or {}
Atlas.SaveData = Atlas.SaveData or {}
Atlas.Config = Atlas.Config or {}

local function Save()
    writefile("atlas.json", Format(HttpService:JSONEncode(Atlas)))
end

local Config = {}
for Index, Value in next, Atlas.Config do
    Config[Index] = type(Value) == "table" and Serializer.deserialize(Value) or Value
end

ImGui.UpdateGlobalConfig(Config)

local Loaded = {}

local MasterToggle = true
UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.RightControl then
		MasterToggle = not MasterToggle
	end
end)

local Index = 0
local function main(deltaTime)
    for _, Source in pairs(Loaded) do
        if MasterToggle and Source.Type == "Window" then
            if Source.Data then
                Source.Data = Atlas.SaveData[Source.Name] or Source.Data
            end

            local Window = ImGui.Window({Source.Name})

            Source:Callback(deltaTime)

            ImGui.End()

            if Source.Data then
                Atlas.SaveData[Source.Name] = Source.Data
            end
        end
    end

    for Index, Value in next, ImGui.Internal._rootConfig do
        Atlas.Config[Index] = Serializer.serialize(Value)
    end

    Index = Index + 1

    if Index % 20 == 0 then
        Save()
    end

end

if #Atlas.Sources == 0 then
    __main = main
    
    for Index, Source in next, Default do
        Atlas.Sources[Index] = Source

        Loaded[Index] = loadstring(request({
            Url = Source
        }))()
    end

    table.foreach(Atlas.Sources, print)

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
                    Save()

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

                            table.insert(Atlas.Sources, Source)
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
                        Atlas.Sources[Index] = nil
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
    for Index, Source in next, Atlas.Sources do
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
