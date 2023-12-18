local M = {}
--   󰈈       󱡠 󰴍       
local command_icon = '  '
local normal_icon = '  '
local insert_icon = '  '
local select_icon = '  '
local replace_icon = '  '
local confirm_icon = '❔ '

M.modes = {
  ['n'] = { 'NORMAL', 'St_NormalMode' },
  ['no'] = { 'NORMAL (no)', 'St_NormalMode' },
  ['nov'] = { 'NORMAL (nov)', 'St_NormalMode' },
  ['noV'] = { 'NORMAL (noV)', 'St_NormalMode' },
  ['noCTRL-V'] = { 'NORMAL', 'St_NormalMode' },
  ['niI'] = { 'NORMAL i', 'St_NormalMode' },
  ['niR'] = { 'NORMAL r', 'St_NormalMode' },
  ['niV'] = { 'NORMAL v', 'St_NormalMode' },
  ['nt'] = { 'NTERMINAL', 'St_NTerminalMode' },
  ['ntT'] = { 'NTERMINAL (ntT)', 'St_NTerminalMode' },

  ['v'] = { 'VISUAL', 'St_VisualMode' },
  ['vs'] = { 'V-CHAR (Ctrl O)', 'St_VisualMode' },
  ['V'] = { 'V-LINE', 'St_VisualMode' },
  ['Vs'] = { 'V-LINE', 'St_VisualMode' },
  [''] = { 'V-BLOCK', 'St_VisualMode' },

  ['i'] = { 'INSERT', 'St_InsertMode' },
  ['ic'] = { 'INSERT (completion)', 'St_InsertMode' },
  ['ix'] = { 'INSERT completion', 'St_InsertMode' },

  ['t'] = { 'TERMINAL', 'St_TerminalMode' },

  ['R'] = { 'REPLACE', 'St_ReplaceMode' },
  ['Rc'] = { 'REPLACE (Rc)', 'St_ReplaceMode' },
  ['Rx'] = { 'REPLACEa (Rx)', 'St_ReplaceMode' },
  ['Rv'] = { 'V-REPLACE', 'St_ReplaceMode' },
  ['Rvc'] = { 'V-REPLACE (Rvc)', 'St_ReplaceMode' },
  ['Rvx'] = { 'V-REPLACE (Rvx)', 'St_ReplaceMode' },

  ['s'] = { 'SELECT', 'St_SelectMode' },
  ['S'] = { 'S-LINE', 'St_SelectMode' },
  [''] = { 'S-BLOCK', 'St_SelectMode' },
  ['c'] = { 'COMMAND', 'St_CommandMode' },
  ['cv'] = { 'COMMAND', 'St_CommandMode' },
  ['ce'] = { 'COMMAND', 'St_CommandMode' },
  ['r'] = { 'PROMPT', 'St_ConfirmMode' },
  ['rm'] = { 'MORE', 'St_ConfirmMode' },
  ['r?'] = { 'CONFIRM', 'St_ConfirmMode' },
  ['x'] = { 'CONFIRM', 'St_ConfirmMode' },
  ['!'] = { 'SHELL', 'St_TerminalMode' },
}

M.module = function()
  --    local st_modules = require('nvchad.statusline.vscode_colored')
  --    local modes = st_modules.modes

  -- Normal
  M.modes['n'][3] = normal_icon
  M.modes['no'][3] = normal_icon
  M.modes['nov'][3] = normal_icon
  M.modes['noV'][3] = normal_icon
  M.modes['noCTRL-V'][3] = normal_icon
  M.modes['niI'][3] = normal_icon
  M.modes['niR'][3] = normal_icon
  M.modes['niV'][3] = normal_icon
  M.modes['nt'][3] = normal_icon
  M.modes['ntT'][3] = normal_icon

  -- Visual
  M.modes['v'][3] = '  '
  M.modes['vs'][3] = ' 󱡠 '
  M.modes['V'][3] = '  '
  M.modes['Vs'][3] = '  '
  M.modes[''][3] = ' 󰣟 '

  -- Insert
  M.modes['i'][3] = insert_icon
  M.modes['ic'] = insert_icon
  M.modes['ix'] = insert_icon

  -- Terminal   
  M.modes['t'][3] = '  '

  -- Replace
  M.modes['R'][3] = replace_icon
  M.modes['Rc'][3] = replace_icon
  M.modes['Rx'][3] = replace_icon
  M.modes['Rv'][3] = replace_icon
  M.modes['Rvc'][3] = replace_icon
  M.modes['Rvx'][3] = replace_icon

  -- Select
  M.modes['s'][3] = select_icon
  M.modes['S'][3] = select_icon
  M.modes[''][3] = select_icon

  -- Command
  M.modes['c'][3] = command_icon
  M.modes['cv'][3] = command_icon
  M.modes['ce'][3] = command_icon

  -- Confirm
  M.modes['r'][3] = confirm_icon
  M.modes['rm'][3] = confirm_icon
  M.modes['r?'][3] = confirm_icon
  M.modes['x'][3] = confirm_icon

  -- Shell
  M.modes['!'][3] = '  '

  local m = vim.api.nvim_get_mode().mode
  local current_mode = '%#' .. M.modes[m][2] .. '#' .. (M.modes[m][3] or '  ') .. M.modes[m][1] .. ' '
  local mode_sep1 = '%#' .. M.modes[m][2] .. 'Sep' .. '#' .. ''
  return current_mode .. mode_sep1 .. '%#ST_EmptySpace#' .. ''
end

return M
