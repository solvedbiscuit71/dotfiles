-- Neovim Options

vim.opt.bufhidden = 'hide'
vim.opt.clipboard = ''
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.fileencoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.pumheight = 10
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.shell = '/opt/homebrew/bin/bash'
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.completeopt='menu,menuone,preview'
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.updatetime = 500
vim.opt.wrap = false
vim.g.mapleader = ' '
-- Plugin Installation

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'gbprod/substitute.nvim'
	use 'numToStr/Comment.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'shaunsingh/nord.nvim'
	use 'windwp/nvim-autopairs'

	use { 'kylechui/nvim-surround', tag = '*', }
	use { 'phaazon/hop.nvim', branch = 'v2' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = {{'nvim-lua/plenary.nvim'}}}

	if packer_bootstrap then
		require('packer').sync()
	end
end)
-- Plugin Configuration

require('nvim-autopairs').setup{}
require('Comment').setup{}
require('nvim-surround').setup{}
require('hop').setup{}

require('nvim-treesitter.configs').setup {
	ensure_installed = { 'bash', 'c', 'lua', 'markdown', 'vim', 'vimdoc', 'query' },
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	indent = {
		enable = true
	},
}

require('lualine').setup {
	options = {
		icons_enabled = false,
		component_separators = '',
		section_separators = '',
		theme = 'nord',
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch'},
		lualine_c = {{'filename', path=1}},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {{'filename', path=1}},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}

require('substitute').setup {
	yank_substituted_text = false,
	highlight_substituted_text = {
		enabled = false,
		timer = 200,
	},
}

require('telescope').setup {
	defaults = {
		layout_strategy = 'vertical',
		layout_config = { height = 0.5, width = 0.5 },
	},
	pickers = {
		find_files = {
			follow = true,
			hidden = true,
		},
	},
}
-- Configuration

vim.api.nvim_command('colorscheme nord')
vim.api.nvim_command('hi Normal guibg=NONE ctermbg=NONE')

vim.api.nvim_create_autocmd({'BufWinLeave'}, {
  pattern = {'*.*'},
  desc = 'save view (folds), when closing file',
  command = 'mkview',
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
  pattern = {'*.*'},
  desc = 'load view (folds), when opening file',
  command = 'silent! loadview'
})

vim.keymap.set('n', '<leader>n', ':Ex<CR>')
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>s', require('telescope.builtin').live_grep)

vim.keymap.set({'n','x','o'}, 'go', ':HopChar1<CR>')
vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
vim.keymap.set('n', 'gss', require('substitute').line, { noremap = true })
vim.keymap.set('n', 'gS', require('substitute').eol, { noremap = true })
vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
vim.keymap.set('n', 'gx', require('substitute.exchange').operator, { noremap = true })
vim.keymap.set('x', 'gx', require('substitute.exchange').visual, { noremap = true })
vim.keymap.set('n', 'gxx', require('substitute.exchange').line, { noremap = true })
vim.keymap.set('n', 'gr', require('substitute.range').operator, { noremap = true })
vim.keymap.set('x', 'gr', require('substitute.range').visual, { noremap = true })

vim.keymap.set('n', 'gh', ':set hlsearch!<CR>')
vim.keymap.set({'n','x','o'}, 'ga', ':<C-u>normal! ggVG<CR>')
vim.keymap.set({'n','x'}, 'gy', '"+y')

vim.keymap.set('n', '<C-b>', '<C-^>')

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
