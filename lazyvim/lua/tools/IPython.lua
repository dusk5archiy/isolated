local Utils = require("tools.Utils")

local M = {}

function M.selectCodeCell()
  local check = function(mark)
    return mark:match("^#%%") or mark:match("^# %%")
  end
  local start_line = 1
  local end_line = vim.fn.line("$")
  local cur_line = vim.fn.line(".")
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Search upwards for previous #%%
  for i = cur_line - 1, 1, -1 do
    if check(lines[i]) then
      start_line = i + 1
      break
    end
  end

  -- Search downwards for next #%%
  for i = cur_line, #lines do
    if check(lines[i]) then
      end_line = i - 1
      break
    end
  end

  -- Visual select the region
  vim.api.nvim_win_set_cursor(0, { start_line, 0 })
  vim.cmd("normal! V")
  vim.api.nvim_win_set_cursor(0, { end_line, 0 })
end

function M.sentCmdToIPython(cmd)
  local bufName = "Terminal::IPython"
  local iPythonInputs = M.convTextToKeyStrokes(cmd)
  local oldWin = Utils.getCurrentWindow()
  local buf = Utils.getBufferByName(bufName)
  if not buf then
    Utils.toggleTerminal("Terminal::IPython", "python -m IPython")
    return
  else
    Utils.openWindowByBufferName(bufName)
  end
  Utils.sendTextToBuffer(string.char(15) .. iPythonInputs .. string.char(14) .. "\b\n") -- char(15) is Ctrl+O, char(14) is down key, backspace is char(8)
  vim.cmd("normal! G")
  Utils.openWindow(oldWin)
end

-- Convert text to key strokes
function M.convTextToKeyStrokes(text)
  local lines = vim.split(text, "\n", { plain = true })

  -- Calculate logical indentation (in tabs, 4 spaces per tab)
  local tab_counts = {}
  for i, line in ipairs(lines) do
    local _, count = string.find(line, "^[ \t]*")
    local spaces = 0
    if count then
      local indent = string.sub(line, 1, count)
      for c in indent:gmatch(".") do
        if c == "\t" then
          spaces = spaces + 4
        elseif c == " " then
          spaces = spaces + 1
        end
      end
    end
    tab_counts[i] = math.floor(spaces / 4)
  end

  local processed_lines = {}
  local state = { in_string = false, string_char = nil, paren_level = 0 }
  local base_indent = tab_counts[1] or 0  -- Base indentation of the first line
  local ipython_cursor_column = 0  -- Track where IPython's cursor will be (in tab units)

  for i, line in ipairs(lines) do
    local line_start_in_string = state.in_string
    local line_start_paren_level = state.paren_level

    -- Update string and paren state for this line
    local j = 1
    while j <= #line do
      local c = line:sub(j, j)
      if not state.in_string then
        if j + 2 <= #line and line:sub(j, j + 2) == '"""' then
          state.in_string = true
          state.string_char = '"""'
          j = j + 3
          goto continue_char_loop
        elseif j + 2 <= #line and line:sub(j, j + 2) == "'''" then
          state.in_string = true
          state.string_char = "'''"
          j = j + 3
          goto continue_char_loop
        elseif c == '"' or c == "'" then
          -- Check if it's escaped by counting preceding backslashes
          local backslash_count = 0
          local k = j - 1
          while k >= 1 and line:sub(k, k) == "\\" do
            backslash_count = backslash_count + 1
            k = k - 1
          end
          if backslash_count % 2 == 0 then  -- Even number of backslashes means not escaped
            state.in_string = true
            state.string_char = c
          end
        elseif c == "(" or c == "[" or c == "{" then
          state.paren_level = state.paren_level + 1
        elseif c == ")" or c == "]" or c == "}" then
          state.paren_level = math.max(0, state.paren_level - 1)
        end
      else
        if state.string_char == '"""' and j + 2 <= #line and line:sub(j, j + 2) == '"""' then
          state.in_string = false
          state.string_char = nil
          j = j + 3
          goto continue_char_loop
        elseif state.string_char == "'''" and j + 2 <= #line and line:sub(j, j + 2) == "'''" then
          state.in_string = false
          state.string_char = nil
          j = j + 3
          goto continue_char_loop
        elseif (state.string_char == '"' and c == '"') or (state.string_char == "'" and c == "'") then
          -- Check if it's escaped by counting preceding backslashes
          local backslash_count = 0
          local k = j - 1
          while k >= 1 and line:sub(k, k) == "\\" do
            backslash_count = backslash_count + 1
            k = k - 1
          end
          if backslash_count % 2 == 0 then  -- Even number of backslashes means not escaped
            state.in_string = false
            state.string_char = nil
          end
        end
      end
      j = j + 1
      ::continue_char_loop::
    end

    -- Skip empty lines outside of strings
    if line:match("^%s*$") and not line_start_in_string and not state.in_string then
      goto continue
    end

    -- Calculate what this line should have (in tab units, relative to base)
    local original_indent = tab_counts[i]
    local target_indent = original_indent - base_indent
    -- Special case: when entering a multiline string, IPython resets to column 0
    if not line_start_in_string and state.in_string then
      -- We just entered a multiline string, IPython will be at column 0 next line
      ipython_cursor_column = 0
    end
    local backspaces = ""
    local content = ""
    if line_start_in_string or state.in_string then
      -- Handle lines inside strings - preserve original structure  
      if line == "" or line:match("^[ \t]*$") then
        -- Empty line or whitespace-only line - treat both as empty
        content = ""
        -- For empty lines, IPython cursor doesn't change position
        if target_indent < ipython_cursor_column then
          local backspace_amount = ipython_cursor_column - target_indent
          backspaces = string.rep("\b", backspace_amount * 4)
        end
      else
        -- Regular line inside string - use code structure indentation
        if target_indent < ipython_cursor_column then
          local backspace_amount = ipython_cursor_column - target_indent
          backspaces = string.rep("\b", backspace_amount * 4)
        end
        local user_indent_spaces = math.max(0, (target_indent - ipython_cursor_column) * 4)
        local user_indent = string.rep(" ", user_indent_spaces)
        local line_content = line:gsub("^[ \t]*", "")  -- Remove all leading whitespace
        content = user_indent .. line_content
        -- After typing this line, IPython will be at this indentation level for the next line
        ipython_cursor_column = target_indent
      end
    else
      -- Outside a string: remove indentation and handle normal code logic
      content = line:gsub("^[ \t]+", "")
      if target_indent < ipython_cursor_column and line_start_paren_level == 0 then
        -- Need to dedent
        local backspace_amount = ipython_cursor_column - target_indent
        backspaces = string.rep("\b", backspace_amount * 4)
      end
      -- Update cursor position for next line
      ipython_cursor_column = target_indent
      -- IPython auto-indents after colons
      if content:match(":[ \t]*$") then
        ipython_cursor_column = ipython_cursor_column + 1
      end
    end
    table.insert(processed_lines, backspaces .. content)
    ::continue::
  end

  -- Check if we need to add an extra enter to finish an indented block
  -- If the final indentation level is not 0, add an extra newline
  if ipython_cursor_column > 0 then
    table.insert(processed_lines, "")
  end

  return table.concat(processed_lines, "\n")
end

function M.executeCodeCell()
  M.selectCodeCell()
  local selectedText = Utils.getSelectedText()
  M.sentCmdToIPython(selectedText)
end

function M.executeSelectedCode()
  local selectedText = Utils.getSelectedText()
  M.sentCmdToIPython(selectedText)
end

return M
