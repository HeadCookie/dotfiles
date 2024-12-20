-- ~/.config/nvim/lua/custom/githunks.lua
local M = {}

M.format_hunks = function(callback)
  local ignore_filetypes = {}
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.notify("Range formatting for " .. vim.bo.filetype .. " not working properly.")
    if callback then
      callback()
    end
    return
  end

  local hunks = require("gitsigns").get_hunks()
  if hunks == nil then
    if callback then
      callback()
    end
    return
  end

  local format = require("conform").format

  local function format_range()
    if next(hunks) == nil then
      vim.notify("Formatted hunks", "info")
      if callback then
        callback()
      end
      vim.api.nvim_input("<esc>")
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      local start = hunk.added.start
      local last = start + hunk.added.count
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, async = true, lsp_fallback = true }, function()
        vim.defer_fn(function()
          format_range(callback)
        end, 1)
      end)
    end
  end

  format_range()
end

return M
