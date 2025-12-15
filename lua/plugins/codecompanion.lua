local prompts = {
  ['Naming Expert'] = {
    strategy = 'inline',
    description = 'Rename variables / functions to be more descriptive',
    opts = {
      short_name = 'rename',
      auto_submit = true,
    },
    prompts = {
      {
        role = 'user',
        content = 'Rename the variables and functions in the selected code to be descriptive, following the naming convention of this language (e.g., camelCase vs snake_case). Keep the logic exactly the same.',
        opts = {
          contains_code = true,
        },
      },
    },
  },
  ['Git Commit'] = {
    strategy = 'chat',
    description = 'Generate a commit message for current changes',
    opts = {
      short_name = 'commit',
      auto_submit = true,
    },
    prompts = {
      {
        role = 'system',
        content = 'You are an expert at writing clear, concise Git commit messages. Follow the Conventional Commits specification (e.g., feat:, fix:, docs:, chore:). Output ONLY the commit message, no conversation.',
      },
      {
        role = 'user',
        content = function()
          local function get_diff(cmd)
            local handle = io.popen(cmd)
            if not handle then
              return nil
            end
            local result = handle:read '*a'
            handle:close()
            return result
          end

          -- 1. Try staged changes
          local diff = get_diff 'git diff --cached'

          -- 2. Fallback to unstaged changes if empty
          if not diff or diff == '' then
            diff = get_diff 'git diff'
          end

          -- 3. Handle no changes found
          if not diff or diff == '' then
            return 'I have no changes in my git repository to commit.'
          end

          return 'Write a commit message for the following changes:\n\n```diff\n' .. diff .. '\n```'
        end,
        opts = {
          contains_code = false,
        },
      },
    },
  },
}

return {
  'olimorris/codecompanion.nvim',
  opts = {
    display = {
      action_palette = {
        opts = {
          show_preset_actions = false,
          show_preset_prompts = false,
        },
      },
    },
    strategies = {
      chat = {
        adapter = {
          name = 'copilot',
          model = 'gpt-4.1',
        },
        roles = {
          llm = function(adapter)
            return adapter.formatted_name .. ' (' .. adapter.parameters.model .. ')'
          end,
          user = 'Me',
        },
        slash_commands = {
          ['file'] = {
            keymaps = {
              modes = {
                i = '<C-p>',
                n = '<C-p>',
              },
            },
          },
        },
      },
    },
    prompt_library = prompts,
  },
  keys = {
    { '<leader>aa', '<cmd>CodeCompanionChat Toggle<CR>', mode = { 'n' }, desc = 'Toggle CodeCompanion Chat' },
    { '<leader>ae', '<cmd>%CodeCompanion<CR>', mode = { 'n' }, desc = 'CodeCompanion Buffer Prompt' },
    { '<leader>ae', '<cmd>CodeCompanion<CR>', mode = { 'v' }, desc = 'CodeCompanion Visual Prompt' },
    { '<leader>ax', '<cmd>CodeCompanionActions<CR>', mode = { 'n', 'v' }, desc = 'Code Companion Actions' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
}
