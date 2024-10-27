return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")


            local offset = 0
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

            vim.keymap.set("n", "<C-h>", function()
                print(offset)
                harpoon:list():select(1 + offset) end)
            vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2 + offset) end)
            vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3 + offset) end)
            vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4 + offset) end)

            vim.keymap.set("n", "<C-1>", function()
                offset = 0
            end)
            vim.keymap.set("n", "<C-2>", function()
                offset = 1
            end)
        end
    }
}
