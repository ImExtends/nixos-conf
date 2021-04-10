local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

awful.screen.connect_for_each_screen(function(s)

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

		s.mywibox = awful.wibar({position = "top", screen = s})
		s.mypromptbox = awful.widget.prompt()
		s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

		s.mywibox:setup {
    	layout = wibox.layout.align.horizontal,
    	{ -- Left widgets
       	layout = wibox.layout.fixed.horizontal,
       	mylauncher,
       	s.mytaglist,
       	s.mypromptbox,
    	},
    	s.mytasklist, -- Middle widget
    	{ -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        mykeyboardlayout,
        wibox.widget.systray(),
        mytextclock,
        s.mylayoutbox,
    	},
    }
	end)

