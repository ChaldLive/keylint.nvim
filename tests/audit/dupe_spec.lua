local fnaudit = require("keylint.audit").fnaudit
local dupes = require("tests.mocks.plugins_with_dupes")

describe("Audit duplicate keymaps", function()
  it("reports overlapping keymaps across plugins", function()
    local out = fnaudit(dupes)

    -- Confirm core details
    assert.is_string(out)
    assert.is_true(out:find("Plugin: dupe_a"))
    assert.is_true(out:find("Plugin: dupe_b"))

    -- Confirm duplicated keymap appears for both
    local count = select(2, out:gsub("<leader>ff", ""))
    assert.are.equal(2, count)

    -- Optional: check sources
    assert.is_true(out:find("dupe_a.lua"))
    assert.is_true(out:find("dupe_b.lua"))
  end)
end)
