return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- 1. Отключаем стандартные клавиши из картинки
    vim.g.codeium_disable_bindings = 1

    -- Ctrl+l чтобы принять
    vim.keymap.set("i", "<C-l>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<right>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })

    -- листать варианты вперед
    vim.keymap.set(
      "i",
      "<C-k>",
      function() return vim.fn["codeium#CycleCompletions"](1) end,
      { expr = true, silent = true }
    )

    -- листать варианты назад
    vim.keymap.set(
      "i",
      "<C-j>",
      function() return vim.fn["codeium#CycleCompletions"](-1) end,
      { expr = true, silent = true }
    )
  end,
}
