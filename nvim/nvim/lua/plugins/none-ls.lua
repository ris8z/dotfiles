return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvimtools/none-ls-extras.nvim" }, --for eslint_d
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua, --for lua

                null_ls.builtins.formatting.prettier, --for js html ecc
                require("none-ls.diagnostics.eslint_d"),

                null_ls.builtins.formatting.black, --for python3

            },
        })

        vim.keymap.set("n", "<leader>b", vim.lsp.buf.format, {})
    end,
}
