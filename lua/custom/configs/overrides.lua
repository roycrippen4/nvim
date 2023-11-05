local M = {}

M.cmp = {
  sources = {
    { name = 'nvim_lsp', trigger_characters = { '-' } },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
  },
  experimental = {
    ghost_text = true,
  },
}

M.whichkey = {
  plugin = true,
  disable = false,
  config = function()
    require 'plugins.configs.which-key'
    local ok, wk = pcall(require, 'which-key')
    if not ok then
      return
    end
    wk.register {
      ['<leader'] = {
        f = { name = 'find' },
      },
    }
  end,
  setup = function()
    require('core.utils').load_mappings 'whichkey'
  end,
}

M.treesitter = {
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  ensure_installed = {
    'bash',
    'vim',
    'lua',
    'html',
    'css',
    'json',
    'toml',
    'javascript',
    'typescript',
    'tsx',
    'c',
    'markdown',
    'markdown_inline',
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
