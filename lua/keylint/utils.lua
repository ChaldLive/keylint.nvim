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

return {
	safe_require = safe_require,
}
