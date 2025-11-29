-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
	vim.opt.clipboard = "unnamedplus"
	return
end

local W_ISOLATED_DIR = os.getenv("W_ISOLATED_DIR")

if W_ISOLATED_DIR then
	package.path = package.path .. ";" .. W_ISOLATED_DIR .. "\\lazyvim\\lua\\?.lua"
	require("config.lazy")
end
