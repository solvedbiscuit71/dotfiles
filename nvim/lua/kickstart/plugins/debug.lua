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
      { '<leader>d.', dap.continue, desc = 'Debug: Current File' },
      { '<leader>dn', dap.step_over, desc = 'Debug: Step to [N]ext Line' },
      { '<leader>di', dap.step_into, desc = 'Debug: Step [I]nto function' },
      { '<leader>do', dap.step_out, desc = 'Debug: Step [O]ut of function' },
      { '<leader>bt', dap.toggle_breakpoint, desc = 'Debug: [T]oggle [B]reakpoint' },
      {
        '<leader>bc',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set [B]reakpoint with [C]ondition',
      },
      -- Toggle to see last session result.
      { '<leader>dt', dapui.toggle, desc = 'Debug: [T]oggle UI' },
      { '<leader>de', dapui.eval, desc = 'Debug: [E]valuate expression under cursor' },
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
              size = 0.6,
            },
            {
              id = 'watches',
              size = 0.4,
            },
          },
          position = 'left',
          size = 30,
        },
        {
          elements = {
            {
              id = 'stacks',
              size = 0.6,
            },
            {
              id = 'breakpoints',
              size = 0.4,
            },
          },
          position = 'right',
          size = 30,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.5,
            },
            {
              id = 'console',
              size = 0.5
            },
          },
          position = 'bottom',
          size = 10
        },
      },
    }

    -- Open the UI, after starting the debug session
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    -- Also see,
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
