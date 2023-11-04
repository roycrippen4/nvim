require('zen-mode').setup {
  window = {
    backdrop = 0.93,
    width = 140,
    height = 1,
  },
  plugins = {
    options = {
      showcmd = false,
      enabled = true,
      laststatus = 0,
    },
    kitty = {
      enabled = true,
      font = '+3',
    },
    twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = true }, -- disables git signs
  },
}
