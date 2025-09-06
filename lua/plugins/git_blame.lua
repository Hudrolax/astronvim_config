-- lua/plugins/git_blame.lua
return {
  "f-person/git-blame.nvim",
  -- ВАЖНО: глобалки задаём в init, чтобы сработало до загрузки плагина
  init = function()
    vim.g.gitblame_enabled = 0 -- выключен по умолчанию
    -- (необязательно) можно настроить формат/дату, если когда-то включишь:
    -- vim.g.gitblame_message_template = " <author> • <date> • <summary>"
    -- vim.g.gitblame_date_format = "%Y-%m-%d %H:%M"
  end,
  keys = {
    { "<leader>gb", "<cmd>GitBlameToggle<CR>", desc = "Toggle git blame" },
  },
}
