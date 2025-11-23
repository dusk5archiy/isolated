-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local IPython = require("tools.IPython")
local Utils = require("tools.Utils")
local blinkcmp = require("blink.cmp")

-- vim.keymap.set("n", "<localLeader>y", "<cmd>echo 'Hello!'<CR>", { desc = "Say Hello" })
-- noremap: no-remap, ensure rhs is not remapped recursively (if rhs contains keys that themselves have mappings,
-- then those mappings won't be applied again)
-- slient: prevent echoing to the command/status line

-- Auto-completetion
vim.keymap.set("i", "<C-l>", function()
  blinkcmp.show()
end, { noremap = true, silent = true })

-- Open link on browser
vim.keymap.set("v", "<localLeader>w", function()
  vim.cmd('normal! "zy')
  local link = vim.fn.getreg("z")
  vim.fn.jobstart({ "cmd.exe", "/C", "start", "", link }, { detach = true })
end, { desc = "Open link on browser" })

-- Trigger quick terminal
vim.keymap.set("n", "<localLeader>t", Utils.quickTerminal, { desc = "Quick Terminal" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    -- IPython Terminal
    Utils.setToggleTerminalKeymap("n", "<localLeader>i", "Terminal::IPython", "Toggle IPython", "python -m IPython")

    -- Execute selected code
    vim.keymap.set("v", "<leader><CR>", function()
      IPython.executeSelectedCode()
    end, { buffer = true, desc = "Execute selected code" })

    -- Execute code cell
    vim.keymap.set("n", "<leader><CR>", function()
      IPython.executeCodeCell()
    end, { buffer = true, desc = "Execute code cell" })

    vim.keymap.set("n", "<localLeader>v", function()
      IPython.selectCodeCell()
      Utils.yank()
    end, { buffer = true, desc = "Yank code cell" })
  end,
})
