return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
    },

    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities())

      require("fidget").setup({})
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tailwindcss",
          "ts_ls",
          "eslint",
          "jsonls",
          "tflint",
          "dockerls",
          "terraformls",
          "yamlls",
          "bashls",
          "pylsp",
          "marksman",
        },
        handlers = {
          function(server_name) -- default handler (optional)
            if server_name ~= "gopls" and server_name ~= "rust_analyzer" then
              require("lspconfig")[server_name].setup {
                capabilities = capabilities
              }
            end
          end,

          ["ts_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.tsserver.setup({
              capabilities = capabilities,
            })
            lspconfig.eslint.setup({
              on_attach = function(_, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
              capabilities = capabilities
            })
            require("lspconfig").eslint.setup({})
          end,
          ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                  }
                }
              }
            }
          end,
        }
      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
          { name = "vim-dadbod-completion" },
        }, {
          { name = 'buffer' },
        }),
      })

      vim.diagnostic.config({
        -- update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },
  {
    "mrcjkb/rustaceanvim",
    version = '^5',
    lazy = false, -- This plugin is already lazy
    --   config = function()
    --     vim.g.rustaceanvim = {
    --       -- Plugin configuration
    --       tools = {
    --         autoSetHints = true,
    --         inlay_hints = {
    --           enable = true,
    --           show_parameter_hints = true,
    --           parameter_hints_prefix = "in: ", -- "<- "
    --           other_hints_prefix = "out: "     -- "=> "
    --         }
    --       },
    --       -- LSP configuration
    --       --
    --       -- REFERENCE:
    --       -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    --       -- https://rust-analyzer.github.io/manual.html#configuration
    --       -- https://rust-analyzer.github.io/manual.html#features
    --       --
    --       -- NOTE: The configuration format is `rust-analyzer.<section>.<property>`.
    --       --       <section> should be an object.
    --       --       <property> should be a primitive.
    --       server = {
    --         on_attach = function(client, bufnr)
    --           -- require("lsp-inlayhints").setup({
    --           --   inlay_hints = { type_hints = { prefix = "=> " } }
    --           -- })
    --           vim.lsp.inlay_hint.enable(bufnr)
    --
    --           -- require("lsp-inlayhints").on_attach(client, bufnr)
    --           require("illuminate").on_attach(client)
    --
    --           local bufopts = {
    --             noremap = true,
    --             silent = true,
    --             buffer = bufnr
    --           }
    --           vim.keymap.set('n', '<leader><leader>rr',
    --             "<Cmd>RustLsp runnables<CR>", bufopts)
    --           vim.keymap.set('n', 'K',
    --             "<Cmd>RustLsp hover actions<CR>", bufopts)
    --         end,
    --         settings = {
    --           -- rust-analyzer language server configuration
    --           ['rust-analyzer'] = {
    --             assist = {
    --               importEnforceGranularity = true,
    --               importPrefix = "create"
    --             },
    --             cargo = { allFeatures = true },
    --             checkOnSave = {
    --               -- default: `cargo check`
    --               command = "clippy",
    --               allFeatures = true
    --             },
    --             inlayHints = {
    --               lifetimeElisionHints = {
    --                 enable = true,
    --                 useParameterNames = true
    --               }
    --             }
    --           }
    --         }
    --       }
    --     }
    --   end
  }
}
