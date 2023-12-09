local M = {}

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

M.trouble = {
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

M.general = {
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
  },
}

return M
