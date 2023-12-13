local lspconfig = require 'lspconfig'
local M = require 'plugins.configs.lsp.lspconfig'

local cwd = vim.fn.getcwd(-1, -1)
if cwd ~= nil then
  if string.sub(cwd, -4) then
    require('neodev').setup {}
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lspconfig['html'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
}

lspconfig['yamlls'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
}

lspconfig['htmx'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
}

lspconfig['emmet_language_server'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
  filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
}

lspconfig['cssls'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
}

lspconfig['bashls'].setup {
  filetypes = { 'bash', 'sh', 'zsh', 'zshrc' },
  capabilities = capabilities,
  on_attach = M.on_attach,
  root_dir = function()
    return vim.loop.cwd()
  end,
}

lspconfig['jsonls'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
}

lspconfig['eslint'].setup {
  capabilities = capabilities,
  on_attach = M.on_attach,
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
  on_attach = M.on_attach,
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
    M.on_attach(client, bufnr)

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

local api = require 'typescript-tools.api'
require('typescript-tools').setup {
  on_attach = M.on_attach,
  settings = {
    tsserver_plugins = {
      '@styled/typescript-styled-plugin',
    },
    tsserver_file_preferences = {
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
  handlers = {
    ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 80001 },
  },
  vim.keymap.set('n', 'fi', '<cmd> TSToolsOrganizeImports<CR>', { desc = 'Organize imports' }),
}
