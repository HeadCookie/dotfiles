return {
  { "marilari88/neotest-vitest" },
  -- stylua: ignore start
  {
    "rcasia/neotest-java",
    init = function()
      -- override the default keymaps.
      -- needed until neotest-java is integrated in LazyVim
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- run test file
      keys[#keys + 1] = {"<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, mode = "n" }
      -- run nearest test
      keys[#keys + 1] = {"<leader>tr", function() require("neotest").run.run() end, mode = "n" }
      -- debug test file
      keys[#keys + 1] = {"<leader>tD", function() require("jdtls.dap").test_class() end, mode = "n" }
      -- debug nearest test
      keys[#keys + 1] = {"<leader>td", function() require("jdtls.dap").test_nearest_method() end, mode = "n" }
    end,
  },
  {
    "nvim-neotest/neotest",
    opts = { adapters = { "neotest-vitest", "neotest-java" } },
  },
}
