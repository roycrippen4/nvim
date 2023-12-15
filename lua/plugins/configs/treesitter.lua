local options = {
  ensure_installed = { 'lua' },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  autotag = {
    enable = true,
  },

  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 1000,
    query = {
      'rainbow-parens',
      html = 'rainbow-tags',
      javascript = 'rainbow-tags-react',
      tsx = 'rainbow-tags',
    },
  },
}

return options
