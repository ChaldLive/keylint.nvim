local ui = require("keylint.ui")

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("KeyLintDebugKeys", function()
		if keylint_debug_plugin_keys then
			keylint_debug_plugin_keys()
		else
			print("❌ Debug function not available")
		end
	end, {
		desc = "Debug: Dump plugin keymap metadata to :messages",
	})
end

return M
