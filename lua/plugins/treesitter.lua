return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'regex', 'diff', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = { enable = true },
  },
}
