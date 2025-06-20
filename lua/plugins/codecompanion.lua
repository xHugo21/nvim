local config = {
  -- extensions = {
  --   vectorcode = {
  --     opts = { add_tool = true, add_slash_command = true, tool_opts = {} },
  --   },
  -- },
  adapters = {
    copilot = function()
      return require("codecompanion.adapters").extend("copilot", {
        schema = {
          model = {
            default = "claude-sonnet-4",
          },
        },
      })
    end,
  },
  strategies = {
    -- CHAT STRATEGY ----------------------------------------------------------
    chat = {
      adapter = "copilot",
      variables = {
        buffer = {
          opts = { default_params = "watch" },
        },
      },
      roles = {
        llm = function(adapter)
          return adapter.formatted_name .. " (model=" .. adapter.parameters.model .. ")"
        end,
        user = "Me",
      },
      slash_commands = {
        ["file"] = { -- Maps <C-p> to enter files as context
          keymaps = {
            modes = {
              i = "<C-p>",
              n = "<C-p>",
            },
          },
        },
      },
    },
  },
  -- DISPLAY OPTIONS ----------------------------------------------------------
  display = {
    action_palette = {
      width = 95,
      height = 10,
      prompt = "Prompt ", -- Prompt used for interactive LLM calls
      provider = "snacks", -- default|telescope|mini_pick|snacks
      opts = {
        show_default_actions = true, -- Show the default actions in the action palette?
        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
      },
    },
    chat = {
      window = {
        layout = "vertical", -- float|vertical|horizontal|buffer
        border = "rounded",
        height = 0.8,
        width = 0.40,
        relative = "editor",
        opts = {
          breakindent = true,
          cursorcolumn = false,
          cursorline = false,
          foldcolumn = "0",
          linebreak = true,
          list = false,
          signcolumn = "no",
          spell = false,
          wrap = true,
        },
      },
      intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
      show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
      show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
      separator = "─", -- The separator between the different messages in the chat buffer
      show_settings = false, -- Show LLM settings at the top of the chat buffer?
      show_token_count = true, -- Show the token count for each response?
      start_in_insert_mode = false, -- Open the chat buffer in insert mode?
    },
    diff = {
      enabled = true,
      close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
      layout = "vertical", -- vertical|horizontal split for default provider
      opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      provider = "default", -- default|mini_diff
    },
    inline = {
      -- If the inline prompt creates a new buffer, how should we display this?
      layout = "vertical", -- vertical|horizontal|buffer
    },
  },
  -- GENERAL OPTIONS ----------------------------------------------------------
  opts = {
    log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
    -- If this is false then any default prompt that is marked as containing code
    -- will not be sent to the LLM. Please note that whilst I have made every
    -- effort to ensure no code leakage, using this is at your own risk
    send_code = true,
  },
}

return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  config = function()
    -- mappings group
    local wk = require("which-key")
    local defaults = {
      { "<leader>a", group = "+AI", mode = { "n", "v" } },
    }
    wk.add(defaults)
    -- plugin setup
    require("codecompanion").setup(config)
  end,
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n" }, desc = "Toggle CodeCompanion Chat" },
    { "<leader>an", "<cmd>CodeCompanionChat<CR>", mode = { "n" }, desc = "Open CodeCompanion Chat" },
    { "<leader>ae", ":CodeCompanion<CR>", mode = { "n", "v" }, desc = "CodeCompanion Prompt" },
    { "<leader>ax", "<cmd>CodeCompanionActions<CR>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
  },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lua/plenary.nvim" },
    {
      "saghen/blink.cmp",
      lazy = false,
      version = "*",
      opts = {
        keymap = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        sources = {
          default = { "lsp", "path", "buffer", "codecompanion" },
        },
        cmdline = {
          sources = {}, -- Disable sources for command-line mode
        },
      },
    },
    -- {
    --   "Davidyz/VectorCode",
    --   dependencies = { "nvim-lua/plenary.nvim" },
    -- },
  },
}
