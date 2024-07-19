function ColorMyPencils(color)
  color = color or "tokyonight"
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "night",                -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        transparent = true,             -- Enable this to disable setting the background color
        terminal_colors = true,         -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark",           -- style for sidebars, see below
          floats = "dark",             -- style for floating windows
        },
      })
      vim.cmd("colorscheme tokyonight")
    end
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({
        compile = false,          -- enable compiling the colorscheme
        undercurl = true,         -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,           -- do not set background color
        dimInactive = false,           -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,         -- define vim.g.terminal_color_{0,17}
        colors = {                     -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function()         -- add/modify highlights
          return {}
        end,
        theme = "wave",            -- Load "wave" theme when 'background' option is not set
        background = {             -- map the value of 'background' option to a theme
          dark = "wave",           -- try "dragon" !
          light = "lotus"
        }
      })
      -- vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
      })
      -- vim.cmd("colorscheme rose-pine")
      ColorMyPencils()
    end
  },
}
