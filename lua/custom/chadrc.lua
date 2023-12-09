local M = {}
-- 1b1f27

M.ui = {
  hl_override = {
    NvimTreeWinSeparator = {
      fg = '#31353d',
      -- bg = 'darker_black',
    },
    -- TabLine = {
    --   fg = 'yellow',
    --   bg = 'red',
    -- },
    -- TabLineFill = {
    --   fg = 'yellow',
    --   bg = 'red',
    -- },
    -- TabLineBufOnClose = {
    --   fg = 'yellow',
    --   bg = 'red',
    -- },
    -- TabLineBufOnOpen = {
    --   fg = 'yellow',
    --   bg = 'red',
    -- },
    -- TabLineSel = {
    --   fg = 'green',
    --   bg = 'red',
    -- },
    --   TblineFill = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TblineTabNewBtn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TblineTabOn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineTabOn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineTabOff = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineTabCloseBtn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOnModified = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineThemeToggleBtn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOffModified = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TblineBufOn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOn = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufClose = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOnClose = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOffClose = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
    --   TbLineBufOff = {
    --     fg = 'yellow',
    --     bg = 'red',
    --   },
  },
}

M.overrides = require 'custom.configs.overrides'

M.plugins = 'custom.plugins'

M.mappings = require 'custom.mappings'

return M
