return {
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   priority = 1000,
  -- },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   priority = 1000,
  -- },
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   priority = 1000,
  -- },
  {
    "datsfilipe/vesper.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      overrides = {
        Normal = { bg = "#282C34" },
      },
    },
  },
  -- {
  --   "rose-pine/neovim",
  --   priority = 1000,
  -- },
  -- {
  --   "wnkz/monoglow.nvim",
  --   priority = 1000,
  -- config = function()
  --   require("monoglow").setup({
  --     -- Change the "glow" color
  --     on_colors = function(colors)
  --       colors.glow = "#fd1b7c" -- Custom glow color
  --     end,
  --   })
  --   vim.cmd("colorscheme monoglow") -- Apply the colorscheme
  -- end,
  -- },
}
