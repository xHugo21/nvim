return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = { 'bash', 'diff', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
}
