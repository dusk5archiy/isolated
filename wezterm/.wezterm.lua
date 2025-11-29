local wezterm = require("wezterm")
local config_dir = wezterm.config_dir

local helper = dofile(config_dir .. "/helper/helper.lua")

return helper.getConfigs({
	default_prog = { "cmd.exe", "/c", config_dir .. "\\..\\run.cmd" },
})
