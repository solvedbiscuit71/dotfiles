-- ################################################################################
-- Neovim Configuration
-- ################################################################################
if not vim.g.vscode then
	require("paq")({
		-- Let Paq manage itself.
		"savq/paq-nvim",

		-- Telescope: Fuzzy Find
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",

		-- Treesitter: Highlight
		"nvim-treesitter/nvim-treesitter",

		-- Mini.nvim: independent plugins
		"echasnovski/mini.nvim",
	})
	-- telescope
	local telescope = require("telescope")
	telescope.setup()

	vim.cmd.colorscheme "retrobox"

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
	require("mini.icons").setup()
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
	require("mini.jump").setup()
	require("mini.jump2d").setup()
	require("mini.operators").setup()
	require("mini.surround").setup()

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
	vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>")
	vim.keymap.set("n", "<C-b>", "<C-^>", { silent = true })
	vim.keymap.set("i", "<C-y>", "v:lua.ctrl_y_action()", { expr = true })

-- ################################################################################
-- VSCode Neovim Configuration
-- ################################################################################
else
	require("paq")({
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
