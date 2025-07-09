-- lua/keylint/init.lua

local M = {}

-- 🔧 Plugin setup entry point (optional for future config)
function M.setup(opts)
	-- Placeholder for plugin configuration
	-- e.g. M.config = vim.tbl_deep_extend("force", default_opts, opts or {})
end

-- 🌟 Load core functionality
M.audit = require("keylint.audit")
--M.utils = require("keylint.utils")

-- 🚀 Developer command for running test suite
vim.api.nvim_create_user_command("KeylintTest", function()
	local root = debug.getinfo(1, "S").source:match("@(.*/)")
	local test_runner = root:gsub("lua/keylint/", "") .. "test/test_runner.lua"
	dofile(test_runner)
end, {
	desc = "Run Keylint test suite",
})

return M
