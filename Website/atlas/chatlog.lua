
local function NameColor(Name)
    local Value = 0

    for Index = 1, #Name do
        Value = Value + (((#Name - Index + 1) - ((#Name % 2 == 1) and 1 or 0) % 4 >= 2) and -1 or 1) * string.byte(Name:sub(Index, Index))
    end

	return ({
        Color3.fromRGB(253, 41, 67),
        Color3.fromRGB(1, 162, 255),
        Color3.fromRGB(2, 184, 87),
        BrickColor.new("Bright violet").Color,
        BrickColor.new("Bright orange").Color,
        BrickColor.new("Bright yellow").Color,
        BrickColor.new("Light reddish violet").Color,
        BrickColor.new("Brick yellow").Color,
    })[(Value % 8) + 1]
end

NAME_COLORS =
	{
		Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
		Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
		Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
		BrickColor.new("Bright violet").Color,
		BrickColor.new("Bright orange").Color,
		BrickColor.new("Bright yellow").Color,
		BrickColor.new("Light reddish violet").Color,
		BrickColor.new("Brick yellow").Color,
	}

local function GetNameValue(pName)
	local value = 0
	for index = 1, #pName do
		local cValue = string.byte(string.sub(pName, index, index))
		local reverseIndex = #pName - index + 1
		if #pName%2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex%4 >= 2 then
			cValue = -cValue
		end
		value = value + cValue
	end
	return value
end

local color_offset = 0
local function NameColor(pName)
	return NAME_COLORS[((GetNameValue(pName) + color_offset) % #NAME_COLORS) + 1]
end

local function ToHex(Color)
    return string.format("#%02X%02X%02X", Color.R * 0xFF, Color.G * 0xFF, Color.B * 0xFF)
end

local function FormattedTime()
    local Hour = math.floor((tick() % 86400) / 3600)
    local Minute = math.floor((tick() % 3600) / 60)
    local Second = math.floor(tick() % 60)

    Hour = Hour < 10 and '0' .. Hour or tostring(Hour)
    Minute = Minute < 10 and '0' .. Minute or tostring(Minute)
    Second = Second < 10 and '0' .. Second or tostring(Second)

    return Hour .. ':' .. Minute .. ':' .. Second
end

local Players = game:GetService("Players")

local ChatLogsEnabled = true
local ChatLogs = {}
local RawLogs = {}

local function ChatLog(Player)
    Player.Chatted:Connect(function(Message)
        if ChatLogsEnabled then
            table.insert(RawLogs, string.format("%s [%s]: %s", FormattedTime(), Player.Name, Message))
            table.insert(ChatLogs, string.format("%s [<font color=\"%s\">%s</font>]: %s", FormattedTime(), ToHex(NameColor(Player.Name)), Player.Name, Message))
        end
    end)
end

Players.PlayerAdded:Connect(ChatLog)
for _, Player in next, Players:GetPlayers() do
    ChatLog(Player)
end

return {
    Type = "Window",
    Name = "Chat Logs",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function()
        --[[
        local ChatLogs = {"Group", {}, {
            {"SameLine", {}, {
                {"Button", {{ChatLogsEnabled and "Disable" or "Enable"}}, {}, {
                    clicked = function()
                        ChatLogsEnabled = not ChatLogsEnabled
                    end
                }},
                {"Button", {{"Clear"}}, {}, {
                    clicked = function()
                        table.clear(ChatLogs)
                    end
                }},
                {"Button", {{"Save to File"}}, {}, {
                    clicked = function() 
                        print("Saved")
                    end
                }}
            }},
            unpack(ChatLogs)
        }}
        
        ImGui.RenderMarkup(ChatLogs)
        ]]--

        ImGui.SameLine()
            if ImGui.Button({ChatLogsEnabled and "Disable" or "Enable"}).clicked() then
                ChatLogsEnabled = not ChatLogsEnabled
            end

            if ImGui.Button({"Clear"}).clicked() then
                table.clear(ChatLogs)
            end

            if ImGui.Button({"Save to File"}).clicked() then
                writefile(string.format("%s-%s.clog.txt", FormattedTime():gsub(":", "-"), game.Name), table.concat(RawLogs, "\n"))
            end
        ImGui.End()

        for _, Log in next, ChatLogs do
            ImGui.Text({Log, true, nil, true})
        end
    end
}
