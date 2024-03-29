menubar = require "menubar"
menubar.utils.terminal = terminal

-- Create a launcher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu( { 
		items = {
			{ "awesome", myawesomemenu, beautiful.awesome_icon }, 
			{ "open terminal", terminal }
		}
	}
)

mylauncher = awful.widget.launcher( {
		image = beautiful.awesome_icon,
		menu = mymainmenu 
	}
)

