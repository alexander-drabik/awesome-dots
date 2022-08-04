local text_box = wibox.widget {
	text = "",
	widget = wibox.widget.textbox
}

function update_volume()
	awful.spawn.easy_async(
		"pamixer --get-volume",
		function(stdout, stderr, reason, exit_code)
			local string = stdout:sub(1, -2)
			text_box.text = " "..string.."%"
		end
	)
end

update_volume()

return {
	text_box = text_box,
	update_volume = update_volume
}
