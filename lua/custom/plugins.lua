-- local overrides = require 'custom.configs.overrides'

local plugins = {

  -- {
  --   'roycrippen4/stickybuf.nvim',
  --   lazy = false,
  --   opts = {},
  -- },

  {
    'luukvbaal/statuscol.nvim',
    lazy = false,
    branch = '0.10',
    config = function()
      local builtin = require 'statuscol.builtin'
      require('statuscol').setup {
        ft_ignore = { 'NvimTree', 'terminal' },
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
              namespace = { 'gitsign' },
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
      -- local highlight = {
      --   'RainbowDelimiterRed',
      --   'RainbowDelimiterYellow',
      --   'RainbowDelimiterViolet',
      --   'RainbowDelimiterBlue',
      --   'RainbowDelimiterOrange',
      --   'RainbowDelimiterGreen',
      --   'RainbowDelimiterCyan',
      -- }
      -- local hooks = require 'ibl.hooks'
      local opts = {
        indent = {
          char = '▎',
        },
        scope = {
          -- highlight = highlight,
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
      -- vim.g.rainbow_delimiters = { highlight = highlight }
      require('ibl').setup(opts)
      -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      dofile(vim.g.base46_cache .. 'blankline')
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
      dofile()
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
    -- opts = overrides.cmp,

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
          sh = { 'shfmt' },
          yaml = { 'prettier' },
        },
        format_on_save = {
          timeout_ms = 500,
          async = false,
          lsp_fallback = true,
        },
        -- formatters = {
        --   shfmt = {
        --     prepend_args = { '-i', '2' },
        --   },
        -- },
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
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    keys = {
      { '<C-e>', nil, 'n', { desc = 'Open Harpoon UI' } },
      { '<C-a>', nil, 'n', { desc = 'Add buffer to harpoon' } },
      { '<C-1>', nil, 'n', { desc = 'Go to file 1' } },
      { '<C-2>', nil, 'n', { desc = 'Go to file 2' } },
      { '<C-3>', nil, 'n', { desc = 'Go to file 3' } },
      { '<C-4>', nil, 'n', { desc = 'Go to file 4' } },
      { '<C-5>', nil, 'n', { desc = 'Go to file 5' } },
      { '<C-6>', nil, 'n', { desc = 'Go to file 6' } },
      { '<C-7>', nil, 'n', { desc = 'Go to file 7' } },
      { '<C-8>', nil, 'n', { desc = 'Go to file 8' } },
      { '<C-9>', nil, 'n', { desc = 'Go to file 9' } },
      { '<C-0>', nil, 'n', { desc = 'Go to file 0' } },
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {}
      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():append()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<C-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-4>', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<C-5>', function()
        harpoon:list():select(5)
      end)
      vim.keymap.set('n', '<C-6>', function()
        harpoon:list():select(6)
      end)
      vim.keymap.set('n', '<C-7>', function()
        harpoon:list():select(7)
      end)
      vim.keymap.set('n', '<C-8>', function()
        harpoon:list():select(8)
      end)
      vim.keymap.set('n', '<C-9>', function()
        harpoon:list():select(9)
      end)
      vim.keymap.set('n', '<C-0>', function()
        harpoon:list():select(0)
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

  -- Install a plugin
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  -- {
  --   'folke/zen-mode.nvim',
  --   cmd = 'ZenMode',
  --   opts = require 'custom.configs.zenmode',
  -- },

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
