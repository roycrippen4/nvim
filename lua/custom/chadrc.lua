local M = {}

local sep_color = '#454951'

M.cmp = {
  sources = {
    { name = 'nvim_lsp', trigger_characters = { '-' } },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lua' },
  },
  experimental = {
    ghost_text = true,
  },
}

M.ui = {
  hl_add = {
    NvimTreeTitle = {
      underline = true,
      fg = { 'yellow', -10 },
      bg = 'darker_black',
      sp = sep_color,
    },
    NvimTreeTitleSepOn = {
      underline = false,
      fg = sep_color,
      bg = 'black',
      sp = sep_color,
    },
    NvimTreeTitleSepOff = {
      underline = true,
      fg = sep_color,
      bg = 'darker_black',
      sp = sep_color,
    },
  },
  hl_override = {
    TblineFill = {
      underline = true,
      bg = 'darker_black',
      sp = sep_color,
    },
    TbLineBufOn = {
      fg = 'white',
    },
    TbLineBufOff = {
      underline = true,
      fg = 'grey',
      bg = 'darker_black',
      sp = sep_color,
    },
    TbLineBufOffModified = {
      bg = 'darker_black',
      underline = true,
      sp = sep_color,
    },
    TbLineBufOffClose = {
      underline = true,
      bg = 'darker_black',
      sp = sep_color,
    },
    NvimTreeWinSeparator = {
      fg = sep_color,
      bg = 'black',
    },
    Comment = {
      italic = true,
    },
    WinSeparator = {
      fg = sep_color,
      bg = 'black',
      -- sp = 'yellow',
      -- underline = true,
    },
  },
  tabufline = {
    icons = false,
    underline = true,
    overriden_modules = function(modules)
      modules[1] = vim.g.NvimTreeOverlayTitle
      modules[4] = ''
    end,
  },
  extended_integrations = {
    'rainbowdelimiters',
    'trouble',
    'todo',
  },
}

M.plugins = 'custom.plugins'

M.mappings = require 'custom.mappings'

return M
