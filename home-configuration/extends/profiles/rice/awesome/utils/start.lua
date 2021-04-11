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
		"electronplayer",
		"fehbg"
	}

	for _, i in pairs(cmds) do
		awful.spawn.single_instance(i, awful.rules.rules)
	end
end


awful.rules.rules = {
	{ rule = { class = "Chromium-browser" }, properties = { tag = "2" } },
	{ rule = { class = "discord" }, properties = { tag = "3" } },
	{ rule = { class = "electronplayer" }, properties = { tag = "4" } }
}
