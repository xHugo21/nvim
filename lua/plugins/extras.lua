-- LazyVim extra plugins
return {
  -- Languages
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -- ESLint / Prettier
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  -- Animations
  -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
  -- Git diffs
  { import = "lazyvim.plugins.extras.editor.mini-diff" },
}
