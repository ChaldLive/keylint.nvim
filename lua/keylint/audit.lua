local M = {}
local safe_require = require("keylint.utils").safe_require

-- Fetch plugin-registered keymaps from lazy.nvim specs
function M.get_plugin_keymaps()
  local lazy_config = safe_require("lazy.core.config")
  local plugins = lazy_config.plugins
  local keymaps = {}

  -- The _, is simply lua shorthand for! We are not using the key, ignore it please.
  for _, plugin in pairs(plugins) do
    if plugin.keys then
      for _, mapping in ipairs(plugin.keys) do
        local key = type(mapping) == "table" and mapping[1] or mapping
        local cmd = type(mapping) == "table" and mapping[2] or "?"
        local desc = (type(mapping) == "table" and mapping.desc) or "no description"
        local mode = (type(mapping) == "table" and mapping.mode) or "n"

        table.insert(keymaps, {
          plugin = plugin.name,
          mode = mode,
          key = key,
          cmd = cmd,
          desc = desc,
        })
      end
    end
  end

  return keymaps
end

-- Check for keymap conflicts with global Neovim keymaps
function M.fnaudit()
  local plugin_maps = M.get_plugin_keymaps()
  local global_maps = vim.api.nvim_get_keymap("n") -- Only normal mode for now

  local global_keys = {}
  for _, map in ipairs(global_maps) do
    global_keys[map.lhs] = true
  end

  print("🔍 KeyLint Audit Report")
  print(string.rep("=", 30))

  for _, map in ipairs(plugin_maps) do
    local status_icon = global_keys[map.key] and "⚠️" or "✅"
    local status_note = global_keys[map.key] and "conflict with global mapping" or "unused globally"
    local line = string.format("%s [%s] %s → %s (%s)", status_icon, map.plugin, map.key, map.cmd, status_note)
    print(line)
  end
end

-- This little banby sniffs the plugins added by lazy.nvim, to check for overlapping keymaps.
-- Which tend to haappen far more often than one mighi believe.
function M.detect_conflicts(plugin_list)
  local seen = {}
  local conflicts = {}

  for _, plugin in ipairs(plugin_list) do
    for _, mapping in ipairs(plugin.keys or {}) do
      local mode = mapping.mode or "n"
      local lhs = mapping[1] -- key
      local key = mode .. ":" .. lhs

      if seen[key] then
        -- Already seen → conflict
        if not conflicts[key] then
          conflicts[key] = {
            mode = mode,
            lhs = lhs,
            plugins = { seen[key], plugin.name },
          }
        else
          table.insert(conflicts[key].plugins, plugin.name)
        end
      else
        seen[key] = plugin.name
      end
    end
  end

  -- Convert to array
  local result = {}
  for _, conflict in pairs(conflicts) do
    table.insert(result, conflict)
  end

  return result
end

return M
