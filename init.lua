require 'core'

local custom_init_path = vim.api.nvim_get_runtime_file('lua/custom/init.lua', false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require('core.utils').load_mappings()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require('core.bootstrap').gen_chadrc_template()
  require('core.bootstrap').lazy(lazypath)
end

dofile(vim.g.base46_cache .. 'defaults')
vim.opt.rtp:prepend(lazypath)
require 'plugins'

-- vim.keymap.set('i', '=', function()
--   local r, c = unpack(vim.api.nvim_win_get_cursor(0))
--   local pos = { r, c }
--   local node = vim.treesitter.get_node { pos = pos }
--   if not node then
--     return '='
--   end
--
--   print(node)
--
--   -- local char_before_cursor = vim.fn.strcharpart(vim.fn.strpart(vim.fn.getline '.', vim.fn.col '.' - 2), 0, 1)
--
--   -- print(char_before_cursor)
-- end)
