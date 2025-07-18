--[[
  🔑 keylint.nvim — Neovim Keymap Linter
  ☕ Version: v0.1.0
  👑 Codename: Coffee Release
  🧠 Motto: Seize the day, but coffee first.

  A focused diagnostic tool for auditing keymaps across Lazy-loaded plugins.
  Crafted for clarity, speed, and developer delight.
]]
local M = {}
M.motto = "Seize the day, but coffee first."

-- Plugin meta info

local version = require("keylint.version")
M.version = version.version
M.codename = version.codename
M.motto = version.motto

-- Primary entrypoints
M.audit = require("keylint.audit").audit
M.display_keymaps = require("keylint.telescope_keylint").display_keymaps

-- Optional user-facing command wrapper
M.run = function()
  local report = M.audit()
  vim.notify(report, vim.log.levels.INFO, { title = "KeyLint Audit 📊" })
end

M.manifest = function()
  local message =
      string.format("Version: %s\nCodename: %s\nMotto: %s", M.version, M.codename, M.motto or "No motto yet...")
  vim.notify(message, vim.log.levels.INFO, { title = "☕ KeyLint Manifest" })
end

vim.api.nvim_create_user_command("KeyLintConflicts", function()
  require("keylint.ui").show_conflicts()
end, { desc = "Show plugin keymap conflicts in a floating window" })

vim.api.nvim_create_user_command("KeyLintVersion", function()
  local v = require("keylint.version")
  vim.notify(string.format("🔑 KeyLint %s — %s", v.version, v.codename), vim.log.levels.INFO)
end, { desc = "Show KeyLint version info" })

return M
