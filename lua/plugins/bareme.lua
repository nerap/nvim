-- bareme.nvim - Git worktree and tmux session management
return {
  -- Use local development path instead of GitHub
  dir = "/Users/nerap/personal/bareme.nvim.git/main",

  dependencies = {
    "nvim-telescope/telescope.nvim",
  },

  config = function()
    require("bareme").setup({
      -- Path to your tmux-sessionizer script
      tmux_sessionizer = vim.fn.expand("~/.local/scripts/tmux-sessionizer"),

      -- Automatically switch tmux session after creating/switching worktree
      auto_switch_tmux = true,

      -- Automatically kill tmux session when deleting worktree
      auto_kill_session = true,

      -- Confirmation prompts
      confirm_delete = true,

      -- Telescope picker options
      telescope = {
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.8,
          height = 0.8,
          preview_width = 0.6,
        },
      },
    })

    -- Keybindings
    -- Ctrl-B: Quick switch between worktrees (Telescope picker)
    vim.keymap.set("n", "<C-b>", "<cmd>WorktreeSwitch<cr>", { desc = "Switch worktree" })

    -- Leader-based worktree commands
    vim.keymap.set("n", "<leader>ww", "<cmd>WorktreeSwitch<cr>", { desc = "[W]orktree: S[w]itch" })
    vim.keymap.set("n", "<leader>wa", "<cmd>WorktreeCreate<cr>", { desc = "[W]orktree: [A]dd/Create" })
    vim.keymap.set("n", "<leader>wd", "<cmd>WorktreeDelete<cr>", { desc = "[W]orktree: [D]elete" })
    vim.keymap.set("n", "<leader>wl", "<cmd>WorktreeList<cr>", { desc = "[W]orktree: [L]ist" })
    vim.keymap.set("n", "<leader>wc", "<cmd>WorktreeCleanup<cr>", { desc = "[W]orktree: [C]leanup orphaned" })
    vim.keymap.set("n", "<leader>wp", "<cmd>WorktreePrune<cr>", { desc = "[W]orktree: [P]rune" })

    -- Note: <C-f> in remap.lua calls tmux-sessionizer for switching between ALL projects
    -- Note: <C-b> calls bareme for switching between worktrees within the CURRENT repo
  end,
}
