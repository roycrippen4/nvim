local opt = vim.o

opt.relativenumber = true
opt.scrolloff = 12
opt.spell = true

vim.g.markdown_fenced_languages = {
  'ts=typescript',
}

vim.cmd [[autocmd VimEnter * highlight CursorLine guibg=#1e252e]]

require 'custom.commands'
require 'custom.autocommands'
