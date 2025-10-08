-- ################################################################################
-- Neovim Configuration
-- ################################################################################
if not vim.g.vscode then
	require("paq")({
		-- Let Paq manage itself.
		"savq/paq-nvim",

		-- Gruvbox: Color Theme
		"ellisonleao/gruvbox.nvim",

		-- Telescope: Fuzzy Find
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",

		-- Treesitter: Highlight
		"nvim-treesitter/nvim-treesitter",

		-- Mini.nvim: independent plugins
		"echasnovski/mini.nvim",

		-- Surround.nvim
		"kylechui/nvim-surround",

		-- Hop.nvim
		"smoka7/hop.nvim",

		-- Harpoon: Quick Find
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2"
		}
	})
	-- telescope
	local telescope = require("telescope")
	telescope.setup()

	-- colorscheme
	local gruvbox = require("gruvbox")
	gruvbox.setup({
		transparent_mode = true
	})
	vim.cmd("colorscheme gruvbox")

	-- statusline
	local statusline = require("mini.statusline")
	statusline.setup({ use_icons = false })

	-- treesitter
	local treesitter = require("nvim-treesitter.configs")
	treesitter.setup({
		auto_install = true,
		ignore_install = {
			"tmux",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		}
	})

	-- mini.nvim
	require("mini.snippets").setup()
	require("mini.completion").setup({
		window = {
			info = { border = "single" },
			signature = { border = "single" },
		},
		lsp_completion = {
			source_func = "omnifunc"
		}
	})
	require("mini.files").setup({
		-- use_icons = false
		content = { prefix = function() end, },
		windows = {
			max_number = 3,
		},

	})
	require("mini.comment").setup()
	require("mini.pairs").setup()
	require("mini.operators").setup()

	-- surround
	require("nvim-surround").setup()

	-- hop
	local hop = require("hop")
	hop.setup({
		case_insensitive = false,
		multi_windows = true,
	})

	-- harpoon
	local harpoon = require("harpoon")
	harpoon:setup()

	-- options
	vim.opt.tabstop = 4
	vim.opt.shiftwidth = 4
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.opt.smartindent = true
	vim.opt.pumheight = 15

	-- keybindings
	_G.ctrl_y_action = function()
		if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected == -1 then
			return "<C-n><C-y>"
		else
			return "<C-y>"
		end
	end

	vim.g.mapleader = " "
	vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")
	vim.keymap.set("n", "<leader>n", MiniFiles.open)
	vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
	vim.keymap.set("n", "<leader>h", function()
		require('telescope.builtin').find_files({ no_ignore = true, hidden = true })
	end)
	vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
	vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
	vim.keymap.set("n", "<C-b>", "<C-^>", { silent = true })
	vim.keymap.set("i", "<C-y>", "v:lua.ctrl_y_action()", { expr = true })

	-- hop
	vim.keymap.set("n", "go", hop.hint_char1)

	-- harpoon
	vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
	vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
	vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
	vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
	vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
	vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- ################################################################################
-- VSCode Neovim Configuration
-- ################################################################################
else
	require("paq")({
		-- Let Paq manage itself.
		"savq/paq-nvim",

		-- Mini.nvim: independent plugins
		"echasnovski/mini.nvim",
	})

	-- mini.nvim
	require("mini.jump").setup()
	require("mini.jump2d").setup()
	require("mini.operators").setup()
	require("mini.surround").setup()

	-- highlight
    vim.api.nvim_set_hl(0, 'MiniJump', { underline = true })
    vim.api.nvim_set_hl(0, 'MiniJump2dSpot', { underline = true, standout = true })
end
