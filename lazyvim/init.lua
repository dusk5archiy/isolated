-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
	vim.opt.clipboard = "unnamedplus"
	return
end

local W_LAZYVIM_DIR = os.getenv("W_LAZYVIM_DIR")

if W_LAZYVIM_DIR then
	package.path = package.path .. ";" .. W_LAZYVIM_DIR .. "\\lua\\?.lua"
	require("config.lazy")
end
