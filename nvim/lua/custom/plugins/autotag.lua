-- Autotag
-- Automatic close and rename html tag

return {
  'windwp/nvim-ts-autotag',
  config = function()
    require('nvim-ts-autotag').setup {}
  end,
}
