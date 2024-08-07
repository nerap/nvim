return {
  {
    "harpoon",
    dir = "~/personal/harpoon",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)
    end
  },
  {
    "gitmoji",
    dir = "~/personal/gitmoji",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {},
    config = function()
      require("gitmoji").setup({})
    end
  }
  --  {
  --    "vim-apm",
  --    dir = "~/personal/vim-apm",
  --    config = function()
  --      local apm = require("vim-apm")
  --
  --      apm:setup({})
  --      vim.keymap.set("n", "<leader>apm", function() apm:toggle_monitor() end)
  --    end
  --  },
}
