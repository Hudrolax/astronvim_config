return {
  "gemini-local-module",
  dir = "~/.config/nvim/lua/gemini",  -- локальный модуль
  keys = {
    { "<D-M-n>", function() require("gemini").toggle() end,
      mode = { "n", "t" }, desc = "Toggle Gemini panel" },

    { "<D-M-т>", function() require("gemini").toggle() end,
      mode = { "n", "t" }, desc = "Toggle Gemini panel" },

    { "<leader>ag", function() require("gemini").toggle() end,
      mode = { "n", "t" }, desc = "Toggle Gemini panel" },
  },
}
