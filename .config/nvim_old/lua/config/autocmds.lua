-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Disable autoformat for PHP files and add custom BufWritePre autocmd
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "php" },
  callback = function()
    vim.b.autoformat = false
    vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>", { desc = "Format and save" })
    vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", function()
      require("custom.githunks").format_hunks(function()
        vim.cmd("w")
      end)
    end, { desc = "Format and save" })
  end,
})
