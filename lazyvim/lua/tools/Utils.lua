local M = {}

-------------------------------------------------------------------------------
--- BUFFERS AND WINDOWS
-------------------------------------------------------------------------------

function M.isHavingOneWindow()
  return #vim.api.nvim_list_wins() == 1
end

-------------------------------------------------------------------------------

function M.getCurrentWindow()
  return vim.api.nvim_get_current_win()
end

-------------------------------------------------------------------------------

function M.openBufferByName(buffer_name)
  if buffer_name == nil then
    buffer_name = "Terminal"
  end
  local _cwd = vim.fn.getcwd()
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buffer) == _cwd .. "\\" .. buffer_name then
      vim.api.nvim_set_current_buf(buffer)
      return
    end
  end

  vim.cmd("term")
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buffer, buffer_name)
end

-------------------------------------------------------------------------------

function M.getBufferByName(buffer_name)
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buffer) and vim.api.nvim_buf_get_name(buffer):match(buffer_name) then
      return buffer
    end
  end
  return nil
end

-------------------------------------------------------------------------------

function M.getWindowByBufferName(buffer_name)
  local buffer = M.getBufferByName(buffer_name)
  if not buffer then
    return nil
  end
  for _, window in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(window) == buffer then
      return window
    end
  end
  return nil
end

-------------------------------------------------------------------------------

function M.openWindow(window)
  vim.api.nvim_set_current_win(window)
end

-------------------------------------------------------------------------------

function M.openWindowByBufferName(buffer_name)
  local win = M.getWindowByBufferName(buffer_name)
  if win then
    M.openWindow(win)
  else
    vim.cmd("split")
    M.openBufferByName(buffer_name)
  end
end

function M.closeWindow(window)
  vim.api.nvim_win_close(window, true)
end

-------------------------------------------------------------------------------

function M.sendTextToBuffer(text)
  vim.fn.chansend(vim.b.terminal_job_id, text)
end

-------------------------------------------------------------------------------

function M.sendCommandToBuffer(cmd)
  vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\r")
end

-------------------------------------------------------------------------------
--- VIM ACTIONS
-------------------------------------------------------------------------------

function M.getSelectedText()
  vim.cmd('normal! "zy')
  return vim.fn.getreg("z")
end

function M.yank()
  vim.cmd("normal! y")
end

-------------------------------------------------------------------------------

function M.normalMode()
  vim.cmd("stopinsert")
end

-------------------------------------------------------------------------------

function M.insertMode()
  vim.cmd("startinsert")
end

-------------------------------------------------------------------------------
--- COMMAND LINES
-------------------------------------------------------------------------------

function M.getUtf8CommandPrefix()
  return "powershell -c chcp 65001 >/dev/null"
end

-------------------------------------------------------------------------------

function M.concatenateCommands(commands, is_using_utf8)
  if is_using_utf8 == nil then
    is_using_utf8 = false
  end

  if #commands == 0 then
    return ""
  end

  local result = ""

  if is_using_utf8 then
    result = M.getUtf8CommandPrefix() .. " && "
  end

  result = result .. commands[1]

  for i = 2, #commands do
    result = result .. " && " .. commands[i]
  end

  return result
end

-------------------------------------------------------------------------------

function M.which(program)
  return string.lower(vim.fn.exepath(program)):gsub("\\", "/"):gsub("^%l", string.upper)
end

-------------------------------------------------------------------------------

function M.executeCommand(command)
  local handle = io.popen(command)
  if handle then
    local result = handle:read("*a")
    handle:close()
    return (result or ""):gsub("%s+$", "")
  else
    return "Error executing command"
  end
end

-------------------------------------------------------------------------------
--- TERMINALS
-------------------------------------------------------------------------------

function M.toggleTerminal(buffer_name, initial_command)
  local targetWin = M.getWindowByBufferName(buffer_name)
  local currentWin = M.getCurrentWindow()
  local buf = M.getBufferByName(buffer_name)
  if not targetWin then
    M.openWindowByBufferName(buffer_name)
    if not buf and initial_command then
      M.sendCommandToBuffer(initial_command)
    end
    M.openWindow(currentWin)
  elseif not M.isHavingOneWindow() then
    M.closeWindow(targetWin)
  end
end

-------------------------------------------------------------------------------

function M.setToggleTerminalKeymap(mode, keymap, buffer_name, desc, initial_command)
  vim.keymap.set(mode, keymap, function()
    M.toggleTerminal(buffer_name, initial_command)
  end, { buffer = true, desc = desc })
end

-------------------------------------------------------------------------------

function M.openBufferAndExecuteCommand(buffer_name, command)
  local currentWin = M.getCurrentWindow()
  M.openWindowByBufferName(buffer_name)
  M.sendCommandToBuffer(command)
  vim.cmd("normal! G")
  M.openWindow(currentWin)
end

-------------------------------------------------------------------------------

function M.setExecuteTerminalKeymap(
  pattern,
  buffer_name,
  toggle_description,
  run_description,
  command_generator,
  keymap,
  runKey
)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = pattern,
    callback = function()
      M.setToggleTerminalKeymap("n", keymap, buffer_name, toggle_description)
      vim.keymap.set("n", runKey, function()
        M.openBufferAndExecuteCommand(buffer_name, command_generator())
      end, { buffer = true, desc = run_description })
    end,
  })
end

-------------------------------------------------------------------------------

function M.quickTerminal()
  vim.ui.input({ prompt = "Shell command: " }, function(input)
    if input == nil then
      return
    end
    local ok, result = pcall(M.executeCommand, input)
    if ok then
      vim.notify(result)
    else
      vim.notify("Error: " .. tostring(result), vim.log.levels.ERROR)
    end
  end)
end

-------------------------------------------------------------------------------
--- FILES
-------------------------------------------------------------------------------

function M.getFileName(is_including_extension)
  if is_including_extension == nil then
    is_including_extension = true
  end

  if is_including_extension then
    return vim.fn.expand("%:p"):gsub("\\", "/")
  else
    return vim.fn.expand("%:t:r"):gsub("\\", "/")
  end
end

-------------------------------------------------------------------------------

function M.getCwd()
  return vim.fn.getcwd():gsub("\\", "/")
end

-------------------------------------------------------------------------------

function M.makeDir(name, isLocal)
  if isLocal == nil then
    isLocal = true
  end

  if isLocal then
    name = vim.fn.getcwd() .. "/" .. name
  end

  if vim.fn.isdirectory(name) == 0 then
    vim.fn.mkdir(name, "p")
  end
end

-------------------------------------------------------------------------------
return M
-------------------------------------------------------------------------------
