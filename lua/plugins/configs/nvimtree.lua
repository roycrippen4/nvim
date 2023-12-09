local function my_on_attach(bufnr)
  local api = require 'nvim-tree.api'

  api.config.mappings.default_on_attach(bufnr)
  -- remove default keymaps
  vim.keymap.del('n', '<C-]>', { buffer = bufnr })
  vim.keymap.del('n', '<C-t>', { buffer = bufnr })
  vim.keymap.del('n', '<C-e>', { buffer = bufnr })
  vim.keymap.del('n', '.', { buffer = bufnr })
  vim.keymap.del('n', '-', { buffer = bufnr })
  vim.keymap.del('n', 'g?', { buffer = bufnr })

  -- replace default keymaps
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
