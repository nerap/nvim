return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.api.nvim_create_augroup('MyAutoCmdGroup', { clear = true })

      -- Define the autocmd to set local options for 'dbout' filetype
      vim.api.nvim_create_autocmd('FileType', {
        group = 'MyAutoCmdGroup',
        pattern = 'dbout',
        callback = function()
          vim.opt_local.foldenable = false
        end
      })
      vim.g.db_ui_use_nerd_fonts = 1

      -- Remap to :DBUIToggle
      vim.api.nvim_set_keymap('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
    end,
  }
}
