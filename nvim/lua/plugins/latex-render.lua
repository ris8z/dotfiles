return {
    "jbyuki/nabla.nvim",
    config = function()
        local virt_enable = false

        vim.keymap.set(
            "n", -- Modalità normale
            "<leader>p", -- Tasto di mappatura
            function()
                require("nabla").popup()
            end,                     -- Funzione chiamata
            { noremap = true, silent = true } -- Opzioni
        )
        vim.keymap.set(
            "n", -- Modalità normale
            "<leader>P", -- Tasto di mappatura (SHIFT + <leader>p)
            function()
                if virt_enabled then
                    -- Disabilita il rendering virtuale
                    require("nabla").disable_virt()
                    virt_enabled = false
                    print("Nabla virtual rendering disabled")
                else
                    -- Abilita il rendering virtuale
                    require("nabla").enable_virt({
                        autogen = true, -- Auto-regenerate ASCII art quando esci da insert mode
                        silent = true, -- Nessun messaggio di errore
                    })
                    virt_enabled = true
                    print("Nabla virtual rendering enabled")
                end
            end,
            { noremap = true, silent = true } -- Opzioni
        )
    end,
}
