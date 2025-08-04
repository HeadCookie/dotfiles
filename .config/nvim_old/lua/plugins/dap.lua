return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = function()
      local dap = require("dap")

      -- === PHP / Xdebug adapters per‐project ===
      local cwd = vim.fn.getcwd()
      if cwd:match("api%-sign$") then
        dap.adapters.php = { type = "executable", command = "php-debug-adapter" }
        dap.configurations.php = {
          {
            name = "Xdebug Sign",
            type = "php",
            request = "launch",
            port = 9003,
            ideKey = "SIGNING_SERVICE",
            pathMappings = { ["/app/data"] = cwd },
          },
        }
      elseif cwd:match("api%-auth$") then
        dap.adapters.php = { type = "executable", command = "php-debug-adapter" }
        dap.configurations.php = {
          {
            name = "Xdebug Auth",
            type = "php",
            request = "launch",
            port = 9004,
            ideKey = "API_AUTH",
            pathMappings = { ["/app/data"] = cwd },
          },
        }
      end
    end,
  },
}
