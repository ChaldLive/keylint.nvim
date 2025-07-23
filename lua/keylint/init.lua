--[[
  🔑 keylint.nvim — Neovim Keymap Linter
  ☕ Version: v0.1.0
  👑 Codename: Coffee Release
  🧠 Motto: Seize the day, but coffee first.

  A focused diagnostic tool for auditing keymaps across Lazy-loaded plugins.
  Crafted for clarity, speed, and developer delight.
]]

local M = {}
-- keylint ui stuff
require("keylint.ui")
-- Meta
local version = require("keylint.version")
M.version = version.version
M.codename = version.codename
M.motto = version.motto

-- Entrypoints
M.audit = require("keylint.audit").audit
M.display_keymaps = require("keylint.telescope_keylint").display_keymaps

-- Commands
require("keylint.commands").setup()

return M
