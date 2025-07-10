-- tests/audit/keymap_spec.lua

local fake_config = require("tests.mocks.fake_lazy_config")

require("keylint.utils").safe_require = function(name)
  if name == "lazy.core.config" then
    return fake_config
  else
    return require(name)
  end
end

-- ✅ Only require audit after monkey-patching
local audit = require("keylint.audit")

local describe = require("plenary/busted").describe
local it = require("plenary/busted").it
local assert = require("luassert")

describe("Audit Module", function()
  it("returns a list of mocked keymaps", function()
    local result = audit.get_plugin_keymaps()
    assert.is_table(result)
    assert.is_true(#result == 2)
  end)

  it("contains expected fields", function()
    local result = audit.get_plugin_keymaps()
    for _, map in ipairs(result) do
      assert.is_string(map.plugin)
      assert.is_string(map.mode)
      assert.is_string(map.key)
      assert.is_string(map.cmd)
      assert.is_string(map.desc)
    end
  end)
end)
