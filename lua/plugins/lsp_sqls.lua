return {
  "AstroNvim/astrolsp",
  opts = {
    servers = { "sqls" },
    config = {
      sqls = {
        settings = {
          sqls = {
            lint = { enable = false }, -- без коннекта линт не нужен
          },
        },
        -- Глушим всплывашки про отсутствие подключения
        handlers = {
          ["window/showMessage"] = function(_, result, ctx, config)
            local msg = type(result and result.message) == "string" and result.message or ""
            if msg:lower():find("no database connection") then return end
            return vim.lsp.handlers["window/showMessage"](_, result, ctx, config)
          end,
        },
      },
    },
  },
}
