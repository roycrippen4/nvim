return {
  indent = {
    char = '▎',
  },
  scope = {
    include = {
      node_type = {
        lua = {
          'arguments',
          'function_call',
          'identifier',
          'return_statement',
          'string_content',
          'table_constructor',
        },
        typescript = {
          'arguments',
          'call_expression',
          'expression_statement',
          'for_in_statement',
          'if_statement',
          'import_statement',
          'interface_declaration',
          'object',
          'return_statement',
          'statement_block',
          'try_statement',
          'type_alias_delcaration',
        },
      },
    },
  },
  exclude = {
    buftypes = { 'terminal' },
    filetypes = {
      '',
      'NvimTree',
      'TelescopePrompt',
      'TelescopeResults',
      'help',
      'lazy',
      'lspinfo',
      'mason',
      'nvcheatsheet',
      'nvdash',
      'terminal',
    },
  },
}
