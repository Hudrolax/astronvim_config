-- lua/plugins/pio_clangd.lua
-- Плагин-обёртка, чтобы Lazy загрузил наш модуль при старте Neovim.
---@type LazySpec
return {
  "nvim-lua/plenary.nvim", -- просто якорь; plenary всё равно обычно стоит
  lazy = false,            -- запускать сразу
  priority = 1000,         -- пораньше, чтобы успеть до attach clangd
  config = function()
    require("pio_clangd").setup()
  end,
}
