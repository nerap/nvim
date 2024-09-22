return {
  {
    "nerap/gitmoji.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {},
    config = function()
      require("gitmoji").setup({})
    end
  }
}
