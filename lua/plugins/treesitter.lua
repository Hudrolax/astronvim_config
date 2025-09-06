-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/treesitter.lua
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = opts.ensure_installed or {}
    local extra = {
      "lua", "python", "javascript", "typescript", "tsx",
      "json", "yaml", "dockerfile", "sql", "css", "c", "cpp", "markdown", "markdown_inline",
    }
    for _, lang in ipairs(extra) do
      if not vim.tbl_contains(opts.ensure_installed, lang) then
        table.insert(opts.ensure_installed, lang)
      end
    end
    return opts
  end,
}
