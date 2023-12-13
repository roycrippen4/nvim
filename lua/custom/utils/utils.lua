local M = {}

function M.map(modes, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    if type(rhs) == 'string' then
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    else
      opts.callback = rhs
      vim.api.nvim_set_keymap(mode, lhs, '', opts)
    end
  end
end

function M.termcode(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Bust the cache of all required Lua files.
-- After running this, each require() would re-run the file.
local function unload_all_modules()
  -- Lua patterns for the modules to unload
  local unload_modules = {
    '^j.',
  }

  for k, _ in pairs(package.loaded) do
    for _, v in ipairs(unload_modules) do
      if k:match(v) then
        package.loaded[k] = nil
        break
      end
    end
  end
end

function M.reload()
  -- Stop LSP
  vim.cmd.LspStop()

  -- Stop eslint_d
  vim.fn.execute 'silent !pkill -9 eslint_d'

  -- Unload all already loaded modules
  unload_all_modules()

  -- Source init.lua
  vim.cmd.luafile '$MYVIMRC'
end

-- Restart Vim without having to close and run again
function M.restart()
  -- Reload config
  M.reload()

  -- Manually run VimEnter autocmd to emulate a new run of Vim
  vim.cmd.doautocmd 'VimEnter'
end

function M.read_json_file(filename)
  local Path = require 'plenary.path'

  local path = Path:new(filename)
  if not path:exists() then
    return nil
  end

  local json_contents = path:read()
  local json = vim.fn.json_decode(json_contents)

  return json
end

function M.read_package_json()
  return M.read_json_file 'package.json'
end

---Check if the given NPM package is installed in the current project.
---@param package string
---@return boolean
function M.is_npm_package_installed(package)
  local package_json = M.read_package_json()
  if not package_json then
    return false
  end

  if package_json.dependencies and package_json.dependencies[package] then
    return true
  end

  if package_json.devDependencies and package_json.devDependencies[package] then
    return true
  end

  return false
end

-- Useful function for debugging
-- Print the given items
function _G.P(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

function M.create_highlight_via_syntax(default_hl, new_hl)
  vim.api.nvim_command('hi def link Custom' .. default_hl .. ' ' .. new_hl)
end

M.get_nvim_tree_width = function()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == 'NvimTree' then
      return vim.api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

--- Sets the title in the overlay section above nvimtree
M.set_nvim_tree_overlay_title = function()
  local title = 'File Tree'
  local tree_width = M.get_nvim_tree_width()

  -- early return if tree is not shown
  if tree_width == 0 then
    return
  end

  -- Set the title if the tree is shown, but no buffers are open
  if #vim.t.bufs == 0 then
    local start_title = vim.loop.cwd()
    -- local start_width = vim.api.nvim_win_get_width(0) - #start_title
    vim.g.NvimTreeOverlayTitle = '%#NvimTreeTitle#' .. start_title --[[ .. ]] --[[ string.rep(' ', start_width) ]]
    return
  end

  -- Set the title if the tree is shown and buffers are open
  local width = tree_width - #title
  local padding = string.rep(' ', math.floor(width / 2))
  local title_with_pad = padding .. title .. padding
  if tree_width % 2 == 0 then
    vim.g.NvimTreeOverlayTitle = '%#NvimTreeTitle#' .. title_with_pad .. '%#NvimTreeTitleSep#' .. '▏'
  else
    vim.g.NvimTreeOverlayTitle = '%#NvimTreeTitle#'
      .. string.sub(title_with_pad, 0, -2)
      .. '%#NvimTreeTitleSep#'
      .. '▏'
  end
end

return M
