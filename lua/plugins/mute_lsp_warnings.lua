return {
  "rcarriga/nvim-notify",
  optional = true,
  config = function(_, opts)
    local orig = vim.notify
    vim.notify = function(msg, level, nopts)
      if type(msg) == "string" then
        -- сюда добавляй фильтры для сообщений, которые хочешь игнорировать
        if msg:find("registerCapability handler for workspace/didChangeConfiguration") then return end
        if msg:find("no database connection") then return end
        if msg:find("Cannot find request with id") then return end
      end
      return orig(msg, level, nopts)
    end
    if opts then require("notify").setup(opts) end
  end,
}
