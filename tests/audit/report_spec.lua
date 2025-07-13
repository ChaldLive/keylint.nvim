local fnaudit = require("keylint.audit").fnaudit
local lazy_plugins = require("tests.mocks.fake_lazy_config")

describe("Audit report formatting", function()
	it("returns formatted report string", function()
		local report = fnaudit(lazy_plugins)
		assert.is_string(report)
		assert.is_true(report:find("Plugin: telescope.nvim") ~= nil)
		assert.is_true(report:find("<leader>ff") ~= nil)
		assert.is_true(report:find("<leader>gf") ~= nil)
		assert.is_true(report:find("source:") ~= nil) -- optional but useful
	end)
end)
