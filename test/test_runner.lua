-- test/test_runner.lua
print("👻 Preload audit:", package.loaded["keylint.audit"])
package.loaded["keylint.audit"] = nil

local safe_require = require("keylint.utils").safe_require
-- 🎯 Load helper module and audit logic
local spec = safe_require("test.spec_helper")
package.loaded["keylint.audit"] = nil -- clear any cached junk
local audit = safe_require("keylint.audit")
print("🧠 Type of audit module:", type(audit))

-- 🔧 Inject mocked plugin configuration
spec.inject_mock_lazy()

-- 🔍 Define expected keymaps to validate
local expected_keys = {
	["<leader>a"] = true,
	["<leader>b"] = true,
}

-- 📦 Run audit against injected mock plugins
--local audit = require("keylint.audit")
local plugin_maps = audit.get_plugin_keymaps()

-- ✅ Assert and print results
spec.assert_keys(plugin_maps, expected_keys)

-- 🌟 Optional debug confirmation
print("🧪 Test runner executed successfully!")
