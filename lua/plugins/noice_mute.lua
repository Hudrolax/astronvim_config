return {
  {
    "folke/noice.nvim",
    priority = 1000,
    opts = function(_, opts)
      opts = opts or {}
      opts.cmdline = { view = "cmdline" }
      -- выключаем LSP-UI от Noice, чтобы не было "overwritten" и лишних баннеров
      opts.lsp = vim.tbl_deep_extend("force", opts.lsp or {}, {
        progress = { enabled = false },
        message = { enabled = false }, -- главное: Noice не будет показывать LSP-сообщения
        hover = { enabled = false }, -- пусть работает стандартный hover
        signature = { enabled = false }, -- и стандартный signature help
      })

      -- на всякий случай: глушим любые всплывашки с "transport"/"Spawning"
      opts.routes = opts.routes or {}
      table.insert(opts.routes, {
        filter = {
          any = {
            { event = "lsp", find = "transport" },
            { event = "lsp", find = "Spawning" },
            { event = "notify", find = "transport" },
            { event = "notify", find = "Spawning" },
            { event = "msg_show", find = "transport" },
            { event = "msg_show", find = "Spawning" },
          },
        },
        opts = { skip = true },
      })

      return opts
    end,
  },
  {
    "rcarriga/nvim-notify",
    optional = true,
    opts = { level = vim.log.levels.ERROR }, -- чтобы WARN от notify не всплывали
  },
}
