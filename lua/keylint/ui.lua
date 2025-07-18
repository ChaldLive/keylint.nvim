local audit = require("keylint.audit")

local M = {}

-- 🟡 Show plugin keymap conflicts
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

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 60
  local height = math.min(#lines + 2, vim.o.lines - 4)
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

-- 🧠 Show all plugin keymaps grouped by plugin
function M.show_cheatsheet()
  local plugins = require("lazy.core.config").plugins
  local lines = { "🧠 KeyLint Cheat Sheet", string.rep("=", 30) }

  for _, plugin in ipairs(plugins) do
    if plugin.keys then
      table.insert(lines, "")
      table.insert(lines, "Plugin: " .. plugin.name)

      for _, mapping in ipairs(plugin.keys) do
        local mode = mapping.mode or "n"
        local lhs = mapping[1]
        local rhs = mapping[2]
        local desc = mapping.desc or "no description"
        local line = string.format("  [%s] %s → %s (%s)", mode, lhs, rhs, desc)
        table.insert(lines, line)
      end
    end
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 70
  local height = math.min(#lines + 2, vim.o.lines - 4)
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
