return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        transparency = true,
      },
    },
  },
  {
    "kyza0d/xeno.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("xeno").new_theme("xeno", {
        base = "#1E1E1E",
        accent = "#fd1b7c",
        transparent = true,
      })
      vim.cmd("colorscheme xeno") -- Overrides colorscheme
    end,
  },
  -- {
  --   "datsfilipe/vesper.nvim",
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --     palette_overrides = {
  --       bgOption = "NONE",
  --       fg = "#E6E6E6",
  --     },
  --   },
  -- },
  -- {
  --   "wnkz/monoglow.nvim",
  --   priority = 1000,
  --   opts = {
  --     on_colors = function(colors)
  --       colors.glow = "#fd1b7c"
  --     end,
  --   },
  -- },
  -- { "arcticicestudio/nord-vim", priority = 1000 },
  -- { "ellisonleao/gruvbox.nvim", priority = 1000, opts = {
  --   background = "dark",
  -- } },
}
