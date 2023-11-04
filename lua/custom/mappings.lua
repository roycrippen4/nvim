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

M.general = {
  n = {
    [';'] = { ':', 'enter command mode', opts = { nowait = true } },
    ['.'] = { '<C-]>', 'rebind tree cd', opts = {} },
    ['L'] = { ':bnext<CR>', 'Next Buffer', opts = { nowait = true } },
    ['H'] = { ':bprevious<CR>', 'Previous Buffer', opts = { nowait = true } },
    ['<Leader>dz'] = { ':ZenMode<CR>', 'Zen', opts = { nowait = true } },
    ['<leader>so'] = { ':source<CR>', 'Source Config', opts = {} },
  },
  v = {
    ['<Leader>r'] = { ':s/', 'Substitute' },
  },
}

return M
