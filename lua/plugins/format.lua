return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    config = function()
      local conform = require("conform")

      conform.setup({
        notify_on_error = false,
        format_on_save = function(bufnr)
          local lsp_format_opt = "never"
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          svelte = { { "biome", "biome-organize-imports" } },
          json = { { "biome", "biome-organize-imports" } },
          javascript = { "biome", "biome-organize-imports" },
          javascriptreact = { "biome", "biome-organize-imports" },
          typescript = { "biome", "biome-organize-imports" },
          typescriptreact = { "biome", "biome-organize-imports" },
          graphql = { { "biome", "biome-organize-imports" } },
          java = { "google-java-format" },
          markdown = { { "biome", "biome-organize-imports" } },
          erb = { "htmlbeautifier" },
          html = { "htmlbeautifier" },
          bash = { "beautysh" },
          proto = { "buf" },
          rust = { "rustfmt" },
          yaml = { "yamlfix" },
          toml = { "taplo" },
          css = { { "prettierd", "prettier" } },
          scss = { { "prettierd", "prettier" } },
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
          lsp_fallback = true,
          async = false,
          lsp_format = "never",
          timeout_ms = 1000,
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
