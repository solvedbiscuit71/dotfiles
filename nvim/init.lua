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
	add({ source = 'smoka7/hop.nvim' })
	local hop = require('hop')
	hop.setup({
		case_insensitive = false,
		multi_windows = true,
	})
	require('mini.comment').setup()
	require('mini.pairs').setup()
	require('mini.operators').setup()
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
	vim.keymap.set({'n', 'o', 'x'}, 'm', hop.hint_char1, { desc = "Move curosr", remap = false })
	vim.keymap.set('n', '<leader>m', 'm', { desc = "Set mark" })
	vim.keymap.set('o', '%', '<cmd>normal!ggVG<cr>', { silent = true, remap = false })
end)

later(function()
end)

if vim.g.vscode then
	local vscode = require("vscode")
	later(function()
		-- Enable basic mapping only
		-- `gy` and `gp` for system clipboard
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
else
	now(function()
		add({ source = 'ellisonleao/gruvbox.nvim' })

		require('gruvbox').setup({
			transparent_mode = true
		})
		require('mini.tabline').setup({
			use_icons = false
		})
		require('mini.statusline').setup({
			use_icons = false
		})
		require('mini.files').setup({
			use_icons = false,
			content = { prefix = function() end, },
			windows = {
				max_number = 3,
			},
			options = {
				use_as_default_explorer = true,
			},
		})

		vim.o.hlsearch = false
		vim.o.termguicolors = true
		vim.cmd('colorscheme gruvbox')

		vim.keymap.set('n', '<C-b>', '<C-^>', { silent = true })
		vim.keymap.set('n', '<C-c>', '<cmd>bd<cr>', { silent = true })
		vim.keymap.set('n', '<C-C>', '<cmd>bd!<cr>', { silent = true })
		vim.keymap.set('n', '<leader>n', MiniFiles.open, { desc = "Open MiniFiles" })
	end)

	later(function()
		require('mini.bracketed').setup()
		require('mini.basics').setup({
			options = { basic = false },
			mappings = { 
				basic = true,
				option_toggle_prefix = '<leader>t',
				windows = true,
			},
			autocommands = { basic = true },
		})
		local miniclue = require('mini.clue')
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },

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
			window = { delay = 400 },
		})
	end)

	-- later(function()
	-- 	add({ source = 'arnamak/stay-centered.nvim' })
	--
	-- 	local stay_centered = require('stay-centered')
	-- 	stay_centered.setup()
	--
	-- 	vim.keymap.set('n', '<leader>tz', stay_centered.toggle, { desc = "Toggle 'stay_centered'"})
	-- end)

	-- later(function()
	-- 	local function toggle_unnamedplus()
	-- 		local current_clip = vim.opt.clipboard:get()
	--
	-- 		local found = false
	-- 		for _, item in ipairs(current_clip) do
	-- 			if item == 'unnamedplus' then
	-- 				found = true
	-- 				break
	-- 			end
	-- 		end
	--
	-- 		if found then
	-- 			vim.opt.clipboard:remove("unnamedplus")
	-- 			vim.notify("System Clipboard: OFF)", vim.log.levels.INFO)
	-- 		else
	-- 			vim.opt.clipboard:append("unnamedplus")
	-- 			vim.notify("System Clipboard: ON", vim.log.levels.INFO)
	-- 		end
	-- 	end
	-- 	vim.keymap.set('n', '<leader>ty', toggle_unnamedplus, { desc = "Toggle 'clipboard'"})
	-- end)

	later(function()
		add({
			source = 'nvim-treesitter/nvim-treesitter',
			checkout = 'master',
			monitor = 'main',
			hooks = { post_checkout = function()
				vim.cmd('TSUpdate')
			end },
		})

		require('nvim-treesitter.configs').setup({
			ensure_installed = { "markdown", "markdown_inline" },
			markdown = {
				enable = true,
			},
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

	later(function()
		add({ source = 'tadmccorkle/markdown.nvim' })

		-- concealed text is completely hidden unless
		-- it has a custom replacement character defined.
		vim.o.conceallevel = 2
		vim.o.concealcursor = ""
		vim.o.foldmethod = "marker"

		require('markdown').setup({
			mappings = {
				inline_surround_toggle = "ys",
				inline_surround_toggle_line = "yss",
				inline_surround_delete = "ds",
				inline_surround_change = "cs",
				link_add = "ga",
				link_follow = "gf",
				go_curr_heading = false,
				go_parent_heading = false,
				go_next_heading = "]s",
				go_prev_heading = "[s",
			},
			on_attach = function(bufnr)
				local map = vim.keymap.set
				local opts = { buffer = bufnr }
				map('n', 'go', '<Cmd>MDListItemBelow<CR>', opts)
				map('n', 'gO', '<Cmd>MDListItemAbove<CR>', opts)
			end,
		})

		-- :New command creates a new markdown file from existing TEMPLATE.md
		-- file in the current working directory
		vim.api.nvim_create_user_command(
			'New',
			function(opts)
				local fname = opts.fargs[1] .. '.md'
				local exist = vim.system({"test", "-f", fname}, {text=true}):wait()
				if exist.code == 0 then
					-- if file exists then open
					vim.cmd("edit " .. fname)
				else
					-- otherwise, create the file and then open
					local status = vim.system({"cp", "TEMPLATE.md", fname}, {text=true}):wait()
					if status.code == 0 then
						-- if success then open
						vim.cmd("edit " .. fname)
					else
						-- otherwise, echo
						vim.cmd('echo "Failed"')
					end
				end

			end,
			{ nargs = 1 }
		)
	end)
end
