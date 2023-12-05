local M = {}

-- 󰱺
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

M.treesitter = {
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
    disable = {
      'yaml',
    },
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
