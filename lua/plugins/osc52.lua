return {
  "ojroques/nvim-osc52",
  event = "VeryLazy",
  config = function()
    local osc52 = require "osc52"

    osc52.setup {
      max_length = 0, -- без лимита (терминал сам ограничит)
      silent = true,
      trim = false,
    }

    -- Neovim clipboard provider: copy(lines, regtype) -> lines это ТАБЛИЦА
    local function copy(lines, _) osc52.copy(table.concat(lines, "\n")) end

    local function paste_plus() return { vim.fn.getreg "+", vim.fn.getregtype "+" } end

    local function paste_star() return { vim.fn.getreg "*", vim.fn.getregtype "*" } end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste_plus, ["*"] = paste_star },
    }

    -- Автокопирование в локальный буфер при обычном yank (без указания регистра)
    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = function()
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then osc52.copy_register '"' end
      end,
    })
  end,
}
