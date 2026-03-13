return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',
      ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
    },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      list = { selection = { auto_insert = false } },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    snippets = { preset = 'default' },

    signature = { enabled = true },
  },
}
