-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>o", "<cmd>update<CR> <cmd>source<CR>")

vim.api.nvim_create_user_command("YankRelPath", function()
  local oil = require("oil")
  local dir = oil.get_current_dir()
  local entry = oil.get_cursor_entry()

  if dir and entry then
    local abspath = vim.fn.fnamemodify(dir .. entry.name, ":p")
    local relpath = vim.fn.fnamemodify(abspath, ":.")
    vim.fn.setreg("+", relpath)
    vim.notify("Copied relative path: " .. relpath, vim.log.levels.INFO)
  else
    local abspath = vim.fn.expand("%:p")
    if abspath == "" then
      vim.notify("No file to yank path from", vim.log.levels.WARN)
      return
    end
    local relpath = vim.fn.fnamemodify(abspath, ":.")
    vim.fn.setreg("+", relpath)
    vim.notify("Copied relative path: " .. relpath, vim.log.levels.INFO)
  end
end, { desc = "Yank path relative to cwd" })

vim.keymap.set("n", "<leader>yp", "<cmd>YankRelPath<CR>", { desc = "Yank relative path" })
