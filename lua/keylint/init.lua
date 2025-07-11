local M = {}

-- Plugin meta info
M.version = require("keylint.version").version
M.codename = require("keylint.version").codename

-- Primary entrypoints
M.audit = require("keylint.audit").audit
M.display_keymaps = require("keylint.telescope_keylint").display_keymaps

-- Optional user-facing command wrapper
M.run = function()
  local report = M.audit()
  vim.notify(report, vim.log.levels.INFO, { title = "KeyLint Audit 📊" })
end

M.manifest = function()
  local message = string.format(
    "Version: %s\nCodename: %s\nMotto: %s",
    version.version,
    version.codename,
    version.motto or "No motto yet..."
  )
  vim.notify(message, vim.log.levels.INFO, { title = "☕ KeyLint Manifest" })
end
return M
