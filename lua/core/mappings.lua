-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ['<C-b>'] = { '<ESC>^i', 'Beginning of line' },
    ['<C-e>'] = { '<End>', 'End of line' },

    -- navigate within insert mode
    ['<C-h>'] = { '<Left>', 'Move left' },
    ['<C-l>'] = { '<Right>', 'Move right' },
    ['<C-j>'] = { '<Down>', 'Move down' },
    ['<C-k>'] = { '<Up>', 'Move up' },
  },

  n = {
    ['<Esc>'] = { '<cmd> noh <CR>', 'Clear highlights' },
    -- switch between windows
    ['<C-h>'] = { '<C-w>h', 'Window left' },
    ['<C-l>'] = { '<C-w>l', 'Window right' },
    ['<C-j>'] = { '<C-w>j', 'Window down' },
    ['<C-k>'] = { '<C-w>k', 'Window up' },

    -- save
    ['<C-s>'] = { '<cmd> w <CR>', 'Save file' },

    -- Copy all
    ['<C-c>'] = { '<cmd> %y+ <CR>', 'Copy whole file' },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    -- ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    -- ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    -- ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    -- ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },

    -- new buffer
    -- ['<leader>b'] = { '<cmd> enew <CR>', 'New buffer' },
    -- ['<leader>ch'] = { '<cmd> NvCheatsheet <CR>', 'Mapping cheatsheet' },

    ['<leader>fm'] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      'LSP formatting',
    },
  },

  t = {
    ['<C-x>'] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), 'Escape terminal mode' },
    ['<C-k>'] = { '<C-x><C-k>', 'Escape terminal to the window above' },
  },

  v = {
    ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    ['<'] = { '<gv', 'Indent line' },
    ['>'] = { '>gv', 'Indent line' },
  },

  x = {
    ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ['p'] = { 'p:let @+=@0<CR>:let @"=@0<CR>', 'Dont copy replaced text', opts = { silent = true } },
  },
}

M.tabufline = {
  plugin = true,
  --
  n = {
    -- cycle through buffers
    ['L'] = {
      function()
        require('nvchad.tabufline').tabuflineNext()
      end,
      'Goto next buffer',
    },

    ['H'] = {
      function()
        require('nvchad.tabufline').tabuflinePrev()
      end,
      'Goto prev buffer',
    },

    -- close buffer + hide terminal buffer
    ['<leader>x'] = {
      function()
        if #vim.api.nvim_list_wins() == 1 and string.sub(vim.api.nvim_buf_get_name(0), -10) == 'NvimTree_1' then
          vim.cmd [[ q ]]
        else
          require('nvchad.tabufline').close_buffer()
        end
      end,
      'Close buffer',
    },
  },
}

M.lspconfig = {}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    -- ['<C-n>'] = { '<cmd> NvimTreeToggle <CR>', 'Toggle nvimtree' },
    ['<C-n>'] = {
      function()
        vim.cmd [[NvimTreeToggle]]
        -- print(vim.g.TreeVisible)
      end,
      'Toggle nvimtree',
    },
    ['.'] = { '<C-]>', 'rebind tree cd', 'Set CWD' },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ['<leader>ff'] = { '<cmd> Telescope find_files <CR>', 'Find files' },
    ['<leader>fa'] = { '<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>', 'Find all' },
    ['<leader>fw'] = { '<cmd> Telescope live_grep <CR>', 'Find word (cwd)' },
    ['<leader>fb'] = { '<cmd> Telescope buffers <CR>', 'Find buffers' },
    ['<leader>fh'] = { '<cmd> Telescope help_tags <CR>', 'Find help' },
    ['<leader>fo'] = { '<cmd> Telescope oldfiles <CR>', 'Find oldfiles' },
    ['<leader>fz'] = { '<cmd> Telescope current_buffer_fuzzy_find <CR>', 'Find in current buffer' },
    ['<leader>fc'] = { '<cmd> Telescope git_commits <CR>', 'Find commits' },
    ['<leader>fg'] = { '<cmd> Telescope git_status <CR>', 'Find Git status' },
    ['<leader>fs'] = { '<cmd> Telescope themes <CR>', 'Find scheme' },
    ['<leader>fm'] = { '<cmd> Telescope marks <CR>', 'Find bookmarks' },
    ['<leader>fl'] = { '<cmd> Telescope highlights <CR>', 'Find highlight groups' },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    ['<A-h>'] = {
      function()
        require('nvterm.terminal').toggle 'horizontal'
      end,
      'Toggle horizontal term',
    },
    ['<A-f>'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      'Toggle floating term',
    },
  },
  n = {
    ['<A-h>'] = {
      function()
        require('nvterm.terminal').toggle 'horizontal'
      end,
      'Toggle horizontal term',
    },
    ['<A-f>'] = {
      function()
        require('nvterm.terminal').toggle 'float'
      end,
      'Toggle floating term',
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ['<leader>wK'] = {
      function()
        vim.cmd 'WhichKey'
      end,
      'Which-key all keymaps',
    },
    ['<leader>wk'] = {
      function()
        local input = vim.fn.input 'WhichKey: '
        vim.cmd('WhichKey ' .. input)
      end,
      'Which-key query lookup',
    },
  },
}

-- M.blankline = {
-- plugin = true,
--
-- n = {
--   ['<leader>cc'] = {
--     function()
--       local ok, start = require('indent_blankline.utils').get_current_context(
--         vim.g.indent_blankline_context_patterns,
--         vim.g.indent_blankline_use_treesitter_scope
--       )
--
--       if ok then
--         vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
--         vim.cmd [[normal! _]]
--       end
--     end,
--
--     'Jump to current context',
--   },
-- },
-- }

M.gitsigns = {
  -- plugin = true,
  --
  -- n = {
  --   -- Navigation through hunks
  --   [']c'] = {
  --     function()
  --       if vim.wo.diff then
  --         return ']c'
  --       end
  --       vim.schedule(function()
  --         require('gitsigns').next_hunk()
  --       end)
  --       return '<Ignore>'
  --     end,
  --     'Jump to next hunk',
  --     opts = { expr = true },
  --   },
  --
  --   ['[c'] = {
  --     function()
  --       if vim.wo.diff then
  --         return '[c'
  --       end
  --       vim.schedule(function()
  --         require('gitsigns').prev_hunk()
  --       end)
  --       return '<Ignore>'
  --     end,
  --     'Jump to prev hunk',
  --     opts = { expr = true },
  --   },
  --
  --   -- Actions
  --   -- ['<leader>rh'] = {
  --   --   function()
  --   --     require('gitsigns').reset_hunk()
  --   --   end,
  --   --   'Reset hunk',
  --   -- },
  --
  --   ['<leader>ph'] = {
  --     function()
  --       require('gitsigns').preview_hunk()
  --     end,
  --     'Preview hunk',
  --   },
  --
  --   -- ['<leader>gb'] = {
  --   --   function()
  --   --     package.loaded.gitsigns.blame_line()
  --   --   end,
  --   --   'Blame line',
  --   -- },
  --
  --   ['<leader>td'] = {
  --     function()
  --       require('gitsigns').toggle_deleted()
  --     end,
  --     'Toggle deleted',
  --   },
  -- },
}

return M
