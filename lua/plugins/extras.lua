-- LazyVim extra plugins
return {
  -- Languages
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -- ESLint / Prettier
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  -- Animations
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  -- Git diffs
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
  -- Useful when there are embedded languages in certain types of files (e.g. Vue or React)
  { "joosepalviste/nvim-ts-context-commentstring", lazy = true },
}
