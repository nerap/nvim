return {
  {
    "gitmoji",
    dir = "~/personal/gitmoji",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {},
    config = function()
      require("gitmoji").setup({})
    end
  }
}
