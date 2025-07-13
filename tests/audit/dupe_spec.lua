local fnaudit = require("keylint.audit").fnaudit
local plugin_dupes = require("tests.mocks.plugins_with_dupes")

describe("KeyLint Duplicate Keymap Detection", function()
	it("shows duplicate keymap across plugins", function()
		local report = fnaudit(plugin_dupes)

		assert.is_true(report:find("<leader>ff"))
		assert.is_true(report:find("dupe_a"))
		assert.is_true(report:find("dupe_b"))
	end)
end)
