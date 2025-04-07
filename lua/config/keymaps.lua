-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- CodeCompanion
vim.api.nvim_set_keymap("n", "<leader>aa", ":CodeCompanionChat<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ae", ":CodeCompanion<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ax", ":CodeCompanionActions<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>ax", ":CodeCompanionActions<CR>", { noremap = true, silent = true })
