vim.loader.enable()

-- Basics
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.g.mapleader = " "

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.opt.signcolumn = "yes"

-- Quality of life
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.winborder = "rounded"
vim.opt.conceallevel = 1
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.o.updatetime = 250      -- Rende l'interfaccia più reattiva (default 4000)
vim.o.timeoutlen = 300      -- Rende le combo di tasti (leader key) più scattanti
vim.o.lazyredraw = true     -- Non ridisegna lo schermo durante le macro (più veloce)
vim.o.ttyfast = true        -- Dice a nvim che hai un terminale veloce

-- Swap and Backup and Undofile
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

-- List of installed Plugins
vim.pack.add({
    { src = "https://github.com/catppuccin/nvim" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/obsidian-nvim/obsidian.nvim",     version = "main",  ft = "markdown",                         lazy = true },
    { src = "https://github.com/Saghen/blink.cmp",                version = "1.*",   build = 'cargo +nightly build --release' },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false,                            build = ":TSUpdate" }
})

-- Require Plugins and setting plugins
require("mini.pick").setup()
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
require("mason").setup()
require("blink.cmp").setup({
    completion = {
        menu = {
            auto_show = false,
        }
    },
    fuzzy = { implementation = "lua" }
})

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


-- LSPs enable and config
vim.lsp.enable(
    {
        "markdown_oxide",
        "lemminx",
    }
)

-----------------------------------------------------------------

-- Keymaps

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>e", ":e .<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")
vim.keymap.set("n", "<leader>o", ":update <CR>:source<CR>")

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>g", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")

vim.keymap.set("n", "<leader>oo", ":cd " .. DIR_2BRAIN .. "<CR>")
vim.api.nvim_create_autocmd("User", {
    pattern = "ObsidianNoteEnter",
    callback = function(ev)
        vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", {
            buffer = ev.buf,
            desc = "Follow link",
        })
        vim.keymap.set("n", "<leader>on", ":Obsidian template note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>") -- convert note to template and remove leading white space
        vim.keymap.set("n", "<leader>of", ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>")                                     -- stripe date from title and replace - with space (must have cursor on the title)
        vim.keymap.set("n", "<leader>ok", ":!mv '%:p' " .. DIR_2BRAIN .. "/4_main<CR>:bd<CR>")                        -- move to main folder
        vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<CR>:bd<CR>")                                                   -- remove this note
    end,
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

-- Vim cmd

vim.cmd("colorscheme catppuccin")
vim.cmd(":hi statusline guibg=NONE")

-- small function to open the selected text on firefox
function OpenSelectionInFirefox()
    local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
    local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
    local lines = vim.fn.getline(start_line, end_line)

    if #lines == 0 then return end
    lines[#lines] = string.sub(lines[#lines], 1, end_col)
    lines[1] = string.sub(lines[1], start_col)

    local selection = table.concat(lines, " ")
    selection = selection:gsub("^%s*(.-)%s*$", "%1")
    if selection == "" then return end

    local url = selection
    if not selection:match("^https?://") then
        url = "https://www.google.com/search?q=" .. vim.fn.escape(selection, " ")
    end

    vim.fn.jobstart({ "firefox", url }, { detach = true })
end

vim.api.nvim_set_keymap('v', '<leader>s', [[:lua OpenSelectionInFirefox()<CR>]], { noremap = true, silent = true })
