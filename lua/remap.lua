-- Leader
vim.g.mapleader = " "

-- Move lines selected up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- ZZ remap
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- ZZ remap for search
vim.keymap.set("n", "<C-I>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-O>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Void register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Multi cursor issue
vim.keymap.set("i", "<C-c>", "<Esc>")

--- Move lines
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Select all
vim.keymap.set("n", "==", "gg<S-v>G")

-- close buffer
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Close Buffer" })

-- Make Y behave like C or D
vim.keymap.set("n", "Y", "y$")

-- Close buffer without closing split
vim.keymap.set("n", "<leader>w", "<cmd>bp|bd #<CR>", { desc = "Close Buffer; Retain Split" })

-- Resize with arrows
vim.keymap.set("n", "<C-S-Down>", ":resize +2<CR>", { desc = "Resize Horizontal Split Down" })
vim.keymap.set("n", "<C-S-Up>", ":resize -2<CR>", { desc = "Resize Horizontal Split Up" })
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -2<CR>", { desc = "Resize Vertical Split Down" })
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +2<CR>", { desc = "Resize Vertical Split Up" })

-- Substitute word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Split
vim.keymap.set("n", "<leader>vs", "<cmd>:vsplit<CR><C-w>l")
vim.keymap.set("n", "<leader>hs", "<cmd>:split<CR><C-w>j")

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
