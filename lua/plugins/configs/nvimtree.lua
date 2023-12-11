vim.g.NvimTreeOverlayTitle = ''
local api = require 'nvim-tree.api'
local M = {}

M.getNvimTreeWidth = function()
  for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.bo[vim.api.nvim_win_get_buf(win)].ft == 'NvimTree' then
      return vim.api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

M.set_nvim_tree_overlay_title = function()
  local title = 'File Tree'
  local tree_width = M.getNvimTreeWidth()
  if tree_width == 0 then
    vim.g.NvimTreeOverlayTitle = ''
  else
    local width = tree_width - #title
    local padding = string.rep(' ', width)
    local middle_idx = math.floor(width / 2) + 1
    local pad_left = string.sub(padding, 1, middle_idx - 1)
    local pad_right = pad_left
    local title_with_pad = pad_left .. title .. pad_right
    -- vim.g.NvimTreeOverlayTitle = '%#NvimTreeTitle#' .. title_with_pad .. '%#NvimTreeTitleSep#' .. '▕'
    vim.g.NvimTreeOverlayTitle = '%#NvimTreeTitle#' .. title_with_pad .. '%#NvimTreeTitleSep#' .. '▏'
  end
end

local Event = api.events.Event
api.events.subscribe(Event.TreeOpen, function()
  if api.tree.is_visible() then
    M.set_nvim_tree_overlay_title()
  end
end)

api.events.subscribe(Event.Resize, function()
  M.set_nvim_tree_overlay_title()
end)

api.events.subscribe(Event.TreeClose, function()
  if not api.tree.is_visible() then
    M.set_nvim_tree_overlay_title()
  end
end)

local function my_on_attach(bufnr)
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.del('n', '<C-]>', { buffer = bufnr })
  vim.keymap.del('n', '<C-t>', { buffer = bufnr })
  vim.keymap.del('n', '<C-e>', { buffer = bufnr })
  vim.keymap.del('n', '.', { buffer = bufnr })
  vim.keymap.del('n', '-', { buffer = bufnr })
  vim.keymap.del('n', 'g?', { buffer = bufnr })

  vim.keymap.set(
    'n',
    '<C-t>',
    api.tree.change_root_to_parent,
    { desc = 'Up', buffer = bufnr, noremap = true, silent = true, nowait = true }
  )
  vim.keymap.set(
    'n',
    '.',
    api.tree.change_root_to_node,
    { desc = 'CD', buffer = bufnr, noremap = true, silent = true, nowait = true }
  )
  vim.keymap.set(
    'n',
    '?',
    api.tree.toggle_help,
    { desc = 'Help', buffer = bufnr, noremap = true, silent = true, nowait = true }
  )
end

local my_root_folder_label = function(path)
  return './' .. vim.fn.fnamemodify(path, ':t')
end

local options = {
  on_attach = my_on_attach,
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath 'config' .. '/lua/custom' },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    signcolumn = 'no',
    adaptive_size = true,
    side = 'left',
    width = 10,
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    -- root_folder_modifier = ':t',
    root_folder_label = my_root_folder_label,
    highlight_git = true,
    highlight_opened_files = 'name',

    indent_markers = {
      enable = true,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },

      glyphs = {
        default = '󰈚',
        symlink = '',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
          symlink_open = '',
          arrow_open = '',
          arrow_closed = '',
        },
        git = {
          unstaged = '✗',
          staged = '✓',
          unmerged = '',
          renamed = '➜',
          untracked = '★',
          deleted = '',
          ignored = '◌',
        },
      },
    },
  },
}

return options
