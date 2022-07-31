pcall(require, "luarocks.loader")

-- Standard awesome library
gears = require "gears"
awful = require "awful"
require "awful.autofocus"
-- Theme handling library
beautiful = require "beautiful"
-- Notification library
naughty = require "naughty"
wibox = require "wibox"

-- Set theme
beautiful.init "/home/alex/.config/awesome/themes/default/theme.lua"

-- Error handling
require "notifications.errors"

-- Variable definitions
terminal = "wezterm"

editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Set layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
}

-- Create a launcher widget and a main menu
require "ui.menu"

terminal_prompt = require "ui.open_terminal"

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Key bindings
bindings = require "bindings"
globalkeys = bindings[1]
clientkeys = bindings[2]

-- Set keys
root.keys(globalkeys)

-- Wibar
require "ui/wibar-config"

-- Set app rules
awful.rules.rules = require "apps.app-properties"

-- Manage signals
require "signals"

