return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      diagnostics = {
        virtual_text = false,
      },
    },
  },
}
