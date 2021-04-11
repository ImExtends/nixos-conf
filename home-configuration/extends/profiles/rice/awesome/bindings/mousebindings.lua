local awful = require("awful")
local gears = require("gears")

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end)
))
