return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local cwd = vim.fn.getcwd()

      if not dap.adapters["pwa-chrome"] then
        dap.adapters["pwa-chrome"] = {
          type = "server",
          host = "localhost",
          port = 9222,
          executable = {
            command = "node",
            args = {
              -- Replace with the path to your JS debug adapter
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "9222",
            },
          },
        }
      end

      local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      for _, language in ipairs(js_filetypes) do
        dap.configurations[language] = dap.configurations[language] or {}
        table.insert(dap.configurations[language], {
          type = "pwa-chrome",
          request = "launch",
          name = 'Launch Chrome with "localhost"',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
                if url == nil or url == "" then
                  return
                else
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = "inspector",
          sourceMaps = true,
          port = 9222,
          skipFiles = { "<node_internals>/**", "node_modules/**" },
        })

        -- Configure Xdebug for PHP with conditional settings
        if cwd == "/Volumes/Projects/api-sign" then
          dap.adapters.php = {
            type = "executable",
            command = "php-debug-adapter",
          }

          dap.configurations.php = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9003,
              ideKey = "SIGNING_SERVICE",
              pathMappings = {
                ["/app/data"] = "/Volumes/Projects/api-sign",
              },
            },
          }
        elseif cwd == "/Volumes/projects/api-auth" then
          dap.adapters.php = {
            type = "executable",
            command = "php-debug-adapter",
          }

          dap.configurations.php = {
            {
              type = "php",
              request = "launch",
              name = "Listen for Xdebug",
              port = 9004,
              ideKey = "API_AUTH",
              pathMappings = {
                ["/app/data"] = "/Volumes/projects/api-auth",
              },
            },
          }
        end
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "php-debug-adapter",
      },
    },
  },
}
