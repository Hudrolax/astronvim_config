return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  config = function()
    local osc52 = require("osc52")
    osc52.setup({
      max_length = 0,  -- не ограничивать размер (терминал может ограничить сам)
      silent = true,
      trim = false,
    })

    -- Автокопирование в локальный буфер macOS при любом yank в НЕуказанный регистр
    local function copy_on_yank()
      if vim.v.event.operator == "y" and vim.v.event.regname == "" then
        osc52.copy_register('"')  -- берём содержимое дефолтного регистра
      end
    end
    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy_on_yank })

    -- Дополнительно: чтобы :y+ и т.п. тоже шло через OSC52
    local function paste()
      return { vim.fn.getreg(""), vim.fn.getregtype("") }
    end
    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = osc52.copy, ["*"] = osc52.copy },
      paste = { ["+"] = paste,     ["*"] = paste     },
    }
  end,
}
