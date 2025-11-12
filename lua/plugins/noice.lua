return {
  { -- Improved UI for command line and messages. Adds LSP status notifications
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = { -- Disable LSP signature popup override
        hover = {
          enabled = false,
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = '10%',
            col = '50%',
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
}
