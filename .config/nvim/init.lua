-- ----------------------------------------------------------------------------
--  GLOBALS
-- ----------------------------------------------------------------------------
local vim = vim
vim.g.have_nerd_font = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
--  OPTIONS
-- ----------------------------------------------------------------------------
vim.o.clipboard = "unnamedplus" -- Sync with system clipboard
vim.o.colorcolumn = '100'       -- Line marker
vim.o.confirm = true            -- Confirm before quitting with unsaved changes
vim.o.cursorline = true         -- Highlight the current line
vim.o.expandtab = true          -- Use spaces instead of tabs
vim.o.ignorecase = true         -- Ignore case in search
vim.o.inccommand = "split"      -- Show replacements in a split
vim.o.list = true               -- Show invisible characters
vim.o.mouse = "a"               -- Enable mouse support
vim.o.number = true             -- Show line numbers
vim.o.relativenumber = true     -- Show relative line numbers
vim.o.scrolloff = 10            -- Keep cursor 10 lines from top/bottom
vim.o.shiftwidth = 2            -- Size of an indent
vim.o.signcolumn = "yes"        -- Always show the sign column
vim.o.smartcase = true          -- Don't ignore case with capitals
vim.o.splitbelow = true         -- Horizontal splits go below current
vim.o.splitright = true         -- Vertical splits go to the right of current
vim.o.tabstop = 2               -- Number of spaces a tab counts for
vim.o.termguicolors = true      -- Enable 24-bit RGB colors
vim.o.timeoutlen = 300          -- Time to wait for a mapped sequence
vim.o.undofile = true           -- Persist undo history
vim.o.updatetime = 250          -- Time in ms to wait before triggering Updatetime
vim.o.winborder = "single"      -- Use single line borders
vim.o.wrap = false              -- Do not wrap lines

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- ----------------------------------------------------------------------------
--  KEYMAPS
-- ----------------------------------------------------------------------------
-- General
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", ":write<CR><ESC>", { desc = "Save File" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- LSP & Diagnostics
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Plugins
vim.keymap.set("n", "<leader>pu", vim.pack.update, { desc = "Update plugins" })
vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })

-- Tmux Navigation
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Window left" })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Window down" })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Window up" })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Window right" })

-- ----------------------------------------------------------------------------
--  AUTOCMDS
-- ----------------------------------------------------------------------------
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format on save",
  callback = function()
    vim.lsp.buf.format { filter = function(client) return client.name ~= "lua_ls" end }
  end,
})


-- ----------------------------------------------------------------------------
--  PLUGINS
-- ----------------------------------------------------------------------------
vim.pack.add({
  -- Core
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter" },
  { src = "https://github.com/mason-org/mason.nvim", name = "manson.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim", name = "mason-lspconfig.nvim" },

  -- UI & Theme
  { src = "https://github.com/vague2k/vague.nvim.git", name = "vague.nvim.git" },
  { src = "https://github.com/folke/which-key.nvim", name = "which-key" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
  { src = "https://github.com/echasnovski/mini.icons", name = "mini.icons" },

  -- Utility & Telescope-like
  { src = "https://github.com/stevearc/oil.nvim", name = "oil.nvim" },
  { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
  { src = "https://github.com/folke/lazydev.nvim", name = "lazydev.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator", name = "vim-tmux-navigator" },
})

-- ----------------------------------------------------------------------------
--  PLUGIN CONFIGURATION
-- ----------------------------------------------------------------------------

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()

-- LSP
vim.cmd("set completeopt+=noselect")
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash", "c", "diff", "git_config", "gitattributes", "gitignore", "go",
    "html", "java", "javascript", "jsdoc", "json", "jsonc", "kotlin", "lua",
    "luadoc", "luap", "markdown", "markdown_inline", "php", "phpdoc", "python",
    "query", "regex", "sql", "terraform", "toml", "tsx", "twig", "typescript",
    "vim", "vimdoc", "xml", "yaml",
  },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Snacks
-- require("snacks").setup({
--   picker = { enabled = true },
--   lazygit = { enabled = true },
--   git = { enabled = true },
--   gitbrowse = { enabled = true },
--   input = { enabled = true },
--   indent = { enabled = true },
-- })

local snacks_keymaps = {
  -- General
  { "n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" } },
  { "n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" } },
  { "n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Text" } },
  { "n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" } },
  { "n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" } },
  { "n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" } },
  -- Find
  { "n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" } },
  { "n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" } },
  { "n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files" } },
  { "n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Find Projects" } },
  { "n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" } },
  -- Git
  { "n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" } },
  { "n", "<leader>gB", function() Snacks.gitbrowse.open() end, { desc = "Git Browse (Open)" } },
  { "n", "<leader>gY", function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end, { desc = "Git Browse (Yank)" } },
  { "n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" } },
  { "n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" } },
  { "n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log (Line)" } },
  { "n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log (File)" } },
  { "n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff" } },
  { "n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" } },
  { "n", "<leader>gg", function() Snacks.lazygit.open() end, { desc = "Lazygit" } },
  -- Search & Lists
  { "n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep Text" } },
  { { "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep Word" } },
  { "n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Search Buffer Lines" } },
  { "n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" } },
  { "n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Search Help" } },
  { "n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Search Marks" } },
  { "n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume Last Picker" } },
  { "n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" } },
  { "n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" } },
  { "n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" } },
  { "n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Search Keymaps" } },
  { "n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Search Registers" } },
  { "n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" } },
  -- LSP
  { "n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" } },
  { "n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" } },
  { "n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true } },
  { "n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" } },
  { "n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" } },
  { "n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "Document Symbols" } },
  { "n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" } },
  { "n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Workspace Diagnostics" } },
}
for _, map in ipairs(snacks_keymaps) do
  vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Oil (File Explorer)
require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  use_default_keymaps = false,
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-x>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
})

-- Which-key
local wk = require("which-key")

wk.add({
  { "<leader>c", group = "[C]ode" },
  { "<leader>g", group = "[G]it" },
  { "<leader>s", group = "[S]earch" },
  { "<leader>f", group = "[F]ind" },
  { "<leader>p", group = "[P]ack" },
})

-- ----------------------------------------------------------------------------
--  THEME & APPEARANCE
-- ----------------------------------------------------------------------------
require("vague").setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd("hi StatusLine guibg=NONE")
