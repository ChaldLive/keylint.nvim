local ui = require("keylint.ui")

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("KeyLintConflicts", ui.show_conflicts, {
    desc = "Show plugin keymap conflicts in a floating window",
  })
end

return M
