
local function FormattedTime()
    local Hour = math.floor((tick() % 86400) / 3600)
    local Minute = math.floor((tick() % 3600) / 60)
    local Second = math.floor(tick() % 60)

    Hour = Hour < 10 and '0' .. Hour or tostring(Hour)
    Minute = Minute < 10 and '0' .. Minute or tostring(Minute)
    Second = Second < 10 and '0' .. Second or tostring(Second)

    return Hour .. ':' .. Minute .. ':' .. Second
end

LogsEnabled = true
local Logs = {}

local OutputColors = {
	[Enum.MessageType.MessageError] = "#ff4444",
	[Enum.MessageType.MessageInfo] = "#3d88df",
	[Enum.MessageType.MessageWarning] = "#ff8e3c",
	[Enum.MessageType.MessageOutput] = "#ffffff"
}

LogService = game:GetService("LogService")

LogService.MessageOut:Connect(function(Message, Type)
	if LogsEnabled then
		table.insert(Logs, string.format("%s -- <font color=\"%s\">%s</font>", FormattedTime(), OutputColors[Type], tostring(Message)))
	end
end)

return {
    Type = "Window",
    Name = "Console",
    Description = "Lorem ipsum odor amet, consectetuer adipiscing elit. Vehicula eleifend donec erat porta accumsan maecenas vestibulum.",
    Version = "v1.0.0",
    Creator = "4DBug",
    Callback = function()
        for _, Log in next, Logs do
            ImGui.Text({Log, true, nil, true})
        end
    end
}
