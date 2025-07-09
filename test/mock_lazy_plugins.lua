-- /keylint.nvim/test/mock_lazy_plugins.lua
return {
	{
		name = "test-plugin-alpha",
		keys = {
			{ "<leader>a", ":AlphaCommand", desc = "Alpha action", mode = "n" },
			{ "<leader>v", ":VisualAlpha", desc = "Visual action", mode = "v" },
		},
	},
	{
		name = "test-plugin-beta",
		keys = {
			{ "<leader>b", ":BetaCommand", desc = "Beta binds", mode = "n" },
		},
	},
}
