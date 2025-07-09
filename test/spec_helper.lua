local M = {}

-- 🔧 Get absolute path of this file
local source_path = debug.getinfo(1, "S").source:sub(2) -- removes "@"
local abs_path = vim.fn.fnamemodify(source_path, ":p:h") -- full directory path

-- 👀 Print absolute path for inspection
print("📦 Absolute base path is:", abs_path)

-- 🧪 Load mock plugin data
function M.inject_mock_lazy()
	local plugin_path = abs_path .. "/mock_lazy_plugins.lua"
	print("🔍 Attempting to load plugin file from:", plugin_path)

	local plugins = dofile(plugin_path)
	assert(type(plugins) == "table", "🚨 mock_lazy_plugins.lua must return a table")

	package.loaded["lazy.core.config"] = {
		plugins = plugins,
	}
end

-- ✅ Assertion helper
function M.assert_keys(plugin_maps, expected_keys)
	local failures = {}
	for _, map in ipairs(plugin_maps) do
		if not expected_keys[map.key] then
			table.insert(failures, map.key)
			print(string.format("❌ Unexpected key: %s", map.key))
		end
	end

	if #failures == 0 then
		print("✅ All expected keys verified!")
	else
		print(string.format("⚠️ %d unexpected keys found!", #failures))
	end
end

return M
