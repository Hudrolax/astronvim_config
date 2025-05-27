return {
  "numToStr/Comment.nvim",
  dependencies = {             -- ➜ контекстный commentstring
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  opts = function(_, opts)      -- opts приходит из AstroNvim
    -- ⬇️ добавляем pre_hook, не трогая остальное
    opts.pre_hook =
      require("ts_context_commentstring.integrations.comment_nvim")
      .create_pre_hook()
    return opts
  end,
}
