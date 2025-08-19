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
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<ESC>:w!<CR><ESC>", { desc = "Save File" })
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- LSP & Diagnostics
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Action" })
vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle focus=false filter.buf=0<CR>",
  { desc = "Open diagnostic list" })

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
  { src = "https://github.com/neovim/nvim-lspconfig",                  name = "nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",        name = "nvim-treesitter" },
  { src = "https://github.com/mason-org/mason.nvim",                   name = "manson.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim",         name = "mason-lspconfig.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim",                  name = "plenary" },

  -- UI & Theme
  { src = "https://github.com/projekt0n/github-nvim-theme.git",        name = "github-nvim-theme.git" },
  { src = "https://github.com/folke/which-key.nvim",                   name = "which-key" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons",            name = "nvim-web-devicons" },
  { src = "https://github.com/echasnovski/mini.icons",                 name = "mini.icons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim",              name = "lualine" },
  { src = "https://github.com/MunifTanjim/nui.nvim",                   name = "nui" },
  { src = "https://github.com/rcarriga/nvim-notify",                   name = "nvim-notify" },
  { src = "https://github.com/folke/noice.nvim",                       name = "noice" },
  { src = "https://github.com/christopher-francisco/tmux-status.nvim", name = "tmux-status" },

  -- Utility
  { src = "https://github.com/stevearc/oil.nvim",                      name = "oil.nvim" },
  { src = "https://github.com/folke/snacks.nvim",                      name = "snacks.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim",                name = "gitsigns" },
  { src = "https://github.com/folke/trouble.nvim",                     name = "trouble" },
  { src = "https://github.com/christoomey/vim-tmux-navigator",         name = "vim-tmux-navigator" },
  { src = "https://github.com/folke/flash.nvim",                       name = "flash" },
  { src = "https://github.com/ThePrimeagen/harpoon",                   name = "harpoon",              version = "harpoon2" },
  { src = "https://github.com/echasnovski/mini.pairs",                 name = "mini.pairs" },
})

-- ----------------------------------------------------------------------------
--  PLUGIN CONFIGURATION
-- ----------------------------------------------------------------------------

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { desc = "Mason" })

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd("set completeopt+=noselect")

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

