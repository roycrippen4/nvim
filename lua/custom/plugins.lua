local overrides = require 'custom.configs.overrides'

local plugins = {
  {
    'Aasim-A/scrollEOF.nvim',
    event = 'BufRead',
    config = function()
      require('scrollEOF').setup {}
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = 'VimEnter',
    config = function()
      ---@diagnostic disable-next-line
      require('Comment').setup {}
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
    event = 'VimEnter',
    config = function()
      require 'custom.configs.conform'
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
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
      vim.filetype.add {
        extension = { mdx = 'mdx' },
      }
    end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
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
    config = function()
      require 'custom.configs.zenmode'
    end,
  },

  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
  },
}

return plugins
