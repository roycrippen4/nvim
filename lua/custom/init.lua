local opt = vim.o

opt.relativenumber = true
opt.scrolloff = 10

vim.g.skip_ts_context_commentstring_module = true
vim.g.markdown_fenced_languages = {
  'ts=typescript',
}

require 'custom.utils.commands'
require 'custom.utils.autocommands'
require 'custom.utils.diagnostic'
