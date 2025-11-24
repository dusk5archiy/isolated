-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.shellslash = true
vim.opt.colorcolumn = "80"
vim.opt.columns = 80
vim.opt.conceallevel = 2
vim.opt.cursorline = false
vim.opt.fileformat = "unix"
vim.opt.linebreak = false
vim.opt.shellcmdflag = "-c"
vim.opt.spell = false
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0
vim.g.mkdp_page_title = ""

vim.g.lazyvim_rust_diagnostics = "bacon-ls"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk_engines = { ["_"] = "-xelatex" }
vim.g.vimtex_compiler_latexmk = {
	out_dir = "./build",
}
