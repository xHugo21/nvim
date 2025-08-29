return {
  "ibhagwan/fzf-lua",
  keys = function(_, keys)
    keys[#keys + 1] = { "<leader>sb", false }

    keys[#keys + 1] = {
      "<leader>sb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Switch Buffer",
    }

    return keys
  end,

  opts = function(_, opts)
    return vim.tbl_deep_extend("force", opts or {}, {
      winopts = {
        preview = {
          previewer = "builtin",
          layout = "vertical",
          horizontal = "down:40%",
          border = "rounded",
          wrap = "nowrap",
        },
      },
    })
  end,
}
