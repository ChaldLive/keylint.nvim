local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local keylint = require("keylint.audit")

local function display_keymaps()
	local keymaps = keylint.get_plugin_keymaps()

	pickers
		.new({}, {
			prompt_title = "🔍 KeyLint Keymap Explorer",
			finder = finders.new_table({
				results = keymaps,
				entry_maker = function(entry)
					return {
						value = entry,
						display = string.format("[%s] %s → %s (%s)", entry.plugin, entry.key, entry.cmd, entry.desc),
						ordinal = entry.key .. " " .. entry.cmd .. " " .. entry.plugin,
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(_, map)
				map("i", "<CR>", function()
					local selection = action_state.get_selected_entry()
					vim.notify(
						string.format(
							"🔑 %s → %s [%s]",
							selection.value.key,
							selection.value.cmd,
							selection.value.plugin
						),
						vim.log.levels.INFO
					)
					actions.close()
				end)
				return true
			end,
		})
		:find()
end

return {
	display_keymaps = display_keymaps,
}
