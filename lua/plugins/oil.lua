return {
  'stevearc/oil.nvim',
  lazy = false,
  opts = {
    skip_confirm_for_simple_edits = true,
    keymaps = {
      ['<C-s>'] = false, -- Disables default split-open with ctrl-s
      ['H'] = 'actions.toggle_hidden',
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)

    -- Open Oil if Neovim is started without a file or directory argument
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        require('oil').open()
      end, 0)
    end
  end,
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  keys = {
    {
      '<leader>e',
      function()
        local oil = require 'oil'
        if oil.get_current_dir() ~= nil then
          if vim.bo.modified then
            oil.save({ confirm = true }, function(err)
              if not err then
                oil.close()
              end
            end)
          else
            oil.close()
          end
        else
          oil.open()
        end
      end,
      desc = 'Toggle File Explorer',
    },
    {
      '<leader>E',
      function()
        require('oil').open(vim.fn.getcwd())
      end,
      desc = 'Toggle File Explorer (cwd)',
    },
  },
}
