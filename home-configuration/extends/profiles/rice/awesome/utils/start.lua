local awful = require("awful")

-- Screen Padding and Tags
screen.connect_signal("request::desktop_decoration", function(s)
    -- Screen padding
    screen[s].padding = {left = 0, right = 0, top = 0, bottom = 0}
end)

do
	local cmds = 
	{
		"kitty",
		"chromium",
		"Discord",
		"electronplayer"
	}

	for _, i in pairs(cmds) do
		awful.spawn.single_instance(i, awful.rules.rules)
	end
end


awful.rules.rules = {
	{ rule = { instance = "chromium-browser" }, properties = { screen = 2 } },
	{ rule = { instance = "discord" }, properties = { screen = 3 } }
}
