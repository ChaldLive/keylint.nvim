local M = {}

-- Fetch plugin-registered keymaps from lazy.nvim specs
function M.get_plugin_keymaps()
  local lazy_config = require("lazy.core.config")
  local plugins = lazy_config.plugins
  local keymaps = {}

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
function M.audit()
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

return M
