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
vim.o.colorcolumn = "100" -- Line marker
vim.o.confirm = true -- Confirm before quitting with unsaved changes
vim.o.cursorline = true -- Highlight the current line
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.ignorecase = true -- Ignore case in search
vim.o.inccommand = "split" -- Show replacements in a split
vim.o.list = true -- Show invisible characters
vim.o.mouse = "a" -- Enable mouse support
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers
vim.o.scrolloff = 10 -- Keep cursor 10 lines from top/bottom
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.signcolumn = "yes" -- Always show the sign column
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.splitbelow = true -- Horizontal splits go below current
vim.o.splitright = true -- Vertical splits go to the right of current
vim.o.tabstop = 2 -- Number of spaces a tab counts for
vim.o.termguicolors = true -- Enable 24-bit RGB colors
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence
vim.o.undofile = true -- Persist undo history
vim.o.updatetime = 250 -- Time in ms to wait before triggering Updatetime
vim.o.winborder = "single" -- Use single line borders
vim.o.wrap = false -- Do not wrap lines

vim.opt.completeopt = { "menuone", "popup", "noinsert" } -- Always show completion menu
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- ----------------------------------------------------------------------------
--  KEYMAPS
-- ----------------------------------------------------------------------------
-- General
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<ESC>:w!<CR><ESC>", { desc = "Save File" })
vim.keymap.set("n", "<Esc>", "<CMD>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- LSP & Diagnostics
vim.keymap.set(
    "n",
    "<leader>cf",
    function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
    { desc = "Format buffer" }
)
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Action" })
vim.keymap.set(
    "n",
    "<leader>xx",
    ":Trouble diagnostics toggle focus=false filter.buf=0<CR>",
    { desc = "Open diagnostic list" }
)

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
    callback = function() vim.hl.on_yank() end,
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
    { src = "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },

    -- DAP
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim", name = "mason-nvim-dap.nvim" },
    { src = "https://codeberg.org/mfussenegger/nvim-dap", name = "nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view", name = "nvim-dap-view" },

    -- UI & Theme
    { src = "https://github.com/projekt0n/github-nvim-theme.git", name = "github-nvim-theme.git" },
    { src = "https://github.com/folke/which-key.nvim", name = "which-key" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
    { src = "https://github.com/echasnovski/mini.icons", name = "mini.icons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim", name = "lualine" },
    { src = "https://github.com/christopher-francisco/tmux-status.nvim", name = "tmux-status" },

    -- Utility
    { src = "https://github.com/stevearc/oil.nvim", name = "oil.nvim" },
    { src = "https://github.com/folke/snacks.nvim", name = "snacks.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns" },
    { src = "https://github.com/folke/trouble.nvim", name = "trouble" },
    { src = "https://github.com/christoomey/vim-tmux-navigator", name = "vim-tmux-navigator" },
    { src = "https://github.com/folke/flash.nvim", name = "flash" },
    { src = "https://github.com/ThePrimeagen/harpoon", name = "harpoon", version = "harpoon2" },
    { src = "https://github.com/echasnovski/mini.pairs", name = "mini.pairs" },
    { src = "https://github.com/echasnovski/mini.surround", name = "mini.surround" },
    { src = "https://github.com/echasnovski/mini.indentscope", name = "mini.indentscope" },
    { src = "https://github.com/echasnovski/mini.splitjoin", name = "mini.splitjoin" },
    { src = "https://github.com/towolf/vim-helm", name = "vim-helm" },
    { src = "https://github.com/saghen/blink.cmp", name = "blink.cmp", version = vim.version.range("^1") },
    { src = "https://github.com/stevearc/conform.nvim", name = "conform.nvim" },
})

-- ----------------------------------------------------------------------------
--  PLUGIN CONFIGURATION
-- ----------------------------------------------------------------------------

-- Mason
require("mason").setup()
require("mason-lspconfig").setup()
vim.keymap.set("n", "<leader>cm", ":Mason<CR>", { desc = "Mason" })

-- Completion
require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-y>"] = { "select_and_accept" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        },
    },

    cmdline = {
        keymap = {
            preset = "inherit",
            ["<CR>"] = { "accept_and_enter", "fallback" },
        },
    },

    sources = { default = { "lsp" } },
})

require("mini.pairs").setup()
require("mini.indentscope").setup()
require("mini.splitjoin").setup()
require("mini.surround").setup({
    mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
    },
})

