local opt = vim.o

opt.relativenumber = true
opt.scrolloff = 12

vim.g.markdown_fenced_languages = {
  'ts=typescript',
}

vim.keymap.set('i', '/', function()
  local node = vim.treesitter.get_node()
  if not node then
    return '/'
  end

  if node:type() == 'jsx_opening_element' then
    local char_at_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2), 0, 1)
    local already_have_space = char_at_cursor == ' '

    return already_have_space and '/>' or ' />'
  end

  return '/'
end, { expr = true, buffer = true })

vim.cmd [[autocmd VimEnter * highlight CursorLine guibg=#1e252e]]

require 'custom.utils.commands'
require 'custom.utils.autocommands'
