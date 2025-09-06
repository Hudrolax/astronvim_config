-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/none-ls.lua
---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    local null_ls = require "null-ls"
    opts.sources = opts.sources or {}

    local fmt = null_ls.builtins.formatting
    local dgn = null_ls.builtins.diagnostics

    -- Форматтеры с шириной 120
    local function with_args(builtin, args)
      local b = builtin
      b._opts = b._opts or {}
      b._opts.extra_args = args
      return b
    end

    -- JS/TS/CSS/JSON/YAML/Markdown via prettier/prettierd
    table.insert(opts.sources, with_args(fmt.prettier, { "--print-width", "120" }))
    if fmt.prettierd then
      table.insert(opts.sources, fmt.prettierd) -- prettierd сам подтянет локальный .prettierrc если есть
    end

    -- Python
    table.insert(opts.sources, with_args(fmt.black, { "--line-length", "120" }))
    table.insert(opts.sources, fmt.isort)

    -- Lua
    table.insert(opts.sources, with_args(fmt.stylua, { "--column-width", "120" }))

    -- C/C++/C/ObjC
    table.insert(opts.sources, with_args(fmt.clang_format, { "-style", "{BasedOnStyle: LLVM, ColumnLimit: 120}" }))

    -- Shell
    table.insert(opts.sources, with_args(fmt.shfmt, { "-i", "2", "-ci", "-bn", "-ln", "bash" }))

    -- SQL
    table.insert(opts.sources, with_args(fmt.sql_formatter, { "-l", "postgresql", "--config", "{ \"maxColumnLength\": 120 }" }))

    -- Dockerfile (lint)
    table.insert(opts.sources, dgn.hadolint)

    -- YAML/JSON/… (prettier уже покрывает)

    return opts
  end,
}
