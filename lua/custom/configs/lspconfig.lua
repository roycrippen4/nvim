local on_attach = function(client, bufnr)
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

  nmap('<C-k>', function()
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
  nmap('<leader>lD', toggle_diagnostics, 'Open diagnostic message')

  nmap('<leader>lf', function()
    vim.diagnostic.open_float()
  end, 'Open floating diagnostic message')

  nmap('<Leader>lh', function()
    vim.lsp.inlay_hint(bufnr)
  end, 'Toggle Inlay Hints')

  nmap('<leader>lr', function()
    vim.lsp.buf.rename()
  end, 'Rename')

  nmap('<leader>la', function()
    vim.lsp.buf.code_action()
  end, 'Code Action')

  vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
      if client.name == 'typescript-tools' then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end,
  })

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require('which-key').register {
  ['<leader>a'] = { name = 'Autosave', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = 'Debug', _ = 'which_key_ignore' },
  ['<leader>ds'] = { name = 'Step', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = 'LSP', _ = 'which_key_ignore' },
  ['<leader><leader>'] = { name = 'Format', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = 'Lookup Keymaps', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = 'Trouble', _ = 'which_key_ignore' },
  ['<leader>z'] = { name = 'Zen', _ = 'which_key_ignore' },
}

require('mason').setup()
require('mason-lspconfig').setup()
require('neodev').setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require 'lspconfig'

lspconfig['html'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig['htmx'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig['emmet_language_server'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
}

lspconfig['cssls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig['jsonls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig['eslint'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    workingDirectory = {
      mode = 'auto',
    },
    rulesCustomizations = {
      {
        rule = 'no-unused-vars',
        severity = 'off',
      },
      {
        rule = '@typescript-eslint/no-unused-vars',
        severity = 'off',
      },
    },
  },
}

lspconfig['lua_ls'].setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}

lspconfig['svelte'].setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.js', '*.ts' },
      callback = function(ctx)
        if client.name == 'svelte' then
          client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.file })
        end
      end,
    })
  end,
}

require('typescript-tools').setup {
  on_attach = on_attach,
  settings = {
    tsserver_plugins = {
      '@styled/typescript-styled-plugin',
    },
    tsserver_file_preferences = {
      -- Inlay Hints
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      jsxAttributeCompletionStyle = 'auto',
    },
  },
}
