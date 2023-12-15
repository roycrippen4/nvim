local M = {}

M.on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gr', function()
    require('telescope.builtin').lsp_references()
  end, 'Goto References')

  nmap('gi', function()
    require('telescope.builtin').lsp_implementations()
  end, 'Goto Implementation')

  nmap('gd', function()
    require('telescope.builtin').lsp_definitions()
  end, 'Goto Definition')

  nmap('T', function()
    require('telescope.builtin').lsp_type_definitions()
  end, 'Goto Type Definition')

  -- nmap('K', function()
  --   vim.lsp.buf.hover()
  -- end, 'Hover')

  nmap('K', '<cmd>Lspsaga hover_doc<CR>', 'LSP Hover')

  nmap('<C-S-K>', function()
    vim.lsp.buf.signature_help()
  end, 'Signature Documentation')

  nmap('[d', function()
    vim.diagnostic.goto_prev()
  end, 'Go to previous diagnostic message')

  nmap(']d', function()
    vim.diagnostic.goto_next()
  end, 'Go to next diagnostic message')

  nmap('<leader>ld', function()
    vim.diagnostic.setloclist()
  end, 'Open diagnostic message')

  local diagnostic_status = true
  local toggle_diagnostics = function()
    diagnostic_status = not diagnostic_status
    if diagnostic_status then
      vim.api.nvim_echo({ { 'Show diagnostics' } }, false, {})
      vim.diagnostic.enable()
    else
      vim.api.nvim_echo({ { 'Hide diagnostics' } }, false, {})
      vim.diagnostic.disable()
    end
  end
  nmap('<leader>lD', toggle_diagnostics, 'Toggle Diagnostics')

  nmap('<leader>lf', function()
    vim.diagnostic.open_float()
  end, 'Open floating diagnostic message')

  nmap('<leader>rn', function()
    vim.lsp.buf.rename()
  end, 'Rename')

  nmap('<leader>la', function()
    vim.lsp.buf.code_action()
  end, 'Code Action')
end

require('which-key').register({
  ['<leader>a'] = { name = 'Autosave', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = 'Debug', _ = 'which_key_ignore' },
  ['<leader>ds'] = { name = 'Step', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
  -- markdown preview
  ['<leader>m'] = { name = 'Markdown Preview', _ = 'which_key_ignore' },
  ['<leader>mt'] = { name = 'Toggle Markdown Preview', _ = 'which_key_ignore' },
  ['<leader>mp'] = { name = 'Start Markdown Preview', _ = 'which_key_ignore' },
  ['<leader>ms'] = { name = 'Stop Markdown Preview', _ = 'which_key_ignore' },

  ['<leader>t'] = { name = 'Trouble', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = 'Lookup Keymaps', _ = 'which_key_ignore' },
  ['<leader>z'] = { name = 'Zen', _ = 'which_key_ignore' },
  ['<Leader>dc'] = { name = 'Continue', _ = 'which_key_ignore' },
  ['<Leader>dsv'] = { name = 'Step over', _ = 'which_key_ignore' },
  ['<Leader>dsi'] = { name = 'Step into', _ = 'which_key_ignore' },
  ['<Leader>dso'] = { name = 'Step out', _ = 'which_key_ignore' },
  ['<Leader>db'] = { name = 'Toggle breakpoint', _ = 'which_key_ignore' },
  ['<Leader>dB'] = { name = 'Set breakpoint', _ = 'which_key_ignore' },
  ['<Leader>dr'] = { name = 'Repl Open', _ = 'which_key_ignore' },
  ['<Leader>dl'] = { name = 'Run Last', _ = 'which_key_ignore' },
  ['<Leader>dh'] = { name = 'Hover', _ = 'which_key_ignore' },
  ['<Leader>dv'] = { name = 'Preview', _ = 'which_key_ignore' },
  ['<Leader>df'] = { name = 'Show frames', _ = 'which_key_ignore' },
  ['<Leader>ds'] = { name = 'Show scopes', _ = 'which_key_ignore' },
  ['<Leader>dt'] = { name = 'Toggle Debug UI', _ = 'which_key_ignore' },
  ['<Leader>dp'] = { name = 'Toggle Log Point', _ = 'which_key_ignore' },
})

require('mason').setup()
require('mason-lspconfig').setup()

local cwd = vim.fn.getcwd(-1, -1)
if cwd ~= nil then
  if string.sub(cwd, -4) then
    require('neodev').setup({})
  end
end

vim.lsp.protocol.CompletionItemKind = {
  '   (Text) ',
  '   (Method)',
  '   (Function)',
  '   (Constructor)',
  ' ﴲ  (Field)',
  '[] (Variable)',
  '   (Class)',
  ' ﰮ  (Interface)',
  '   (Module)',
  ' 襁 (Property)',
  '   (Unit)',
  '   (Value)',
  ' 練 (Enum)',
  '   (Keyword)',
  '   (Snippet)',
  '   (Color)',
  '   (File)',
  '   (Reference)',
  '   (Folder)',
  '   (EnumMember)',
  ' ﲀ  (Constant)',
  ' ﳤ  (Struct)',
  '   (Event)',
  '   (Operator)',
  '   (TypeParameter)',
}

return M
