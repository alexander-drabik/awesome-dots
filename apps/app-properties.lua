local rules = {
    -- All clients will match this rule.
    { 
		rule = { },
		properties = { 
			border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
	        focus = awful.client.focus.filter,
            raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
    },

    -- Floating clients.
    {
		rule_any = require "apps.floating-clients",
		properties = { floating = true }
	},

	-- App properties
    {
		rule = { class = "firefox" },
		properties = { tag = "2" } 
	},
    {
		rule = { class = "discord" },
		properties = { tag = "1" } 
	},
}

return rules

