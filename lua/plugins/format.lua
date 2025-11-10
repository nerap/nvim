return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
      local conform = require("conform")

      conform.setup({
        notify_on_error = false,
        format_on_save = function(bufnr)
          local lsp_format_opt = "fallback"
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          svelte = { "biome" },
          json = { "biome" },
          javascript = { "biome" },
          javascriptreact = { "biome"},
          typescript = { "biome"},
          typescriptreact = { "biome"},
          graphql = { { "biome"} },
          java = { "google-java-format" },
          markdown = { { "biome"} },
          erb = { "htmlbeautifier" },
          html = { "htmlbeautifier" },
          bash = { "beautysh" },
          proto = { "buf" },
          rust = { "rustfmt" },
          yaml = { "yamlfix" },
          toml = { "taplo" },
          css = { { "biome" } },
          scss = { { "biome"} },
          sh = { { "shellcheck" } },
          sql = { "sqlformat" },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end, { desc = "Format file or range (in visual mode)" })

      vim.keymap.set("n", "<leader>f", function()
        conform.format({
          async = true,
          lsp_format = "never",
        })
      end, { desc = "Format file" })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-ts-autotag").setup({})
    end,
    lazy = true,
    event = "VeryLazy",
  },
}
