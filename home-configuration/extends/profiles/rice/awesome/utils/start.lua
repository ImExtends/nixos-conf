require ("awful")

do
	local cmds = 
	{
		"kitty",
		"chromium",
		"Discord",
		"electronplayer"
	}

	for _, i in pairs(cmds) do
		awful.util.spawn(i)
	end
end
