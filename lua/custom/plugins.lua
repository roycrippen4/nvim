local overrides = require 'custom.configs.overrides'
local utils = require 'custom.utils.utils'
-- local colors = require('base46').get_theme_tb 'base_30'

local plugins = {

  {
    'luukvbaal/statuscol.nvim',
    event = 'BufRead',
    branch = '0.10',
    config = function()
      local builtin = require 'statuscol.builtin'
      require('statuscol').setup {
        ft_ignore = { 'NvimTree' },
        relculright = true,
        segments = {
          {
            sign = {
              name = { 'Diagnostic' },
              maxwidth = 1,
              auto = false,
            },
          },
          {
            sign = {
              name = { 'Dap' },
              maxwidth = 1,
              auto = true,
            },
          },
          {
            sign = {
              name = { 'todo' },
              maxwidth = 1,
              auto = true,
            },
          },
          {
            text = {
              builtin.lnumfunc,
              ' ',
            },
          },
          {
            sign = {
              name = { 'GitSign' },
              maxwidth = 1,
              auto = true,
            },
          },
        },
      }
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    version = '3.3.8',
    event = 'BufRead',
    config = function()
      local highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterCyan',
      }
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      -- hooks.cb.highlight_setup()
      -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#E06C75' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#E5C07B' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#61AFEF' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#D19A66' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#98C379' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#C678DD' })
      --   vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#56B6C2' })
      -- end)
      local opts = {
        indent = {
          char = '▎',
        },
        scope = {
          highlight = highlight,
          include = {
            node_type = {
              lua = {
                'arguments',
                'function_call',
                'identifier',
                'return_statement',
                'string_content',
                'table_constructor',
              },
              typescript = {
                'arguments',
                'call_expression',
                'expression_statement',
                'for_in_statement',
                'if_statement',
                'import_statement',
                'interface_declaration',
                'object',
                'return_statement',
                'statement_block',
                'try_statement',
                'type_alias_delcaration',
              },
            },
          },
        },
        exclude = {
          buftypes = { 'terminal' },
          filetypes = {
            '',
            'NvimTree',
            'TelescopePrompt',
            'TelescopeResults',
            'help',
            'lazy',
            'lspinfo',
            'mason',
            'nvcheatsheet',
            'nvdash',
            'terminal',
          },
        },
      }
      dofile(vim.g.base46_cache .. 'blankline')
      vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup(opts)
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'BufReadPre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      dofile(vim.g.base46_cache .. 'todo')
    end,
    opts = {},
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
    -- 80001
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    config = function()
      local M = require 'custom.configs.lspconfig'
      local api = require 'typescript-tools.api'
      require('typescript-tools').setup {
        on_attach = M.on_attach,
        settings = {
          tsserver_plugins = {
            '@styled/typescript-styled-plugin',
          },
          tsserver_file_preferences = {
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
        handlers = {
          ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 80001 },
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
    'roycrippen4/harpoon',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    -- branch = 'harpoon2',
    keys = {
      { 'H', nil, 'n', { desc = 'Open Harpoon UI' } },
      { 'L', nil, 'n', { desc = 'Add buffer to harpoon' } },
      { '<C-e>', nil, 'n', { desc = 'Open Harpoon UI' } },
      { '<C-a>', nil, 'n', { desc = 'Add buffer to harpoon' } },
      { '<C-1>', nil, 'n', { desc = 'Go to file 1' } },
      { '<C-2>', nil, 'n', { desc = 'Go to file 2' } },
      { '<C-3>', nil, 'n', { desc = 'Go to file 3' } },
      { '<C-4>', nil, 'n', { desc = 'Go to file 4' } },
      { '<C-5>', nil, 'n', { desc = 'Go to file 5' } },
    },
    config = function()
      local harpoon = require 'harpoon'
      local check_buf = utils.harpoon_check_buf
      harpoon:setup {
        settings = {
          border_chars = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
        },
      }
      vim.keymap.set('n', 'H', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', 'L', function()
        harpoon:list():next()
      end)
      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<C-1>', function()
        check_buf(1, harpoon)
      end)
      vim.keymap.set('n', '<C-2>', function()
        check_buf(2, harpoon)
      end)
      vim.keymap.set('n', '<C-3>', function()
        check_buf(3, harpoon)
      end)
      vim.keymap.set('n', '<C-4>', function()
        check_buf(4, harpoon)
      end)
      vim.keymap.set('n', '<C-5>', function()
        check_buf(5, harpoon)
      end)
      vim.api.nvim_set_hl(0, 'HarpoonWindow', { link = 'Normal' })
      vim.api.nvim_set_hl(0, 'HarpoonTitle', { link = 'TelescopePromptTitle' })
      -- vim.api.nvim_set_hl(0, 'HarpoonBorder', {})
    end,
  },

  -- {
  --   'echasnovski/mini.nvim',
  --   version = '*',
  --   event = 'VimEnter',
  --   config = function() end,
  -- },

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
    -- event = 'VimEnter',
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

      vim.keymap.set({ 'n', 'v' }, '<Leader>dv', function()
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

  {
    'HiPhish/rainbow-delimiters.nvim',
    lazy = false,
    config = function()
      dofile(vim.g.base46_cache .. 'rainbowdelimiters')
      require('rainbow-delimiters.setup').setup {}
    end,
  },
}

return plugins
