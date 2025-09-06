return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local nls = require "null-ls"
    opts.sources = opts.sources or {}

    -- убираем sqlfluff (линт/формат), если где-то добавлен
    opts.sources = vim.tbl_filter(function(src)
      return not (src and (src.name == "sqlfluff" or src._opts and src._opts.command == "sqlfluff"))
    end, opts.sources)

    -- форматтер: postgresql, ширина таба = 4 (чтобы не было LT02)
    table.insert(opts.sources, nls.builtins.formatting.sql_formatter.with({
      extra_args = { "--language", "postgresql", "--tab-width", "4" },
    }))
  end,
}
