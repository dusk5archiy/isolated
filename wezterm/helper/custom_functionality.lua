local M = {}

function M.changeOpacity(window, _)
	local overrides = window:get_config_overrides() or {}
	local list = { 0, 0.5, 0.7, 0.8, 0.9, 1 }
	for i, value in ipairs(list) do
		if value == overrides.window_background_opacity then
			overrides.window_background_opacity = list[(i % #list) + 1]
			window:set_config_overrides(overrides)
			return
		end
	end
	overrides.window_background_opacity = list[1]
	window:set_config_overrides(overrides)
end

function M.changeTextBackgroundOpacity(window, _)
	local overrides = window:get_config_overrides() or {}
	local list = { 0, 1 }
	for i, value in ipairs(list) do
		if value == overrides.text_background_opacity then
			overrides.text_background_opacity = list[(i % #list) + 1]
			window:set_config_overrides(overrides)
			return
		end
	end
	overrides.text_background_opacity = list[1]
	window:set_config_overrides(overrides)
end

function M.changeSystemBackdrop(window, _)
	local overrides = window:get_config_overrides() or {}
	local list = { "Disable", "Acrylic" }
	for i, value in ipairs(list) do
		if value == overrides.win32_system_backdrop then
			overrides.win32_system_backdrop = list[(i % #list) + 1]
			window:set_config_overrides(overrides)
			return
		end
	end
	overrides.win32_system_backdrop = list[1]
	window:set_config_overrides(overrides)
end

return M