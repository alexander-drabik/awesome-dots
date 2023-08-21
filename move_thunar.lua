function moveThunar()
	-- Get the current focused screen
	local currentScreen = awful.screen.focused()

	-- Iterate over all clients (windows)
	for _, c in ipairs(client.get()) do
		-- Check if the window name contains "thunar"
		if c.class == "Thunar" then
			local naughty = require("naughty")

			-- Get the current window geometry
			local geometry = c:geometry()

			-- Calculate the new position on the next monitor
			local nextScreen = currentScreen.index + 1
			if nextScreen > screen.count() then
				nextScreen = 1
			end
			local newGeometry = screen[nextScreen].geometry

			-- Move the window to the new position
			c:geometry({
				x = newGeometry.x + (geometry.x - currentScreen.geometry.x),
				y = newGeometry.y + (geometry.y - currentScreen.geometry.y),
				width = geometry.width,
				height = geometry.height
			})
		end
	end
end
