-- utils.lua
-- This module is intended to undergo future development so please
-- document with care what is done here. For the sacke of your future
-- companions.

local function safe_require(name)
	package.loaded[name] = nil
	local ok, mod = pcall(require, name)
	assert(ok, "Failed to require module: " .. name)
	return mod
end

local function extract_keys(plugin)
	local meta = plugin.__index or plugin[1] or plugin.main or plugin
	local deep_meta = (meta and type(meta.__index) == "table") and meta.__index or {}
	local keys = meta and meta.keys or deep_meta.keys

	-- Evaluate function-based keys
	if type(keys) == "function" then
		local ok, result = pcall(keys)
		if ok then
			keys = result
		end
	end

	-- Fallback to Lazy's internal cache
	if type(keys) ~= "table" or #keys == 0 then
		keys = plugin._ and plugin._.cache and plugin._.cache.keys_list or {}
	end

	-- 🪵 Add logging for debug
	print("📦 Plugin:", plugin.name)
	print("🔑 Keys:", vim.inspect(keys))

	return keys
end
-- local function extract_keys(plugin)
--   local meta = plugin.__index or plugin[1] or plugin.main or plugin
--   local deep_meta = (meta and type(meta.__index) == "table") and meta.__index or {}
--   local keys = meta and meta.keys or deep_meta.keys
--
--   -- Evaluate function-based keys
--   if type(keys) == "function" then
--     local ok, result = pcall(keys)
--     if ok then
--       keys = result
--     end
--   end
--
--   -- Fallback to Lazy's internal cache
--   if type(keys) ~= "table" or #keys == 0 then
--     keys = plugin._ and plugin._.cache and plugin._.cache.keys_list or {}
--   end
--
--   return keys
-- end
--
return {
	safe_require = safe_require,
	extract_keys = extract_keys,
}
