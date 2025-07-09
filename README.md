
# 🧠 keylint.nvim

**Keymap sanity for Neovim plugin users.**  
A lazy.nvim companion that audits plugin `keys = {}` declarations and checks for conflicts with your config-defined mappings.

---

### 🚀 Features

- 📜 Audits all plugin mappings from your lazy.nvim spec
- 🧠 Detects keybinding conflicts against your global `vim.keymap.set()` calls
- ✅ Flags duplicate or shadowed bindings
- 📝 *Coming soon*: export results to `keymaps.md`, filter audits, Telescope UI integration

---

### 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "ChaldLive/keylint.nvim",
  cmd = "KeylintAudit",
  lazy = true,
}
