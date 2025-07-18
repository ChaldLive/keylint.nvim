local ui = require("keylint.ui")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("KeyLintCheatSheet", ui.show_cheatsheet, {
    desc = "Show all plugin keymaps grouped by plugin",
  })
end

return M
