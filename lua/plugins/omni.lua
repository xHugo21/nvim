return {
  "harshrajsachan/omni.nvim",
  lazy = false,
  priority = 1000,

  config = function()
    vim.g.omnitheme_transparent = true

    vim.cmd("colorscheme blossom")
  end,
}
