-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<leader>ds', dap.continue, desc = '[D]ebug [S]tart/Continue' },
      { ']n', dap.step_over, desc = 'Debug: Step Over' },
      { ']i', dap.step_into, desc = 'Debug: Step Into' },
      { '[i', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>bb', dap.toggle_breakpoint, desc = 'Set [B]reakpoint' },
      {
        '<leader>bc',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Set [B]reakpoint with [C]ondition',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<leader>do', dapui.open, desc = '[D]ebug [O]pen' },
      { '<leader>dc', dapui.close, desc = '[D]ebug [C]lose UI' },
      { '<C-k>', dapui.eval, desc = 'Evaluate expression under cursor' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
        'python',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      controls = {
        enabled = false,
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.50,
            },
            {
              id = 'breakpoints',
              size = 0.20,
            },
            {
              id = 'stacks',
              size = 0.20,
            },
            {
              id = 'watches',
              size = 0.10,
            },
          },
          position = 'left',
          size = 40,
        },
        {
          elements = { {
            id = 'console',
            size = 1,
          } },
          position = 'bottom',
          size = 10,
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --   detached = vim.fn.has 'win32' == 0,
    -- },
    -- }
  end,
}
