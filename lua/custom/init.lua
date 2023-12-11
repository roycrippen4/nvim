local opt = vim.o

opt.relativenumber = true
opt.scrolloff = 10

vim.g.skip_ts_context_commentstring_module = true
vim.g.markdown_fenced_languages = {
  'ts=typescript',
}
vim.treesitter.language.register('markdown', 'mdx')
--
-- local test = '▕'
-- vim.cmd [[ set fillchars+=vert:\▕ ]]
-- vim.cmd [[ set fillchars+=vertright:▕ ]]
-- vim.cmd [[ set fillchars+=horizup:▕ ]]
-- vim.cmd [[ set fillchars+=horizdown:▕ ]]
-- vim.cmd [[ set fillchars+=verthoriz:▕ ]]
-- vim.cmd [[ set fillchars+=horiz:\▁ ]]

vim.cmd [[ set fillchars+=vert:\▏]]
vim.cmd [[ set fillchars+=vertright:\▏]]
vim.cmd [[ set fillchars+=vertleft:\▏]]
vim.cmd [[ set fillchars+=horizup:\▏]]
vim.cmd [[ set fillchars+=horizdown:\▁]]
vim.cmd [[ set fillchars+=verthoriz:\▏]]
vim.cmd [[ set fillchars+=horiz:\▁]]
-- vim.cmd [[ set fillchars+=verthoriz:\]]

require 'custom.utils.utils'
require 'custom.utils.commands'
require 'custom.utils.autocommands'
require 'custom.utils.diagnostic'
