return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',
    opts = {},
    keys = {
      { '<leader>tp', '<cmd>TypstPreview<CR>', mode = { 'n' }, desc = 'Typst Preview' },
      { '<leader>tc', '<cmd>!typst compile %<CR>', mode = { 'n' }, desc = 'Typst Compile' },
    },
  },
}
