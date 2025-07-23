local M = {}

function M.setup()
	require("keylint.commands.conflicts").setup()
	require("keylint.commands.cheatsheet").setup()
	require("keylint.commands.manifest").setup()
	require("keylint.commands.debug").setup()
end

return M
