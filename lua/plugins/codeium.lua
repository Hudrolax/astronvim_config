return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- 1. Отключаем стандартные клавиши из картинки
    vim.g.codeium_disable_bindings = 1

    -- Ctrl+y чтобы принять (как в coc.nvim или стандартном nvim)
    vim.keymap.set("i", "<C-y>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-н>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
    -- листать варианты впред
    vim.keymap.set(
      "i",
      "<C-k>",
      function() return vim.fn["codeium#CycleCompletions"](1) end,
      { expr = true, silent = true }
    )
    vim.keymap.set(
      "i",
      "<C-л>",
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
    vim.keymap.set(
      "i",
      "<C-о>",
      function() return vim.fn["codeium#CycleCompletions"](-1) end,
      { expr = true, silent = true }
    )

    -- Ctrl+k чтобы принять только слово (частичное принятие)
    vim.keymap.set(
      "i",
      "<C-l>",
      function() return vim.fn["codeium#AcceptNextWord"]() end,
      { expr = true, silent = true }
    )
    vim.keymap.set(
      "i",
      "<C-д>",
      function() return vim.fn["codeium#AcceptNextWord"]() end,
      { expr = true, silent = true }
    )

    -- Принудительный вызов (если вдруг нужно)
    vim.keymap.set("i", "<C-h>", function() return vim.fn["codeium#Complete"]() end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-р>", function() return vim.fn["codeium#Complete"]() end, { expr = true, silent = true })
  end,
}
