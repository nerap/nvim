return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            routes = {
                {
                    filter = { event = "notify", find = "No information available" },
                    opts = { skip = true },
                },
            },
            presets = {
                lsp_doc_border = true,
            },
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        opts = function()
            local logo = [[
                                                      
               ████ ██████           █████      ██
              ███████████             █████ 
              █████████ ███████████████████ ███   ███████████
             █████████  ███    █████████████ █████ ██████████████
            █████████ ██████████ █████████ █████ █████ ████ █████
          ███████████ ███    ███ █████████ █████ █████ ████ █████
         ██████  █████████████████████ ████ █████ █████ ████ ██████
      ]]

            logo = string.rep("\n", 8) .. logo .. "\n\n"

            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                        { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
                        { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
                        { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
                        { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
                    --  {
                    --      action = [[lua require("lazyvim.util").telescope.config_files()()]],
                    --      desc = " Config",
                    --      icon = " ",
                    --      key = "c"
                    --  },
                    --  { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
                    --  { action = "LazyExtras", desc = " Lazy Extras", icon = " ", key = "x" },
                        { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
                        { action = "qa", desc = " Quit", icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return { "⚡ Neovim loaded in " .. ms .. "ms" }
                        -- return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            require("illuminate")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {"branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = {
                        { "fileformat", "filetype" },
                        {
                            require("noice").api.statusline.mode.get,
                            cond = require("noice").api.statusline.mode.has,
                            color = { fg = "#ff9e64" },
                        },
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                extensions = { "fugitive", "quickfix", "fzf", "lazy", "mason", "nvim-dap-ui", "oil", "trouble" },
            })
        end,
    },
}
