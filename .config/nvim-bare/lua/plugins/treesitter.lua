return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"bash",
					"c",
					"diff",
					"go",
					"html",
					"java",
					"javascript",
					"jsdoc",
					"json",
					"jsonc",
					"kotlin",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"php",
					"python",
					"query",
					"regex",
					"sql",
					"toml",
					"tsx",
					"twig",
					"typescript",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			})
		end,
	},
}
