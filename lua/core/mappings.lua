-- n, v, i, t = mode names

local M = {}

M.harpoon = {
  plugin = true,
  n = {
    ['<C-a>'] = {
      function()
        require('harpoon'):list():append()
      end,
    },
    ['<C-e>'] = {
      function()
        require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
      end,
    },
    ['<C-1>'] = {
      function()
        require('harpoon'):list():select(1)
      end,
    },
    ['<C-2>'] = {
      function()
        require('harpoon'):list():select(2)
      end,
    },
    ['<C-3>'] = {
      function()
        require('harpoon'):list():select(3)
      end,
    },
    ['<C-4>'] = {
      function()
        require('harpoon'):list():select(4)
      end,
    },
    ['<C-5>'] = {
      function()
        require('harpoon'):list():select(5)
      end,
    },
    ['<C-6>'] = {
      function()
        require('harpoon'):list():select(6)
      end,
    },
    ['<C-7>'] = {
      function()
        require('harpoon'):list():select(7)
      end,
    },
    ['<C-8>'] = {
      function()
        require('harpoon'):list():select(8)
      end,
    },
    ['<C-9>'] = {
      function()
        require('harpoon'):list():select(9)
      end,
    },
    ['<C-0>'] = {
      function()
        require('harpoon'):list():select(0)
      end,
    },
  },
}

M.disabled = {
  n = {
    ['<leader>/'] = '',
    ['<leader>b'] = '',
    ['<leader>D'] = '',
    ['<leader>h'] = '',
    ['<leader>n'] = '',
    ['<leader>q'] = '',
    ['<leader>v'] = '',
  },
}

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
    ['<leader><leader>'] = {
      function()
        print(vim.fn.expand '%:p')
      end,
      opts = {},
    },
    ['<S-CR>'] = { 'o<Esc>k', 'New line above', opts = { silent = true } },
    ['<C-CR>'] = { 'O<Esc>j', 'New line above', opts = { silent = true } },
    [';'] = { ':', 'enter command mode', opts = { nowait = true } },
    ['yil'] = { '^y$', 'yank in line', opts = { noremap = true } },
    ['<Leader>z'] = { ':ZenMode<CR>', 'Zen', opts = { nowait = true } },
    ['<Leader>v'] = { '<C-w>v', 'Vertical split', opts = { nowait = true } },
    ['<Leader>h'] = { '<C-w>s', 'Horizontal split', opts = { nowait = true } },
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

    -- toggle lsp inlay hints
    ['<Leader>lh'] = {
      function()
        vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
        print('inlay hints: ' .. tostring(vim.lsp.inlay_hint.is_enabled()))
      end,
      'Toggle lsp inlay hints',
    },

    ['j'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },
    ['k'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Up>'] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', 'Move up', opts = { expr = true } },
    ['<Down>'] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', 'Move down', opts = { expr = true } },

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

-- M.dap = {
--   plugin = true,
--   n = {
--     ['<Leader>dc'] = {
--       function()
--         require('dap').continue()
--       end,
--       'Continue',
--     },
--     ['<Leader>dsv'] = {
--       function()
--         require('dap').step_over()
--       end,
--       'Step into',
--     },
--     ['<Leader>dsi'] = {
--       function()
--         require('dap').step_into()
--       end,
--       'Step into',
--     },
--     ['<Leader>dso'] = {
--       function()
--         require('dap').step_out()
--       end,
--       'Step out',
--     },
--     ['<Leader>db'] = {
--       function()
--         require('dap').toggle_breakpoint()
--       end,
--       'Toggle breakpoint',
--     },
--     ['<Leader>dB'] = {
--       function()
--         require('dap').set_breakpoint()
--       end,
--       'Set breakpoint',
--     },
--     ['<Leader>dp'] = {
--       function()
--         require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
--       end,
--     },
--     ['<Leader>dr'] = {
--       function()
--         require('dap').repl.open()
--       end,
--       'Repl open',
--     },
--     ['<Leader>dl'] = {
--       function()
--         require('dap').run_last()
--       end,
--       'Run Last',
--     },
--     ['<Leader>df'] = {
--       function()
--         local widgets = require 'dap.ui.widgets'
--         widgets.centered_float(widgets.frames)
--       end,
--       'Show frames',
--     },
--     ['<Leader>ds'] = {
--       function()
--         local widgets = require 'dap.ui.widgets'
--         widgets.centered_float(widgets.scopes)
--       end,
--       'Show scopes',
--     },
--   },
--   v = {
--     ['<Leader>dh'] = {
--       function()
--         require('dap.ui.widgets').hover()
--       end,
--       'Hover',
--     },
--     ['<Leader>dv'] = {
--       function()
--         require('dap.ui.widgets').preview()
--       end,
--       'Preview',
--     },
--   },
-- }

-- M.dap_ui = {
--   plugin = true,
--   n = {
--     ['<Leader>dt'] = {
--       function()
--         require('dapui').toggle()
--       end,
--       'Toggle dap ui',
--     },
--   },
-- }

M.trouble = {
  plugin = true,
  n = {
    ['<leader>tt'] = {
      function()
        require('trouble').toggle()
      end,
      'Trouble toggle',
    },

    ['<leader>td'] = {
      function()
        require('trouble').toggle 'workspace_diagnostics'
      end,
      'Trouble toggle workspace diagnostics',
    },

    ['<leader>tD'] = {
      function()
        require('trouble').toggle 'document_diagnostics'
      end,
      'Trouble toggle document diagnostics',
    },

    ['<leader>tf'] = {
      function()
        require('trouble').toggle 'quickfix'
      end,
      'Trouble toggle quickfix',
    },

    ['<leader>tl'] = {
      function()
        require('trouble').toggle 'loclist'
      end,
      'Trouble toggle local-list',
    },

    ['gR'] = {
      function()
        require('trouble').toggle 'lsp_references'
      end,
      'Goto Reference',
    },
  },
}

M.gitsigns = {}

return M