local snacks_keymaps = {
  -- General
  { "n",          "<leader><space>", function() Snacks.picker.smart() end,                                                                  { desc = "Smart Find Files" } },
  { "n",          "<leader>,",       function() Snacks.picker.buffers() end,                                                                { desc = "Buffers" } },
  { "n",          "<leader>/",       function() Snacks.picker.grep() end,                                                                   { desc = "Grep Text" } },
  { "n",          "<leader>:",       function() Snacks.picker.command_history() end,                                                        { desc = "Command History" } },
  { "n",          "<leader>n",       function() Snacks.picker.notifications() end,                                                          { desc = "Notification History" } },
  { "n",          "<leader>uC",      function() Snacks.picker.colorschemes() end,                                                           { desc = "Colorschemes" } },
  -- Find
  { "n",          "<leader>ff",      function() Snacks.picker.files() end,                                                                  { desc = "Find Files" } },
  { "n",          "<leader>fg",      function() Snacks.picker.git_files() end,                                                              { desc = "Find Git Files" } },
  { "n",          "<leader>fr",      function() Snacks.picker.recent() end,                                                                 { desc = "Recent Files" } },
  { "n",          "<leader>fp",      function() Snacks.picker.projects() end,                                                               { desc = "Find Projects" } },
  { "n",          "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                                { desc = "Find Config File" } },
  -- Git
  { "n",          "<leader>gb",      function() Snacks.git.blame_line() end,                                                                { desc = "Git Blame Line" } },
  { "n",          "<leader>gB",      function() Snacks.gitbrowse.open() end,                                                                { desc = "Git Browse (Open)" } },
  { "n",          "<leader>gY",      function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end, { desc = "Git Browse (Yank)" } },
  { "n",          "<leader>gs",      function() Snacks.picker.git_status() end,                                                             { desc = "Git Status" } },
  { "n",          "<leader>gl",      function() Snacks.picker.git_log() end,                                                                { desc = "Git Log" } },
  { "n",          "<leader>gL",      function() Snacks.picker.git_log_line() end,                                                           { desc = "Git Log (Line)" } },
  { "n",          "<leader>gf",      function() Snacks.picker.git_log_file() end,                                                           { desc = "Git Log (File)" } },
  { "n",          "<leader>gd",      function() Snacks.picker.git_diff() end,                                                               { desc = "Git Diff" } },
  { "n",          "<leader>gS",      function() Snacks.picker.git_stash() end,                                                              { desc = "Git Stash" } },
  { "n",          "<leader>gg",      function() Snacks.lazygit.open() end,                                                                  { desc = "Lazygit" } },
  -- Search & Lists
  { "n",          "<leader>sg",      function() Snacks.picker.grep() end,                                                                   { desc = "Grep Text" } },
  { { "n", "x" }, "<leader>sw",      function() Snacks.picker.grep_word() end,                                                              { desc = "Grep Word" } },
  { "n",          "<leader>sb",      function() Snacks.picker.lines() end,                                                                  { desc = "Search Buffer Lines" } },
  { "n",          "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                                           { desc = "Grep Open Buffers" } },
  { "n",          "<leader>sh",      function() Snacks.picker.help() end,                                                                   { desc = "Search Help" } },
  { "n",          "<leader>sm",      function() Snacks.picker.marks() end,                                                                  { desc = "Search Marks" } },
  { "n",          "<leader>sR",      function() Snacks.picker.resume() end,                                                                 { desc = "Resume Last Picker" } },
  { "n",          "<leader>sq",      function() Snacks.picker.qflist() end,                                                                 { desc = "Quickfix List" } },
  { "n",          "<leader>sl",      function() Snacks.picker.loclist() end,                                                                { desc = "Location List" } },
  { "n",          "<leader>su",      function() Snacks.picker.undo() end,                                                                   { desc = "Undo History" } },
  { "n",          "<leader>sk",      function() Snacks.picker.keymaps() end,                                                                { desc = "Search Keymaps" } },
  { "n",          '<leader>s"',      function() Snacks.picker.registers() end,                                                              { desc = "Search Registers" } },
  { "n",          '<leader>s/',      function() Snacks.picker.search_history() end,                                                         { desc = "Search History" } },
  -- LSP
  { "n",          "gd",              function() Snacks.picker.lsp_definitions() end,                                                        { desc = "Goto Definition" } },
  { "n",          "gD",              function() Snacks.picker.lsp_declarations() end,                                                       { desc = "Goto Declaration" } },
  { "n",          "gr",              function() Snacks.picker.lsp_references() end,                                                         { desc = "References", nowait = true } },
  { "n",          "gI",              function() Snacks.picker.lsp_implementations() end,                                                    { desc = "Goto Implementation" } },
  { "n",          "gy",              function() Snacks.picker.lsp_type_definitions() end,                                                   { desc = "Goto Type Definition" } },
  { "n",          "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                                                            { desc = "Document Symbols" } },
  { "n",          "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                                                  { desc = "Workspace Symbols" } },
  { "n",          "<leader>sd",      function() Snacks.picker.diagnostics() end,                                                            { desc = "Workspace Diagnostics" } },
}

for _, map in ipairs(snacks_keymaps) do
  vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Flash
require("flash").setup({
  label = {
    rainbow = {
      enabled = true,
      shade = 2
    }
  }
})

local flash_keymaps = {
  { { "n", "x", "o" }, "s", function() require("flash").jump() end,       { desc = "Flash" } },
  { { "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" } },
}

for _, map in ipairs(flash_keymaps) do
  vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Trouble
require("trouble").setup({
  cmd = "Trouble"
})

-- Harpoon
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

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
  { "<leader>p", group = "[P]lugin" },
})

-- ----------------------------------------------------------------------------
--  THEME & APPEARANCE
-- ----------------------------------------------------------------------------
require("lualine").setup({
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = {
      {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 2,

        shorting_target = 40,
        symbols = {
          modified = '[+]',
          readonly = '[-]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
      }
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
require("tmux-status").setup({})
require("notify").setup({
  background_colour = "#000000",
})

require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = false,
    },
  },
})
require("github-theme").setup({ options = { transparent = true } })
vim.cmd("colorscheme github_dark_high_contrast")
vim.cmd("hi StatusLine guibg=NONE")
