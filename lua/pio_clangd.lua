-- lua/pio_clangd.lua
-- Автонастройка clangd для проектов PlatformIO:
--  - ищет platformio.ini и активный env (default_envs или первый [env:*])
--  - гарантирует наличие compile_commands.json (pio run -t compiledb, если нужно)
--  - на лету настраивает clangd с --compile-commands-dir и корректным root_dir
--  - отключает arduino_language_server в PIO-проектах

local M = {}

local uv = vim.loop

local function exists(p) return uv.fs_stat(p) ~= nil end
local function mtime(p) local st = uv.fs_stat(p); return st and st.mtime.sec or 0 end
local function readlines(p) if not exists(p) then return nil end; return vim.fn.readfile(p) end

-- Найти активный env из platformio.ini (default_envs или первый [env:*])
local function pio_active_env(cwd)
  local ini = cwd .. "/platformio.ini"
  local lines = readlines(ini); if not lines then return nil end
  local envs, default_env = {}, nil
  for _, line in ipairs(lines) do
    local sec = line:match("^%s*%[env:([^%]]+)%]")
    if sec then table.insert(envs, vim.trim(sec)) end
    local k, v = line:match("^%s*([%w_]+)%s*=%s*(.+)%s*$")
    if k == "default_envs" and not default_env then
      local parts = vim.split(v, ",%s*")
      if #parts > 0 then default_env = vim.trim(parts[1]) end
    end
  end
  return default_env or envs[1]
end

-- PIO обычно кладёт compiledb в корень проекта; раньше встречалось и в .pio/build/<env>
local function pick_compiledb_dir(cwd, env)
  local root_db = cwd .. "/compile_commands.json"
  local old_db  = cwd .. "/.pio/build/" .. env .. "/compile_commands.json"
  if exists(root_db) then return cwd, root_db end
  if exists(old_db)  then return (cwd .. "/.pio/build/" .. env), old_db end
  return cwd, root_db -- ожидаем, что появится в корне
end

-- Сгенерировать compile_commands.json, если нужно; вызвать cb(dir) когда готово
local function ensure_compiledb(cwd, env, cb)
  local ini = cwd .. "/platformio.ini"
  local dir_now, db_now = pick_compiledb_dir(cwd, env)
  local need_generate = (not exists(db_now)) or (mtime(db_now) < mtime(ini))

  if need_generate then
    vim.notify("PlatformIO: generating compile_commands.json for [" .. env .. "] …", vim.log.levels.INFO)
    vim.fn.jobstart({ "pio", "run", "-t", "compiledb" }, {
      cwd = cwd,
      on_exit = function(_, code)
        vim.schedule(function()
          if code == 0 then
            local dir_ready, db_ready = pick_compiledb_dir(cwd, env)
            if exists(db_ready) then
              vim.notify("PlatformIO: compiledb ready (" .. env .. ")", vim.log.levels.INFO)
              if cb then cb(dir_ready) end
            else
              vim.notify("PlatformIO: compiledb not found after build (check PIO output)", vim.log.levels.ERROR)
            end
          else
            vim.notify("PlatformIO: failed to generate compiledb (exit " .. tostring(code) .. ")", vim.log.levels.ERROR)
          end
        end)
      end,
    })
    return dir_now, true
  end

  return dir_now, false
end

-- Применить новую команду к clangd и перезапустить клиентов
local function set_clangd_dir(dir)
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then return end
  local util = require "lspconfig.util"

  lspconfig.clangd.setup {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--compile-commands-dir=" .. dir,
      -- Чтобы clangd корректно понимал кросс-компиляторы (avr, xtensa, arm, riscv):
      "--query-driver=**",
    },
    -- фиксируем root в корне проекта (где platformio.ini/compiledb)
    root_dir = function(fname)
      return util.search_ancestors(fname, function(path)
        if exists(path .. "/compile_commands.json") or exists(path .. "/platformio.ini") then
          return path
        end
      end)
    end,
  }
  vim.cmd("LspRestart")
end

-- Отключить arduino_language_server, если он активен (для PIO он не нужен)
local function disable_arduino_ls_if_present()
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "arduino_language_server" then
      client.stop()
      vim.notify("Disabled arduino_language_server (PlatformIO project detected).", vim.log.levels.DEBUG)
    end
  end
end

local function try_setup_for_cwd(cwd)
  local ini = cwd .. "/platformio.ini"
  if not exists(ini) then return end
  local env = pio_active_env(cwd)
  if not env then return end

  disable_arduino_ls_if_present()

  local dir, started = ensure_compiledb(cwd, env, function(ready_dir)
    set_clangd_dir(ready_dir)
  end)

  -- До генерации базы clangd запускать не будем (см. guard), но сразу подготовим конфиг
  set_clangd_dir(dir)
  if started then
    vim.notify("clangd will attach after compiledb is ready (" .. env .. ")", vim.log.levels.WARN)
  end
end

function M.setup()
  -- Ручная команда (на всякий): :PioCompiledb
  vim.api.nvim_create_user_command("PioCompiledb", function()
    try_setup_for_cwd(vim.fn.getcwd())
  end, {})

  local group = vim.api.nvim_create_augroup("PioClangdAuto", { clear = true })

  -- При старте/смене директории/открытии C(++)-файлов — попытаться включить поддержку
  vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    group = group,
    callback = function() try_setup_for_cwd(vim.fn.getcwd()) end,
  })
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    pattern = { "*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hpp" },
    callback = function() try_setup_for_cwd(vim.fn.getcwd()) end,
  })
end

return M
