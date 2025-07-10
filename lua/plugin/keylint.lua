-- plugin/keylint.lua
local safe_require = require("keylint.utils").safe_require

vim.api.nvim_create_user_command("KeylintAudit", function()
	safe_require("keylint.audit").audit()
end, {
	desc = "Audit lazy.nvim plugin keymaps for potential conflicts",
})
