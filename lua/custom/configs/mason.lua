local mason = require 'mason'
local mason_lspconfig = require 'mason-lspconfig'

mason.setup {
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
}

mason_lspconfig.setup {
  ensure_installed = {
    'lua_ls',

    'cssls',
    'html',

    'emmet_language_server',
    'jsonls',
    'eslint',

    'unocss',

    'bashls',
  },
  automatic_installation = true,
}
