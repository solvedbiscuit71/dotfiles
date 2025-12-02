-- Install mini.nvim
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'--branch', 'stable',
		'https://github.com/nvim-mini/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set options
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.pumheight = 15
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.g.mapleader = ' '

-- Setup mini.deps
require('mini.deps').setup({
	path = {
		package = path_package
	}
})
MiniDeps.add({ name = 'mini.nvim', checkout = 'stable' })

-- Add plugins
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
	require('mini.comment').setup()
	require('mini.pairs').setup()
	require('mini.operators').setup()

	-- To make mini.surround behavior like tpope/vim-surround
    require('mini.surround').setup({
		mappings = {
			add = 'ys',
			delete = 'ds',
			find = '',
			find_left = '',
			highlight = '',
			replace = 'cs',
			update_n_lines = '',
			suffix_last = '',
			suffix_next = '',
		},
		search_method = 'cover_or_next',
    })
	vim.keymap.del('x', 'ys')
	vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
	vim.keymap.set('n', 'yss', 'ys_', { remap = true })
end)

later(function()
	add({ source = 'smoka7/hop.nvim' })
	local hop = require('hop')
	hop.setup({
		case_insensitive = false,
		multi_windows = true,
	})
	vim.keymap.set({'n', 'o', 'x'}, 'm', hop.hint_char1, { desc = "Move curosr", remap = false })
	vim.keymap.set('n', '<leader>m', 'm', { desc = "Set mark" })
end)

later(function()
	require('mini.basics').setup({
		options = { basic = false },
		mappings = { 
			basic = true,
			option_toggle_prefix = '<leader>t',
			windows = false,
		},
		autocommands = { basic = false },
	})
end)