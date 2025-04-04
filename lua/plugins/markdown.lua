return {
  "MeanderingProgrammer/markdown.nvim",
  name = "render-markdown",
  ft = { "markdown", "codecompanion" },
  config = function()
    require("render-markdown").setup({})
  end,
}
