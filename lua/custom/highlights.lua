local M = {}

local sep_color = '#454951'

M.add = {
  RainbowDelimiterRed = { fg = 'red' },
  RainbowDelimiterYellow = { fg = 'yellow' },
  RainbowDelimiterBlue = { fg = 'blue' },
  RainbowDelimiterOrange = { fg = 'orange' },
  RainbowDelimiterGreen = { fg = 'green' },
  RainbowDelimiterViolet = { fg = 'purple' },
  RainbowDelimiterCyan = { fg = 'cyan' },

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
  WinBar = {
    fg = 'red',
    bg = 'black',
  },
  WinBarNC = {
    bg = 'black',
  },
}

M.override = {
  FloatBorder = {
    bg = 'black',
  },
  CmpDocBorder = {
    fg = { 'blue', -25 },
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
}

return M
