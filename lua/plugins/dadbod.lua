return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
      { 'ellisonleao/dotenv.nvim',              lazy = true },
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

      vim.g.db_ui_auto_execute_table_helpers = 1

      vim.g.db_ui_table_helpers = {
        postgres = {
          List = 'SELECT * FROM {optional_schema}{table} ORDER BY created_at DESC LIMIT 100',
        },
        mysql = {
          List = 'SELECT * FROM {optional_schema}{table} ORDER BY created_at DESC LIMIT 100',
        },
        sqlite = {
          List = 'SELECT * FROM {optional_schema}{table} ORDER BY created_at DESC LIMIT 100',
        },
      }

      vim.g.db_ui_execute_on_save = 0
      -- Remap to :DBUIToggle
      vim.api.nvim_set_keymap('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })
      -- Remap EXECUTE to
      vim.api.nvim_set_keymap('n', '<leader>dj', '<Plug>(DBUI_ExecuteQuery)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>dh', '<Plug>(DBUI_ToggleResultLayout)', { noremap = true, silent = true })

      require('dotenv').setup({
        enable_on_load = true, -- will load your .env file upon loading a buffer
        verbose = false, -- show error notification if .env file is not found and if .env is loaded
      })
    end,
  }
}
