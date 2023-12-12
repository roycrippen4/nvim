local autocmd = vim.api.nvim_create_autocmd
local api = require 'nvim-tree.api'

autocmd('QuitPre', {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match 'NvimTree_' ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end,
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local hl_ns = vim.api.nvim_create_namespace 'search'
local hlsearch_group = vim.api.nvim_create_augroup('hlsearch_group', { clear = true })

local function manage_hlsearch(char)
  local key = vim.fn.keytrans(char)
  local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }

  if vim.fn.mode() == 'n' then
    if not vim.tbl_contains(keys, key) then
      vim.cmd [[ :set nohlsearch ]]
    elseif vim.tbl_contains(keys, key) then
      vim.cmd [[ :set hlsearch ]]
    end
  end
  ---@diagnostic disable next-line
  vim.on_key(nil, hl_ns)
end

autocmd({ 'InsertLeave', 'WinEnter' }, {
  callback = function()
    vim.cmd [[ set cursorline ]]
    vim.api.nvim_set_hl(0, 'CursorLine', { link = 'NvimTreeCursorLine' })
  end,
})

autocmd('CursorMoved', {
  group = hlsearch_group,
  callback = function()
    vim.on_key(manage_hlsearch, hl_ns)
  end,
})

autocmd({ 'BufAdd', 'BufDelete', 'BufEnter', 'TabNew' }, {
  callback = function()
    local current_buf = vim.api.nvim_get_current_buf()
    if #vim.t.bufs == 0 then
      -- vim.api.nvim_set_hl(0, 'NvimTreeTitleSep', { link = 'NvimTreeTitleSepStart' })
      return
    else
      local first_buf = vim.t.bufs[1]
      if first_buf == current_buf then
        vim.api.nvim_set_hl(0, 'NvimTreeTitleSep', { link = 'NvimTreeTitleSepOn' })
      else
        vim.api.nvim_set_hl(0, 'NvimTreeTitleSep', { link = 'NvimTreeTitleSepOff' })
      end
    end
  end,
})

autocmd({ 'InsertEnter', 'WinLeave' }, { command = 'set nocursorline', group = group })
