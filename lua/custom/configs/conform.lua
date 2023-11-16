local opts = {
  quiet = true,
  formatters_by_ft = {
    lua = { 'stylua' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    json = { 'pretter' },
    html = { 'prettier' },
    css = { 'prettier' },
    markdown = { 'prettier' },
    yamll = { 'prettier' },
    sh = { 'shfmt' },
  },
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match '/node_modules/' then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true, async = true }
  end,
  format_after_save = { lsp_fallback = true },
}

return opts
