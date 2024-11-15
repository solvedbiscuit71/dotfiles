-- Emmet
-- Expand emmet abbreviation
-- Check out the tutorial at https://raw.githubusercontent.com/mattn/emmet-vim/master/TUTORIAL

return {
  'mattn/emmet-vim',
  init = function()
    vim.g.user_emmet_leader_key = '<C-j>'
  end,
}
