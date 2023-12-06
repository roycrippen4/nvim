local overrides = require 'custom.configs.overrides'
local colors = require('base46').get_theme_tb 'base_30'

local plugins = {

  {
    'lukas-reineke/indent-blankline.nvim',
    version = '3.3.8',
    event = 'BufRead',
    config = function()
      local highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      }
      local opts = {
        indent = {
          char = '▎',
        },
        scope = {
          show_exact_scope = true,
          highlight = highlight,
          include = {
            node_type = {
              lua = {
                'return_statement',
                'table_constructor',
              },
            },
          },
        },
        viewport_buffer = { min = 50, max = 1000 },
        exclude = {
          filetypes = {
            'help',
            'terminal',
            'lazy',
            'lspinfo',
            'TelescopePrompt',
            'TelescopeResults',
            'mason',
            'nvdash',
            'nvcheatsheet',
            '',
          },
        },
      }
      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      require('ibl').setup(opts)
    end,
  },

  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'BufReadPre',
    opts = {},
  },

  {
    'utilyre/barbecue.nvim',
    event = 'BufReadPre',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons', -- optional dependency
    },
    config = function()
      require('barbecue').setup {
        attach_navic = false,
        symbols = {
          separator = '',
        },
        context_follow_icon_color = true,
        theme = {
          normal = {},
          dirname = { fg = colors.light_grey },
          basename = { bold = true },

          separator = { fg = colors.red },
          ellipses = { fg = colors.red },
          modified = { fg = colors.red },

          context_constructor = { fg = colors.yellow },
          context_function = { fg = colors.sun },
          context_method = { fg = colors.sun },

          context_class = { fg = colors.purple },
          context_struct = { fg = colors.purple },

          context_interface = { fg = colors.teal },
          context_type_parameter = { fg = colors.teal },
          context_enum = { fg = colors.teal },
          context_enum_member = { fg = colors.nord_blue },

          context_array = { fg = colors.baby_pink },
          context_object = { fg = colors.pink },
          context_field = { fg = colors.baby_pink },
          context_key = { fg = colors.baby_pink },

          --primatives
          context_string = { fg = colors.green },
          context_number = { fg = colors.white },
          context_boolean = { fg = colors.sun },
        },
      }
    end,
  },

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
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = 'VimEnter',
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
        -- pre_hook = function()
        --   return vim.bo.commentstring
        -- end,
      }
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function()
      local rt = require 'rust-tools'
      local M = require 'custom.configs.lspconfig'
      rt.setup {
        inlay_hints = {
          auto = true,
        },
        server = {
          on_attach = M.on_attach,
        },
      }
    end,
  },

  {
    'kylechui/nvim-surround',
    event = 'VimEnter',
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
    'williamboman/mason.nvim',
    cmd = 'Mason',
  },

  {
    'williamboman/mason-lspconfig.nvim',
  },

  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    config = function()
      local M = require 'custom.configs.lspconfig'
      require('typescript-tools').setup {
        on_attach = M.on_attach,
        settings = {
          tsserver_plugins = {
            '@styled/typescript-styled-plugin',
          },
          tsserver_file_preferences = {
            -- Inlay Hints
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            jsxAttributeCompletionStyle = 'auto',
          },
        },
        vim.keymap.set('n', 'fi', '<cmd> TSToolsOrganizeImports<CR>', { desc = 'Organize imports' }),
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'VimEnter',
    dependencies = {
      'folke/neodev.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    },
    config = function()
      require 'custom.configs.lspconfig'
    end,
  },

  {
    'stevearc/conform.nvim',
    lazy = true,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('conform').setup {
        quiet = true,
        formatters_by_ft = {
          lua = { 'stylua' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          javascript = { 'prettier' },
          javascriptreact = { 'prettier' },
          json = { 'pretter' },
          html = { 'prettier' },
          css = { 'prettier' },
          markdown = { 'prettier' },
          yaml = { 'prettier' },
          sh = { 'shfmt' },
        },
        format_on_save = {
          timeout_ms = 500,
          async = false,
          lsp_fallback = true,
        },
      }
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    ft = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'html',
      'svelte',
      'jsx',
      'tsx',
      'markdown',
      'mdx',
    },
    config = function()
      require('nvim-ts-autotag').setup {
        autotag = {
          enable_close_on_slash = false,
        },
      }
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
    'declancm/cinnamon.nvim',
    event = 'VimEnter',
    opts = {
      max_length = 50,
    },
  },

  {
    'echasnovski/mini.nvim',
    version = '*',
    event = 'VimEnter',
    config = function() end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = overrides.treesitter,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. 'syntax')
      require('nvim-treesitter.configs').setup(opts)
    end,
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
    lazy = true,
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
      vim.keymap.set('n', '<Leader>dp', function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end)
      vim.keymap.set('n', '<Leader>dr', function()
        require('dap').repl.open()
      end, { desc = 'Repl open' })

      vim.keymap.set('n', '<Leader>dl', function()
        require('dap').run_last()
      end, { desc = 'Run Last' })

      vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
        require('dap.ui.widgets').hover()
      end, { desc = 'Hover' })

      -- vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
      --   require('dap.ui.widgets').preview()
      -- end, { desc = 'Preview' })

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

  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VimEnter',
    config = function()
      require('rainbow-delimiters.setup').setup {}
    end,
  },
}

return plugins
