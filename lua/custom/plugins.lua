local overrides = require 'custom.configs.overrides'

local plugins = {

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    keys = {
      { '<leader>mt', mode = { 'n' } },
      { '<leader>mp', mode = { 'n' } },
      { '<leader>ms', mode = { 'n' } },
    },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      vim.keymap.set('n', '<leader>mt', '<cmd> MarkdownPreviewToggle <CR>', { desc = 'Toggle Markdown Preview' })
      vim.keymap.set('n', '<leader>mp', '<cmd> MarkdownPreview <CR>', { desc = 'Preview Markdown' })
      vim.keymap.set('n', '<leader>ms', '<cmd> MarkdownPreviewStop <CR>', { desc = 'Stop Markdown Preview' })
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    keys = {
      { '<leader>dt', mode = { 'n' } },
    },
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      ---@diagnostic disable-next-line
      require('dapui').setup {}
      local dap, dapui = require 'dap', require 'dapui'

      vim.keymap.set('n', '<Leader>dt', function()
        dapui.toggle()
      end, { desc = 'Toggle Debug UI' })

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },

  {
    'folke/trouble.nvim',
    keys = {
      { '<leader>tf', mode = { 'n' } },
      { '<leader>tt', mode = { 'n' } },
    },
    opts = {},
  },

  {
    'Aasim-A/scrollEOF.nvim',
    event = 'BufRead',
    config = function()
      require('scrollEOF').setup {}
    end,
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, 'gcc' },
    },
    config = function()
      ---@diagnostic disable-next-line
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    event = 'VimEnter',
    config = function()
      local rt = require 'rust-tools'
      rt.setup {
        inlay_hints = {
          auto = true,
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set('n', '<leader>la', rt.code_action_group.code_action_group, { buffer = bufnr })
          end,
        },
      }
    end,
  },

  {
    'kylechui/nvim-surround',
    event = 'InsertEnter',
    config = function()
      require('nvim-surround').setup()
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    opts = overrides.cmp,

    dependencies = {
      {
        -- snippet plugin
        'L3MON4D3/LuaSnip',
        config = function(_, opts)
          -- load default luasnip config
          require('plugins.configs.others').luasnip(opts)

          local luasnip = require 'luasnip'
          luasnip.filetype_extend('javascriptreact', { 'html' })
          luasnip.filetype_extend('typescriptreact', { 'html' })
          require('luasnip/loaders/from_vscode').lazy_load()
        end,
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    event = 'VimEnter',
    dependencies = {
      'simrat39/rust-tools.nvim',
      'pmizio/typescript-tools.nvim',
      'folke/neodev.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      {
        'williamboman/mason.nvim',
        dependencies = {
          'mfussenegger/nvim-dap',
          'jay-babu/mason-nvim-dap.nvim',
          'williamboman/mason-lspconfig.nvim',
          'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
        config = function()
          require 'custom.configs.mason'
        end,
      },
    },
    config = function()
      require 'custom.configs.lspconfig'
    end,
  },

  {
    'stevearc/conform.nvim',
    event = 'LspAttach',
    config = function()
      local opts = require 'custom.configs.conform'
      local conform = require 'conform'
      conform.setup(opts)

      require('conform.formatters.prettier').args = function(ctx)
        local args = { '--stdin-filepath', '$FILENAME' }

        local localPrettierConfig = vim.fs.find('.prettierrc.json', {
          upward = true,
          path = ctx.dirname,
          type = 'file',
        })[1]

        local globalPrettierConfig = vim.fs.find('.prettierrc.json', {
          path = vim.fn.expand '~/.config/nvim',
          type = 'file',
        })[1]

        if localPrettierConfig then
          vim.list_extend(args, { '--config', localPrettierConfig })
        elseif globalPrettierConfig then
          vim.list_extend(args, { '--config', globalPrettierConfig })
        end
        return args
      end
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup {}
    end,
  },

  {
    'ThePrimeagen/harpoon',
    cmd = 'Harpoon',
    keys = {
      { '<C-e>', nil, 'n', { desc = 'Open Harpoon UI' } },
      { '<C-a>', nil, 'n', { desc = 'Add buffer to harpoon' } },
      { '<C-1>', nil, 'n', { desc = 'Go to file 1' } },
      { '<C-2>', nil, 'n', { desc = 'Go to file 2' } },
      { '<C-3>', nil, 'n', { desc = 'Go to file 3' } },
      { '<C-4>', nil, 'n', { desc = 'Go to file 4' } },
      { '<C-5>', nil, 'n', { desc = 'Go to file 5' } },
    },
    config = function()
      local ui = require 'harpoon.ui'
      local mark = require 'harpoon.mark'
      require('harpoon').setup {}
      vim.keymap.set('n', '<C-e>', function()
        ui.toggle_quick_menu()
      end, { desc = 'Open Harpoon UI' })
      vim.keymap.set('n', '<C-a>', function()
        mark.add_file()
      end, { desc = 'Add buffer to harpoon' })
      vim.keymap.set('n', '<C-1>', function()
        ui.nav_file(1)
      end, { desc = 'Go to file 1' })
      vim.keymap.set('n', '<C-2>', function()
        ui.nav_file(2)
      end, { desc = 'Go to file 2' })
      vim.keymap.set('n', '<C-3>', function()
        ui.nav_file(3)
      end, { desc = 'Go to file 3' })
      vim.keymap.set('n', '<C-4>', function()
        ui.nav_file(4)
      end, { desc = 'Go to file 4' })
      vim.keymap.set('n', '<C-5>', function()
        ui.nav_file(5)
      end, { desc = 'Go to file 5' })
    end,
  },

  {
    'karb94/neoscroll.nvim',
    keys = { '<C-d>', '<C-u>' },
    config = function()
      require('neoscroll').setup {
        hide_cursor = false,
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'syntax')
      require('nvim-treesitter.configs').setup(opts)
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      { 'windwp/nvim-ts-autotag', opts = {} },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = require 'custom.configs.zenmode',
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  },

  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<leader>dc', mode = { 'n' } },
      { '<leader>dsv', mode = { 'n' } },
      { '<leader>dsi', mode = { 'n' } },
      { '<leader>dso', mode = { 'n' } },
      { '<leader>db', mode = { 'n' } },
      { '<leader>dB', mode = { 'n' } },
      { '<leader>dr', mode = { 'n' } },
      { '<leader>dl', mode = { 'n' } },
      { '<leader>dh', mode = { 'n' } },
      { '<leader>dp', mode = { 'n' } },
      { '<leader>df', mode = { 'n' } },
      { '<leader>ds', mode = { 'n' } },
    },
    config = function()
      require 'dap'
      vim.keymap.set('n', '<Leader>dc', function()
        require('dap').continue()
      end, { desc = 'Continue' })

      vim.keymap.set('n', '<Leader>dsv', function()
        require('dap').step_over()
      end, { desc = 'Step into' })

      vim.keymap.set('n', '<Leader>dsi', function()
        require('dap').step_into()
      end, { desc = 'Step into' })

      vim.keymap.set('n', '<Leader>dso', function()
        require('dap').step_out()
      end, { desc = 'Step out' })

      vim.keymap.set('n', '<Leader>db', function()
        require('dap').toggle_breakpoint()
      end, { desc = 'Toggle breakpoint' })

      vim.keymap.set('n', '<Leader>dB', function()
        require('dap').set_breakpoint()
      end, { desc = 'Set breakpoint' })

      -- vim.keymap.set('n', '<Leader>lp', function()
      --   require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      -- end)

      vim.keymap.set('n', '<Leader>dr', function()
        require('dap').repl.open()
      end, { desc = 'Repl open' })

      vim.keymap.set('n', '<Leader>dl', function()
        require('dap').run_last()
      end, { desc = 'Run Last' })

      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end, { desc = 'Hover' })

      vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
        require('dap.ui.widgets').preview()
      end, { desc = 'Preview' })

      vim.keymap.set('n', '<Leader>df', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.frames)
      end, { desc = 'Show frames' })

      vim.keymap.set('n', '<Leader>ds', function()
        local widgets = require 'dap.ui.widgets'
        widgets.centered_float(widgets.scopes)
      end, { desc = 'Show scopes' })
    end,
  },
}

return plugins
