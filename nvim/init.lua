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
vim.keymap.set('n', '<C-b>', '<C-^>', { silent = true })
vim.keymap.set('n', '<C-c>', '<cmd>bd<cr>', { silent = true })
vim.keymap.set('n', '<C-C>', '<cmd>bd!<cr>', { silent = true })

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
	vim.keymap.set({'n', 'o', 'x'}, 'go', hop.hint_char1)
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
		local miniclue = require('mini.clue')
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },

				-- Marks
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },

				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },
			},
			clues = {
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
			},
			window = { delay = 200 },
		})
	end)

	later(function()
		add({ source = 'arnamak/stay-centered.nvim' })

		require('stay-centered').setup()
		require('mini.bracketed').setup()
		require('mini.basics').setup({
			options = { basic = false },
			mappings = { 
				basic = false,
				option_toggle_prefix = [[<leader>t]],
				windows = true,
			},
			autocommands = { basic = true },
		})
		require('mini.indentscope').setup({ delay = 0 })

		local function toggle_unnamedplus()
			local current_clip = vim.opt.clipboard:get()

			local found = false
			for _, item in ipairs(current_clip) do
				if item == 'unnamedplus' then
					found = true
					break
				end
			end

			if found then
				vim.opt.clipboard:remove("unnamedplus")
				vim.notify("System Clipboard: OFF)", vim.log.levels.INFO)
			else
				vim.opt.clipboard:append("unnamedplus")
				vim.notify("System Clipboard: ON", vim.log.levels.INFO)
			end
		end
		local toggle_stay_centered = require('stay-centered').toggle

		-- Additional keybinding
		vim.keymap.set('n', '<leader>tz', toggle_stay_centered, { desc = "Toggle 'centered'"})
		vim.keymap.set('n', '<leader>ty', toggle_unnamedplus, { desc = "Toggle 'clipboard'"})
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
		vim.keymap.set('n', '<leader>n', MiniFiles.open, { desc = "Open MiniFiles" })
	end)

	later(function()
		local pick = require('mini.pick')
		pick.setup({ source = { show = pick.default_show } })

		vim.keymap.set("n", "<leader>f", function()
			MiniPick.builtin.cli({ command = {'fd', '-H' , '-t', 'file'} })
		end, { desc = "Find files"})
		vim.keymap.set("n", "<leader>g", function()
			MiniPick.builtin.grep({ tool = 'rg' })
		end, { desc = "Grep"})
		vim.keymap.set("n", "<leader>b", function()
			MiniPick.builtin.buffers()
		end, { desc = "Find buffers"})
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
			}, { desc = "Show diagnostic"})
		end)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename symbol" })
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code action" })
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
		vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition)

		-- Language Server (Uses lspconfig)
		vim.lsp.enable('gopls')
	end)
end
