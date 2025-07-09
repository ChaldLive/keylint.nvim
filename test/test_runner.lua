-- test/test_runner.lua

-- 🎯 Load helper module and audit logic
local spec = require("test.spec_helper")
--local audit = require("keylint.audit")
package.loaded["keylint.audit"] = nil -- clear any cached junk
local audit = require("keylint.audit")
print("🧠 Type of audit module:", type(audit))

-- 🔧 Inject mocked plugin configuration
spec.inject_mock_lazy()

-- 🔍 Define expected keymaps to validate
local expected_keys = {
	["<leader>a"] = true,
	["<leader>b"] = true,
}

-- 📦 Run audit against injected mock plugins
local plugin_maps = audit.get_plugin_keymaps()

-- ✅ Assert and print results
spec.assert_keys(plugin_maps, expected_keys)

-- 🌟 Optional debug confirmation
print("🧪 Test runner executed successfully!")
