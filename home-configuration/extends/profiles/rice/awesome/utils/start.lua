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
		awfu.spawn.single_instance(i, awful.rules.rules)
	end
end
