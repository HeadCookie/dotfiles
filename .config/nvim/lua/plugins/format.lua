-- ~/.config/nvim/lua/plugins/format.lua
return {
  {
    -- Define the custom plugin
    dir = vim.fn.stdpath("config") .. "/lua/custom", -- Set the correct directory path
    name = "custom-format",
    config = function()
      -- Define a command for the custom function
      vim.api.nvim_create_user_command("FormatHunks", function()
        require("custom.githunks").format_hunks()
      end, {})
    end,
  },
}
