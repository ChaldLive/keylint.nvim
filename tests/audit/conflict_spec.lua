local detect_conflicts = require("keylint.audit").detect_conflicts
local plugin_dupes = require("tests.mocks.plugins_with_dupes")

describe("KeyLint Conflict Detection", function()
  it("detects overlapping keymaps across plugins", function()
    local conflicts = detect_conflicts(plugin_dupes)

    assert.is_table(conflicts)
    assert.are.equal(1, #conflicts)

    local conflict = conflicts[1]
    assert.are.equal("n", conflict.mode)
    assert.are.equal("<leader>ff", conflict.lhs)
    assert.are.same({ "dupe_a", "dupe_b" }, conflict.plugins)
  end)
end)
