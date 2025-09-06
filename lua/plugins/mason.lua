-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/mason.lua
---@type LazySpec
return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    local ensure = {
      -- LSP
      "pyright",
      "typescript-language-server",
      "lua-language-server",
      "dockerfile-language-server",
      "yaml-language-server",
      "clangd",
      "arduino-language-server",
      "css-lsp",
      "sqls",
      "prettierd",
      "prettier",
      "eslint_d",
      "black",
      "isort",
      "stylua",
      "clang-format",
      "shfmt",
      "sql-formatter",
      "djlint",
      "ruff",
    }
    for _, p in ipairs(ensure) do
      if not vim.tbl_contains(opts.ensure_installed, p) then table.insert(opts.ensure_installed, p) end
    end
    return opts
  end,
}
