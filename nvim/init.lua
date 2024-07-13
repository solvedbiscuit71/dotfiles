if vim.g.vscode then
    -- VSCode only
    vim.opt.hlsearch = false

    require('packer').startup(function(use)
        use { 'gbprod/substitute.nvim' }
        use { 'kylechui/nvim-surround', tag = '*', }
        use { 'numToStr/Comment.nvim' }
        use { 'phaazon/hop.nvim', branch = 'v2' }
        use { 'windwp/nvim-autopairs' }

        use { 'wbthomason/packer.nvim' }
    end)

    require('Comment').setup{}
    require('nvim-autopairs').setup{}
    require('nvim-surround').setup{}
    require('hop').setup{}
    require('substitute').setup {
        yank_substituted_text = false,
        highlight_substituted_text = {
            enabled = false,
        },
    }
else
    -- Neovim only
    vim.g.mapleader = ' '
    vim.g.python3_host_prog = '~/.pyenv/shims/python3'
    vim.opt.bufhidden = 'hide'
    vim.opt.clipboard = ''
    vim.opt.complete='.,w,b,u,t,i,kspell'
    vim.opt.completeopt='menu,preview'
    vim.opt.cursorcolumn = false
    vim.opt.cursorline = false
    vim.opt.expandtab = true
    vim.opt.fileencoding = 'utf-8'
    vim.opt.hlsearch = false
    vim.opt.list = true
    vim.opt.mouse = 'a'
    vim.opt.number = true
    vim.opt.pumheight = 10
    vim.opt.relativenumber = true
    vim.opt.scrolloff = 5
    vim.opt.shell = '/opt/homebrew/bin/bash'
    vim.opt.shiftwidth = 4
    vim.opt.signcolumn = 'yes'
    vim.opt.smartindent = true
    vim.opt.swapfile = false
    vim.opt.tabstop = 4
    vim.opt.termguicolors = true
    vim.opt.timeoutlen = 500
    vim.opt.undofile = true
    vim.opt.updatetime = 500
    vim.opt.wrap = false

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
        use { 'catppuccin/nvim', as = 'catppuccin' }
        use { 'gbprod/substitute.nvim' }
        use { 'kylechui/nvim-surround', tag = '*', }
        use { 'numToStr/Comment.nvim' }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'phaazon/hop.nvim', branch = 'v2' }
        use { 'wbthomason/packer.nvim' }
        use { 'windwp/nvim-autopairs' }

        if packer_bootstrap then
            require('packer').sync()
        end
    end)

    require('catppuccin').setup({
        transparent_background = true,
        styles = {
            comments = { 'italic' },
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = { 'italic' },
            variables = {},
            numbers = {},
            booleans = { 'italic' },
            properties = {},
            types = {},
            operators = {},
        },
        integrations = {
            hop = true,
        }
    })

    require('lualine').setup {
        options = {
            icons_enabled = false,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            theme = 'catppuccin',
            disabled_filetypes = {
                statusline = {'nnn'},
            },
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {'filename'},
            lualine_x = {'encoding'},
            lualine_y = {'filetype'},
            lualine_z = {'progress'},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'progress'},
            lualine_y = {},
            lualine_z = {},
        },
    }

    require('Comment').setup{}
    require('nvim-autopairs').setup{}
    require('nvim-surround').setup{}
    require('hop').setup{}
    require('substitute').setup {
        yank_substituted_text = false,
        highlight_substituted_text = {
            enabled = false,
        },
    }

    vim.api.nvim_command('colorscheme catppuccin')

    vim.keymap.set('n', '<leader>n', ':Ex<CR>')
    vim.keymap.set('n', '<C-b>', '<C-^>')
end

-- Common
vim.keymap.set('n', 'gs', require('substitute').operator, { noremap = true })
vim.keymap.set('n', 'gss', require('substitute').line, { noremap = true })
vim.keymap.set('n', 'gS', require('substitute').eol, { noremap = true })
vim.keymap.set('x', 'gs', require('substitute').visual, { noremap = true })
vim.keymap.set('n', 'gx', require('substitute.exchange').operator, { noremap = true })
vim.keymap.set('x', 'gx', require('substitute.exchange').visual, { noremap = true })
vim.keymap.set('n', 'gxx', require('substitute.exchange').line, { noremap = true })
vim.keymap.set('n', 'gh', ':set hlsearch!<CR>')
vim.keymap.set({'n','x'}, 'gy', '"+y')
vim.keymap.set({'n','x','o'}, 'ga', ':<C-u>normal! ggVG<CR>')
vim.keymap.set({'n','x','o'}, 'go', ':HopChar1<CR>')

vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
