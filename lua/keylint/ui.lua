local audit = require("keylint.audit")

local M = {}

function M.show_conflicts()
  local plugins = require("lazy.core.config").plugins
  local conflicts = audit.detect_conflicts(plugins)

  if #conflicts == 0 then
    vim.notify("✅ No plugin keymap conflicts found", vim.log.levels.INFO)
    return
  end

  local lines = { "⚠️ KeyLint Plugin Conflicts", string.rep("=", 30) }
  for _, conflict in ipairs(conflicts) do
    local plugin_list = table.concat(conflict.plugins, ", ")
    local line = string.format("• [%s] %s → used by: %s", conflict.mode, conflict.lhs, plugin_list)
    table.insert(lines, line)
  end

  -- Create floating window
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 60
  local height = #lines + 2
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = (vim.o.lines - height) / 2,
    col = (vim.o.columns - width) / 2,
    style = "minimal",
    border = "rounded",
  }

  vim.api.nvim_open_win(buf, true, opts)
end

return M
