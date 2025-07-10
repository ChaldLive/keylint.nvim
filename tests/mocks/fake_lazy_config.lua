-- tests/mocks/fake_lazy_config.lua
return {
  plugins = {
    {
      name = "alpha.nvim",
      keys = {
        { "<leader>a", ":Alpha", desc = "Launch alpha", mode = "n" },
      },
    },
    {
      name = "treesitter.nvim",
      keys = {
        { "<leader>t", ":TSUpdate", desc = "Update treesitter", mode = "n" },
      },
    },
  },
}
