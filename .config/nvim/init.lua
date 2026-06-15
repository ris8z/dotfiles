-----------------------------------------------------------------
-- general
-----------------------------------------------------------------

vim.loader.enable()

-- general: basics
vim.o.wrap = false
vim.g.mapleader = " "


-- general: indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4


-- general: quality of life
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.winborder = "rounded"
vim.opt.conceallevel = 1
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.o.updatetime = 250      
vim.o.timeoutlen = 300      
vim.o.lazyredraw = true     
vim.o.ttyfast = true        


-- general: swap and backup and undo file
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

local undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
vim.opt.undofile = true
vim.opt.undodir = undodir


-----------------------------------------------------------------
-- plugins list 
-----------------------------------------------------------------

vim.pack.add({
    -- list of themes
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/folke/tokyonight.nvim" },
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/sainnhe/everforest" },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/EdenEast/nightfox.nvim" },
    { src = "https://github.com/shaunsingh/nord.nvim" },
    -- other plugins
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/obsidian-nvim/obsidian.nvim",     version = "main",  ft = "markdown",                         lazy = true },
    { src = "https://github.com/Saghen/blink.cmp",                version = "1.*",   build = 'cargo +nightly build --release' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false,                            build = ":TSUpdate" }
})


-----------------------------------------------------------------
-- setup 
-----------------------------------------------------------------

-- setup: mini
require("mini.pick").setup()


-- setup: Tree-sitter
require("nvim-treesitter.configs").setup(
    {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bash", "java" },
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        }
    }
)

-- setup: mason
require("mason").setup()

-- setup: blink and LSP
require("blink.cmp").setup({
    completion = {
        menu = {
            auto_show = false,
        }
    },
    fuzzy = { implementation = "lua" }
})

vim.lsp.enable( -- Before enabling LSPs download them with Mason
    {
        "markdown_oxide",
        "lemminx",          -- XML LSP
        "harper_ls",        -- Grammar checker 
    }
)

-- setup: Obsidian 
local DIR_2BRAIN = "/home/esposigg/Documents/projects/2brain"
if not vim.g._obsidian_setup_done then
    vim.g._obsidian_setup_done = true
    require("obsidian").setup({
        legacy_commands = false,
        workspaces = { { name = "2brain", path = DIR_2BRAIN } },
        notes_subdir = "1_inbox",
        templates = {
            folder = "3_templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        attachments = {
            img_folder = "5_images",
            img_text_func = require("obsidian.builtin").img_text_func,
            img_name_func = function()
                return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
            end,
            confirm_img_paste = true,
        },
    })
end


-----------------------------------------------------------------
-- keymap
-----------------------------------------------------------------

-- keymap: general
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>e", ":e .<CR>")
vim.keymap.set("n", "<leader>l", ":e!<CR>", { desc = "Load the file change from memory used with Obsidian" })
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>o", ":update <CR>:source<CR>")
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')
vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")

-- keymap: Obsidian
vim.keymap.set("n", "<leader>oo", ":cd " .. DIR_2BRAIN .. "<CR>")
vim.api.nvim_create_autocmd("User", {
    pattern = "ObsidianNoteEnter",
    callback = function(ev)
        vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", {
            buffer = ev.buf,
            desc = "Follow link",
        })
        vim.keymap.set("n", "<leader>on", ":Obsidian template note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>") -- Convert note to template and remove leading whitespace
        vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")                                     -- Stripe date from title and replace - with space (must have cursor on the title)
        vim.keymap.set("n", "<leader>ok", ":!mv '%:p' " .. DIR_2BRAIN .. "/4_main<CR>:bd<CR>")                        -- move to main folder
        vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>")                                                   -- remove this note
    end,
})

-- keymap: LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { desc = "LSP code actions" })

-- keymap: theme picker
vim.keymap.set("n", "<leader>t", function()
    local colors = vim.fn.getcompletion("", "color")
    vim.ui.select(colors, {
        prompt = "Select colorscheme: ",
    }, function(choice)
        if choice then
            vim.cmd("colorscheme " .. choice)
            vim.cmd(":hi statusline guibg=NONE")
        end
    end)
end, { desc = "Pick colorscheme" })


-----------------------------------------------------------------
-- theme
-----------------------------------------------------------------

-- theme: fix the blink piker when we change theme
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
    end,
})

-- theme: set a base theme
-- vim.cmd("colorscheme catppuccin")
vim.cmd("colorscheme tokyonight-storm")
vim.cmd(":hi statusline guibg=NONE")

