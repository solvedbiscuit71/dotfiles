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

-- Install lspconfig
local lspconfig_path = vim.fn.stdpath('config') .. '/pack/nvim/start/nvim-lspconfig'
if not vim.loop.fs_stat(lspconfig_path) then
	vim.cmd('echo "Installing `lspconfig`" | redraw')
	local clone_cmd = {
		'git', 'clone',
		'https://github.com/neovim/nvim-lspconfig', lspconfig_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('echo "Installed `lspconfig`" | redraw')
end

-- Set options
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.pumheight = 15
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.g.mapleader = ' '
vim.keymap.set('n', '<C-b>', '<C-^>', { silent = true })
vim.keymap.set('n', '<C-c>', '<cmd>bd<cr>', { silent = true })
vim.keymap.set('n', '<C-C>', '<cmd>bd!<cr>', { silent = true })
vim.keymap.set({'n', 'v'}, '<C-y>', '"+y', { silent = true })

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
	vim.keymap.set('n', 'go', hop.hint_char1)
end)

if not vim.g.vscode then
	now(function()
		add({ source = 'ellisonleao/gruvbox.nvim' })

		local gruvbox = require('gruvbox')
		gruvbox.setup({
			transparent_mode = true
		})
		vim.o.termguicolors = true
		vim.cmd('colorscheme gruvbox')
	end)

	now(function()
		require('mini.tabline').setup({
			use_icons = false
		})
		require('mini.statusline').setup({
			use_icons = false
		})
	end)

	later(function()
		-- Custom keybinding (imported from mini.basics and mini.bracketed)
		-- \c and \C 	toggle cursorline and cursorcolumn
		-- \d 			toggle diagnostic
		-- \h 			toggle highlight
		-- \r 			toggle relativenumber
		-- \w 			toggle wrap
		-- \z 			toggle stay-centered
		-- [b ]b		navigate buffer
		-- [d ]d		navigate diagnostic
		add({ source = 'arnamak/stay-centered.nvim' })

		require('stay-centered').setup()
		require('mini.bracketed').setup()
		require('mini.basics').setup({
			options = { basic = false },
			mappings = { basic = false, windows = true },
			autocommands = { basic = true },
		})
		require('mini.indentscope').setup({
			delay = 50,
		})

		vim.keymap.set({ 'n', 'v' }, '\\z', require('stay-centered').toggle)
	end)

	later(function()
		add({
			source = 'nvim-treesitter/nvim-treesitter',
			checkout = 'master',
			monitor = 'main',
			hooks = { post_checkout = function()
				vim.cmd('TSUpdate')
			end },
		})

		local treesitter = require('nvim-treesitter.configs')
		treesitter.setup({
			auto_install = true,
			ignore_install = {
				'tmux',
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			}
		})
	end)

	later(function()
		require('mini.files').setup({
			use_icons = false,
			content = { prefix = function() end, },
			windows = {
				max_number = 3,
			},
		})
		vim.keymap.set('n', '<leader>n', MiniFiles.open)
	end)

	later(function()
		require('mini.pick').setup()

		vim.keymap.set("n", "<leader>f", function()
			MiniPick.builtin.cli({ command = {'fd', '-H' , '-t', 'file'} })
		end)
		vim.keymap.set("n", "<leader>g", function()
			MiniPick.builtin.grep({ tool = 'rg' })
		end)
		vim.keymap.set("n", "<leader>b", function()
			MiniPick.builtin.buffers()
		end)
	end)

	later(function()
		require('mini.snippets').setup()
		require('mini.completion').setup({
			delay = { completion = 100, info = 100, signature = 50 },
			window = {
				info = { height = 20, width = 80,  border = 'single' },
				signature = { height = 20, width = 80, border = 'single' },
			},
		})
		_G.ctrl_y_action = function()
			if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected == -1 then
				return '<C-n><C-y>'
			else
				return '<C-y>'
			end
		end
		vim.keymap.set('i', '<C-y>', 'v:lua.ctrl_y_action()', { expr = true })
	end)

	-- Setup LSP
	later(function()
		-- disable vim.lsp.buf.signature_help() because mini.completion has auto_signature
		vim.keymap.del('i', '<C-s>')
		vim.keymap.set('n', 'K', function()
			vim.lsp.buf.hover({
				border = 'single',
				title = ' Documentation ',
				title_pos = 'left',
			})
		end)
		vim.keymap.set('n', '<C-w>d', function()
			vim.diagnostic.open_float({
				scope = 'line',
				border = 'single',
			})
		end)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
		vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition)

		-- Language Server (Uses lspconfig)
		vim.lsp.enable('gopls')
	end)
end
