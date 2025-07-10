local safe_require = require("keylint.utils").safe_require

local M = {}
M.audit = safe_require("keylint.audit").audit
M.display_keymaps = safe_require("keylint.telescope_keylint").display_keymaps
return M
