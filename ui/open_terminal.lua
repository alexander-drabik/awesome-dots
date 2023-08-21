local gfs = require("gears.filesystem")

local prompt = awful.widget.prompt()
input_box = wibox {
	visible = false,
	bg = beautiful.normal,
	ontop = true,
	height = 50,
	width = 200,
	border_color = '#72AF72',
	border_width = 1,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 3)
	end
}

input_box:setup {
	{
		prompt,
		bg = "#292929",
		widget = wibox.container.background
	},
	margins = 9,
	widget = wibox.container.margin
}

awful.placement.top(
	input_box,
	{
		margins = { top = 30 },
		parent = awful.screen.focused()
	}
)

result_box = wibox {
	visible = false,
	bg = beautiful.normal,
	ontop = true,
	height = 50,
	width = 300,
	border_color = '#72AF72',
	border_width = 1,
	shape = function(cr, width, height)
		gears.shape.rounded_rect(cr, width, height, 3)
	end
}

text_box = wibox.widget {
	text = "Hejka",
	widget = wibox.widget.textbox
}

result_box:setup {
	text_box,
	valigh = 'center',
	layout = wibox.container.place
}

awful.placement.top(
	result_box,
	{
		margins = { top = 88 },
		parent = awful.screen.focused()
	}
)

local function show_results(results, file)
	input_box.visible = true
	result_box.visible = true

	local max_length = 0
	local string = ""
	for index, value in pairs(results) do
		max_length = math.max(max_length, #value)

		value2 = value:sub(1, 1) .. " " .. value:sub(3)
		string = string .. index .. value2 .. "\n"
	end

	result_box.height = #results * 20
	result_box.width = 18 + max_length * 8
	text_box.text = string
	awful.placement.top(
		result_box,
		{
			margins = { top = 88 },
			parent = awful.screen.focused()
		}
	)

	awful.prompt.run {
		prompt = "<b>Choose Directory</b>: ",
		textbox = prompt.widget,
		history_path = gfs.get_dir('cache') .. '/translate_history',
		bg_cursor = input_box.border_color,

		exe_callback = function(text)
			if not text or #text == 0 then return end
			local a = tonumber(text)
			if a > 0 and a <= #results then
				if file then
					awful.spawn("wezterm start -- nvim " .. results[a])
				else
					awful.spawn("wezterm start --cwd " .. results[a])
				end
			end
			input_box.visible = false
			result_box.visible = false
		end,

		done_callback = function()
			input_box.visible = false
			result_box.visible = false
		end
	}
end

local function launch(file)
	input_box.visible = true

	local type_title = ""
	local type_option = ""
	if file then
		type_title = "File"
		type_option = "f"
	else
		type_title = "Dir"
		type_option = "d"
	end

	awful.prompt.run {
		prompt = "<b>" .. type_title .. " Path</b>: ",
		textbox = prompt.widget,
		history_path = gfs.get_dir('cache') .. '/translate_history',
		bg_cursor = input_box.border_color,

		exe_callback = function(text)
			if not text or #text == 0 then return end
			local command = ([[
				find . -type ]] .. type_option .. [[ \
				-and -ipath '%s' \
				-maxdepth 4 \
				| head -5
				]]):format("**" .. text:gsub("%s+", "**") .. "**")

			awful.spawn.easy_async_with_shell(
				command,
				function(stdout, stderr, reason, exit_code)
					-- check if string isn't made only of whitespaces
					if not stdout:match "^%s*$" then
						local results = {}
						for l in stdout:gmatch "[^\n]+" do
							table.insert(results, l)
						end
						show_results(results, file)
					end
				end
			)
		end,

		done_callback = function()
			input_box.visible = false
		end
	}
end

return {
	launch = launch
}
