-- Neovim Options

vim.g.mapleader = ' '
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
vim.opt.listchars='trail:∙,lead:∙,eol:↵,nbsp:␣,tab:→ '
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
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = "nvim-treesitter",
        requires = 'nvim-treesitter/nvim-treesitter',
    }
    use { 'catppuccin/nvim', as = 'catppuccin' }
    use 'windwp/nvim-autopairs'
    use 'luukvbaal/nnn.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    use { 'kylechui/nvim-surround', tag = '*', }
    use { 'phaazon/hop.nvim', branch = 'v2' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = {{'nvim-lua/plenary.nvim'}}}

    if packer_bootstrap then
        require('packer').sync()
    end
end)

-- Plugin Configuration

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

require('nvim-autopairs').setup{}
require('Comment').setup{}
require('nvim-surround').setup{}
require('hop').setup{}

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'c', 'lua', 'markdown', 'vim', 'vimdoc', 'query' },
    auto_install = true,
    ignore_install = { 'tmux' },
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
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['ap'] = '@parameter.outer',
                ['ip'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
                ['am'] = '@comment.outer',
                ['im'] = '@comment.inner',
            },
        },
    },
    indent = {
        enable = true
    },
}

require('lualine').setup {
    options = {
        icons_enabled = false,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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

require('nnn').setup({
    picker = {
        cmd = 'nnn -CH',
        style = {
            width = 0.5,
            height = 0.5,
            xoffset = 0.5,
            yoffset = 0.5,
            border = 'rounded',
        },
        tabs = false,
        fullscreen = false,
    },
})

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
        },
    },
}

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    })
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.pyright.setup { capabilities = capabilities, }
lspconfig.clangd.setup{ capabilities = capabilities, }
lspconfig.html.setup { capabilities = capabilities, }
lspconfig.cssls.setup { capabilities = capabilities, }
lspconfig.tsserver.setup{ capabilities = capabilities, }

-- Configuration

vim.api.nvim_command('colorscheme catppuccin')

vim.keymap.set('n', '<leader>n', ':NnnPicker %:p:h<CR>')
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files)
vim.keymap.set('n', '<leader>g', function() require('telescope.builtin').find_files({ hidden=true }) end)
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>r', require('telescope.builtin').oldfiles)
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

vim.keymap.set({'i', 's'}, '<C-l>', function() require('luasnip').jump(1) end, {silent = true})
vim.keymap.set({'i', 's'}, '<C-h>', function() require('luasnip').jump(-1) end, {silent = true})

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

vim.keymap.set('i', '<C-space>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.references)
vim.keymap.set({'n','v'}, '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'R', vim.lsp.buf.rename)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
