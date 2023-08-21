local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local screen = require("awful.screen")
local dpi = xresources.apply_dpi

local themes_path = "/home/alex/.config/awesome/themes/default/"

local theme = {}

theme.font          = "hack 10"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = 3

theme.border_width  = 1
theme.border_normal = "#000000"
theme.border_focus  = "#5C4A4A"
theme.border_marked = "#91231c"

theme.taglist_spacing = 4
theme.taglist_bg_focus = "#464B46"

-- Notifications
theme.menu_submenu_icon = themes_path.."submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = themes_path.."background5.jpg"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.icon_theme = "/usr/share/icons/hicolor"

return theme

