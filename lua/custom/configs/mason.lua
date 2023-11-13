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

require('mason-nvim-dap').setup {
  handlers = {
    function(config)
      require('mason-nvim-dap').default_setup(config)
    end,
    chrome = function(config)
      local dap = require 'dap'
      dap.configurations = {
        {
          name = 'Debug with Chrome',
          type = 'chrome',
          requres = 'launch',
          reAttach = true,
          url = 'http://localhost:8080',
          webRoot = '${workspaceFolder}',
        },
      }
      require('mason-nvim-dap').default_setup(config)
    end,
  },
}
