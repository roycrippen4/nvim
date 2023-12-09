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

return M
