return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            integrations = {
                cmp = true,
                nvimtree = true,
                treesitter = true,
            }
        })
        vim.cmd.colorscheme("catppuccin-mocha")
        --this line is for transparent background
        --vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
    end,
}
