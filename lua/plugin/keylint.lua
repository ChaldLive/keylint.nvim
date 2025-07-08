-- plugin/keylint.lua
vim.api.nvim_create_user_command("KeylintAudit", function()
	require("keylint.audit").audit()
end, {
	desc = "Audit lazy.nvim plugin keymaps for potential conflicts",
})
