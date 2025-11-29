local wezterm = require("wezterm")
local config_dir = wezterm.config_dir

local M = {}

local custom_functionality = dofile(config_dir .. "/helper/custom_functionality.lua")
-- local primary_font = wezterm.font("JetBrainsMono Nerd Font")

wezterm.on("toggle-opacity", custom_functionality.changeOpacity)
wezterm.on("toggle-text-background-opacity", custom_functionality.changeTextBackgroundOpacity)
wezterm.on("toggle-acrylic", custom_functionality.changeSystemBackdrop)

function M.getConfigs(other_configs)
	local configs = {
		-- font = primary_font,
		initial_rows = 70,
		initial_cols = 300,

		adjust_window_size_when_changing_font_size = false,

		window_background_image = config_dir .. "\\background\\desktop.jpg",
		window_background_image_hsb = {
			brightness = 0.02,
			saturation = 0.5,
		},
		window_background_opacity = 0.7,
		font_size = 9,
		-- color_scheme = "Gruvbox dark, soft (base16)",
		color_scheme = "Catppuccin Macchiato",
		set_environment_variables = {},
		force_reverse_video_cursor = true,
		front_end = "WebGpu", -- "OpenGL" | "WebGpu" | "Software"
		-- webgpu_power_preference = "LowPower",
		text_background_opacity = 1.0,
		window_decorations = "INTEGRATED_BUTTONS|RESIZE",
		freetype_load_target = "Light", -- "Normal" | "Light" | "Mono"
		foreground_text_hsb = {
			hue = 1.0,
			saturation = 1.0,
			brightness = 1.0,
		},

		-- window frame
		window_frame = {
			-- font = primary_font,

			inactive_titlebar_bg = "#2f4f4f", -- none
			active_titlebar_bg = "#2f4f4f", -- none

			button_fg = "Red",
			button_bg = "Red",

			button_hover_bg = "Red",
			button_hover_fg = "Red",

			border_left_width = "0",
			border_right_width = "0",
			border_bottom_height = "0",
			border_top_height = "0",

			border_left_color = "none",
			border_right_color = "none",
			border_top_color = "none",
			border_bottom_color = "none",
		},

		-- padding
		window_padding = {
			left = 10,
			right = 10,
			top = 10,
			bottom = 10,
		},

		-- tab bar
		tab_bar_at_bottom = false,
		show_tab_index_in_tab_bar = true,
		tab_and_split_indices_are_zero_based = false,
		use_fancy_tab_bar = false,

		win32_system_backdrop = "Acrylic", -- Acrylic, "Disable", "Mica", "Tabbed"

		colors = {
			-- foreground = "silver",
			-- background = "black",
			cursor_fg = "red",
			cursor_bg = "red",
			cursor_border = "red",

			-- selection_fg = "silver",
			-- selection_bg = "gray",

			scrollbar_thumb = "red",
			split = "white",

			tab_bar = {
				background = "none",

				active_tab = {
					bg_color = "none",
					fg_color = "white",
					intensity = "Bold", -- [use_fancy_tab_bar == false] Bold, Half, Normal
					underline = "None", -- [use_fancy_tab_bar == false] None, Single, Double
					italic = false, -- [use_fancy_tab_bar == False]
					strikethrough = false, -- [use_fancy_tab_bar == False]
				},
				inactive_tab = {
					fg_color = "#aaa",
					bg_color = "none",
					italic = false, -- [use_fancy_tab_bar == false]
				},
				inactive_tab_hover = {
					fg_color = "#ddd",
					bg_color = "none",
					italic = true, -- [use_fancy_tab_bar == false]
				},
				inactive_tab_edge = "none", -- [use_fancy_tab_bar == true]
				inactive_tab_edge_hover = "none", -- [use_fancy_tab_bar == true]
				new_tab = {
					fg_color = "#ddd",
					bg_color = "none",
				},
				new_tab_hover = {
					fg_color = "white",
					bg_color = "none",
				},
			},
		},
		window_close_confirmation = "NeverPrompt",
		keys = {
			{
				key = "_",
				mods = "CTRL|SHIFT",
				action = wezterm.action.SplitVertical,
			},
			{
				key = "|",
				mods = "CTRL|SHIFT",
				action = wezterm.action.SplitHorizontal,
			},
			{
				key = "Home",
				mods = "CTRL|SHIFT",
				action = wezterm.action.ShowDebugOverlay,
			},
			{
				key = "End",
				mods = "CTRL|SHIFT",
				action = wezterm.action.ShowLauncher,
			},
			{
				key = "h",
				mods = "CTRL|SHIFT",
				action = wezterm.action.ShowLauncherArgs({ flags = "DOMAINS" }),
			},
			{
				key = "j",
				mods = "CTRL|SHIFT",
				action = wezterm.action.ShowLauncherArgs({ flags = "WORKSPACES" }),
			},
			{
				key = "k",
				mods = "CTRL|SHIFT",
				action = wezterm.action.ShowTabNavigator,
			},
			{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.Nop },
			{
				key = "F9",
				mods = "",
				action = wezterm.action.EmitEvent("toggle-opacity"),
			},
			{
				key = "F9",
				mods = "SHIFT",
				action = wezterm.action.EmitEvent("toggle-text-background-opacity"),
			},
			{
				key = "F10",
				mods = "",
				action = wezterm.action.EmitEvent("toggle-acrylic"),
			},
			{
				key = "F11",
				action = wezterm.action.ToggleFullScreen,
			},
			{
				key = "Enter",
				mods = "SHIFT",
				action = wezterm.action.Nop,
			},
			{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(-1) },
			{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(1) },
		},
		mouse_bindings = {
			{
				event = { Up = { streak = 1, button = "Left" } },
				mods = "CTRL|SHIFT",
				action = wezterm.action.OpenLinkAtMouseCursor,
			},
			{
				event = { Down = { streak = 1, button = "Left" } },
				mods = "CTRL",
				action = wezterm.action.DisableDefaultAssignment,
			},
		},
		launch_menu = {
			{
				args = { "cmd" },
			},
		},
		unix_domains = {
			{
				name = "unix",
				socket_path = config_dir .. "\\..\\var\\sock",
			},
		},
	}

	for k, v in pairs(other_configs) do
		configs[k] = v
	end

	return configs
end

return M

-- EOF