-- Formatting
require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        php = { "php-cs-fixer" },
    },
    format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
    },
    formatters = {
        ["php-cs-fixer"] = {
            command = "php-cs-fixer",
            args = {
                "fix",
                "--rules=@Symfony",
                "$FILENAME",
            },
            stdin = false,
        },
    },
})

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "diff",
        "git_config",
        "gitattributes",
        "gitignore",
        "go",
        "helm",
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
        "phpdoc",
        "python",
        "query",
        "regex",
        "sql",
        "terraform",
        "toml",
        "tsx",
        "twig",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
})

-- stylua: ignore start
-- Snacks
local snacks_keymaps = {
    -- General
    {"n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" },},
    {"n", "<leader>,", function() Snacks.picker.buffers() end, { desc = "Buffers" },},
    {"n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep Text" },},
    {"n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "Command History" },},
    {"n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" },},
    {"n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" },},
    -- Find
    {"n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" },},
    {"n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" },},
    {"n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent Files" },},
    {"n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Find Projects" },},
    {"n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find Config File" },},
    -- Git
    {"n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" },},
    {"n", "<leader>gB", function() Snacks.gitbrowse.open() end, { desc = "Git Browse (Open)" },},
    {"n", "<leader>gY", function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false, }) end, { desc = "Git Browse (Yank)" },},
    {"n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" },},
    {"n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" },},
    {"n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log (Line)" },},
    {"n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log (File)" },},
    {"n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff" },},
    {"n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" },},
    {"n", "<leader>gg", function() Snacks.lazygit.open() end, { desc = "Lazygit" },},
    -- Search & Lists
    {"n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep Text" },},
    {{ "n", "x" }, "<leader>sw", function() Snacks.picker.grep_word() end, { desc = "Grep Word" },},
    {"n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Search Buffer Lines" },},
    {"n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Grep Open Buffers" },},
    {"n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Search Help" },},
    {"n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Search Marks" },},
    {"n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume Last Picker" },},
    {"n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" },},
    {"n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" },},
    {"n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" },},
    {"n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Search Keymaps" },},
    {"n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Search Registers" },},
    {"n", "<leader>s/", function() Snacks.picker.search_history() end, { desc = "Search History" },},
    -- LSP
    {"n", "/gd", function() Snacks.picker.lsp_definitions() end, {desc = "Goto Definition"},},
    {"n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" },},
    {"n", "gr", function() Snacks.picker.lsp_references() end, { desc = "References", nowait = true },},
    {"n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" },},
    {"n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" },},
    {"n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "Document Symbols" },},
    {"n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" },},
    {"n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Workspace Diagnostics" },},
}
-- stylua: ignore end

for _, map in ipairs(snacks_keymaps) do
    vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Flash
require("flash").setup({
    label = {
        rainbow = {
            enabled = true,
            shade = 2,
        },
    },
})

local flash_keymaps = {
    { { "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" } },
    { { "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" } },
}

for _, map in ipairs(flash_keymaps) do
    vim.keymap.set(map[1], map[2], map[3], map[4])
end

-- Trouble
require("trouble").setup({
    cmd = "Trouble",
})

-- DAP
local dap = require("dap")
vim.keymap.set("n", "<leader>du", ":DapViewToggle<CR>", { desc = "Toggle Debug UI" })
vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", { desc = "Continue/Start Debugger" })
vim.keymap.set("n", "<leader>dt", ":DapTerminate<CR>", { desc = "Terminate Debugger" })
vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", ":DapStepInto<CR>", { desc = "Step Into" })
vim.keymap.set("n", "<leader>dx", ":DapStepOut<CR>", { desc = "Step Out" })
vim.keymap.set("n", "<leader>dX", ":DapClearBreakpoints<CR>", { desc = "Clear all breakpoints" })

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

-- Harpoon
local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

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
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            {
                "filename",
                file_status = true,
                newfile_status = false,
                path = 2,

                shorting_target = 40,
                symbols = {
                    modified = "[+]",
                    readonly = "[-]",
                    unnamed = "[No Name]",
                    newfile = "[New]",
                },
            },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
})

require("github-theme").setup({ options = { transparent = true } })
vim.cmd("colorscheme github_dark_high_contrast")
vim.cmd("hi StatusLine guibg=NONE")
