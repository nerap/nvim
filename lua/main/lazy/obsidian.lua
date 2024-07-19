return {
  {
    "epwalsh/obsidian.nvim",
    config = function()
      require("obsidian").setup({
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = "markdown",
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
          "BufReadPre " .. vim.fn.expand "~" .. "/vaults/**/**.md"
        },
        workspaces = {
          {
            name = "nerap",
            path = "~/vaults/nerap",
          },
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        picker = {
          name = "telescope.nvim",
        },
        follow_url_func = function(url)
          vim.fn.jobstart({ "open", url }) -- Mac OS
        end,
      })
      vim.opt_local.conceallevel = 2
    end,
  } }
