local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
		
		if s.index == 1 then
			gears.wallpaper.maximized(wallpaper, s, true)
		else 
			gears.wallpaper.maximized("/home/alex/.config/awesome/themes/default/backgroundh.jpg", s, true)
		end
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

return set_wallpaper
