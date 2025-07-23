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

function M.show_cheatsheet()
  local plugins = require("lazy.core.config").plugins
  local utils = require("keylint.utils")
  local lines = { "🧠 KeyLint Cheat Sheet", string.rep("=", 30) }

  local found = false

  for name, plugin in pairs(plugins) do
    local keymaps = utils.extract_keys(plugin)

    -- Dev-mode logging
    print("🔎 Scanning:", name)
    print("📦 Keymaps:", vim.inspect(keymaps))

    if type(keymaps) == "table" and #keymaps > 0 then
      found = true
      table.insert(lines, "")
      table.insert(lines, "Plugin: " .. (plugin.name or name or "<unknown>"))

      for _, mapping in ipairs(keymaps) do
        local lhs = mapping[1]
        local rhs = mapping[2]
        local mode = mapping.mode or "n"
        local desc = mapping.desc or "no description"
        local rhs_str = type(rhs) == "function" and "<function>" or tostring(rhs)

        if lhs then
          local line = string.format("  [%s] %s → %s (%s)", mode, lhs, rhs_str, desc)
          table.insert(lines, line)
        end
      end
    end
  end

  if not found then
    table.insert(lines, "")
    table.insert(lines, "No plugin keymaps found 😢")
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

-- function M.show_cheatsheet()
-- function M.show_cheatsheet()
-- 	local plugins = require("lazy.core.config").plugins
-- 	local utils = require("keylint.utils")
-- 	local lines = { "🧠 KeyLint Cheat Sheet", string.rep("=", 30) }
--
-- 	local found = false
--
-- 	for _, plugin in ipairs(plugins) do
-- 		local keymaps = utils.extract_keys(plugin)
-- 		print("🔎 Checking plugin:", plugin.name)
-- 		print("📦 keymaps type:", type(keymaps), "length:", #(keymaps or {}))
-- 		if type(keymaps) == "table" and #keymaps > 0 then
-- 			found = true
-- 			table.insert(lines, "")
-- 			table.insert(lines, "Plugin: " .. (plugin.name or "<unknown>"))
--
-- 			for _, mapping in ipairs(keymaps) do
-- 				local lhs = mapping[1]
-- 				local rhs = mapping[2]
-- 				local mode = mapping.mode or "n"
-- 				local desc = mapping.desc or "no description"
-- 				local rhs_str = type(rhs) == "function" and "<function>" or tostring(rhs)
--
-- 				if lhs and rhs then
-- 					local line = string.format("  [%s] %s → %s (%s)", mode, lhs, rhs_str, desc)
-- 					table.insert(lines, line)
-- 				end
-- 			end
-- 		end
-- 	end
--
-- 	if not found then
-- 		table.insert(lines, "")
-- 		table.insert(lines, "No plugin keymaps found 😢")
-- 	end
--
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
--
-- 	local width = 70
-- 	local height = math.min(#lines + 2, vim.o.lines - 4)
-- 	local opts = {
-- 		relative = "editor",
-- 		width = width,
-- 		height = height,
-- 		row = (vim.o.lines - height) / 2,
-- 		col = (vim.o.columns - width) / 2,
-- 		style = "minimal",
-- 		border = "rounded",
-- 	}
--
-- 	vim.api.nvim_open_win(buf, true, opts)
-- end
--
return M
