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
}
