-- lua/plugins/codecompanion.lua
---@type LazySpec
return {
  "olimorris/codecompanion.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat (toggle)" },
    {
      "<leader>ae",
      function()
        vim.ui.input({ prompt = "Inline edit (selection): " }, function(inp)
          if inp and #inp > 0 then vim.cmd("'<,'>CodeCompanion " .. inp) end
        end)
      end,
      mode = { "x" },
      desc = "AI Edit selection (prompt)",
    },
    { "<leader>aF", ":'<,'>CodeCompanion /fix<cr>", mode = { "x" }, desc = "AI Fix selection (/fix)" },
  },

  opts = {
    adapters = {
      http = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = { api_key = "OPENAI_API_KEY" }, -- берём ключ из окружения
            api_base = "https://hudnet2v.hopto.org:8443/openai/",
            schema = { model = { default = "gpt-5-mini" } },
          })
        end,
      },
    },

    strategies = {
      chat = {
        adapter = "openai",
        opts = {
          system_prompt = function()
            return [[
Ты — помощник-программист в AstroNvim (CodeCompanion).
Всегда отвечай на русском языке, кратко и по делу.
Если приводишь код, показывай полный валидный блок с подсветкой синтаксиса
(```lua, ```python и т. д.). Делай переносы строк примерно каждые 80–100 символов.
Если вопрос не связан с программированием — всё равно отвечай по-русски.
            ]]
          end,
        },
      },
      inline = { adapter = "openai" },
    },

    display = {
      chat = {
        window = {
          layout = "vertical",
          position = "right",
          width = 0.45,
          full_height = true,
          opts = {
            wrap = true,
            linebreak = true,
            breakindent = true,
            number = false,
            relativenumber = false,
            signcolumn = "no",
          },
        },
      },
      diff = { enabled = true },
    },

    opts = { log_level = "WARN" },
  },
}
