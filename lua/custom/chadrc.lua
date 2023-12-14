local M = {}

local sep_color = '#454951'

M.ui = {
  hl_add = {
    NvimTreeBookmark = { fg = { 'red', -10 } },
    NvimTreeBookmarkHL = {
      fg = { 'red', -10 },
    },
    NvimTreeOpenedFile = {
      fg = { 'yellow', -10 },
    },
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
    FloatBorder = {
      bg = 'black',
    },
    TblineFill = {
      underline = true,
      bg = 'darker_black',
      sp = sep_color,
    },
    TbLineBufOn = {
      fg = { 'yellow', -20 },
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
    },
  },
}

-- M.plugins = 'custom.plugins'

return M
