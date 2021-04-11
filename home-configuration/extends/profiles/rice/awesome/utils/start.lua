local awful = require("awful")

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
	{ rule = { class = "Chromium-browser" }, properties = { tag = tags[1][2] } },
	{ rule = { class = "discord" }, properties = { tag = tags[1][3] } }
}
