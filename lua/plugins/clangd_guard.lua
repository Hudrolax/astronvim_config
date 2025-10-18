-- lua/plugins/clangd_guard.lua
-- Не даём clangd стартовать в «пустых» папках.
-- Запуск разрешён только если уже есть compile_commands.json (в корне или выше).
-- Это убирает падения "Client clangd quit with exit code 1" до генерации базы.

---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  priority = 850, -- раньше прочих lsp-настроек
  config = function()
    local lspconfig = require "lspconfig"
    local util = require "lspconfig.util"
    local uv = vim.loop

    local function has_compiledb(path) return uv.fs_stat(path .. "/compile_commands.json") ~= nil end

    local function guarded_root(fname)
      -- Ищем ближайший каталог с compile_commands.json вверх по дереву
      return util.search_ancestors(fname, function(path)
        if has_compiledb(path) then return path end
      end)
    end

    lspconfig.clangd.setup {
      root_dir = guarded_root, -- если базы нет — clangd не стартует
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      -- Остальную конфигурацию (включая --compile-commands-dir) настроит pio_clangd.lua
    }
  end,
}
