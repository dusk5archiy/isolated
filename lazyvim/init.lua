-- bootstrap lazy.nvim, LazyVim and your plugins

if vim.g.vscode then
	vim.opt.clipboard = "unnamedplus"
	return
end

local ISOLATED_DIR = os.getenv("W_ISOLATED_DIR")

if ISOLATED_DIR then
	package.path = package.path .. ";" .. ISOLATED_DIR .. "\\lazyvim\\lua\\?.lua"
else
	package.path = package.path .. ";" .. "/mnt/i/windows/nvim/lua/?.lua"
end
require("config.lazy")
