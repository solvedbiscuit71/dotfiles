-- hop.nvim
-- hop allows you to jump anywhere in a document with a few keystrokes as possible.

return {
  'smoka7/hop.nvim',
  version = '*',
  config = function()
    require('hop').setup {
      multi_windows = true,
    }
    vim.keymap.set({ 'n', 'x', 'o' }, 'go', '<cmd>HopChar1<CR>', { desc = '[G]ot[o] character' })
  end,
}
