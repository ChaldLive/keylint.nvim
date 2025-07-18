local M = {}

function M.setup()
  vim.api.nvim_create_user_command("KeyLintManifest", function()
    local version = require("keylint.version")
    local message =
        string.format("Version: %s\nCodename: %s\nMotto: %s", version.version, version.codename, version.motto)
    vim.notify(message, vim.log.levels.INFO, { title = "☕ KeyLint Manifest" })
  end, {
    desc = "Show KeyLint plugin metadata",
  })
end

return M
