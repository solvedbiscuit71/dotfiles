-- Surround
-- Surround selections, stylishly

return {
  'kylechui/nvim-surround',
  version = '*', -- Use for stability; omit to use `main` branch for the latest features
  event = 'VeryLazy',
  config = function()
    require('nvim-surround').setup {
      -- Configuration here, or leave empty to use defaults
      keymaps = {
        insert = '<C-s>s',
        insert_line = '<C-s>S',
      },
    }
  end,
}
