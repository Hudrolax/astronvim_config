-- lua/include_files.lua
-- Генерирует файл output.txt с содержимым всех файлов по файлу include.txt с таким синтаксисом:
-- >>> include
-- ./app/alembic/env.py
-- ./app/api/**/*.py
-- ./app/db/**/*.py
-- ./app/domain/**/*.py
-- ./app/repositories/**/*.py
-- ./app/services/**/*.py
-- ./app/tests/**/*.py
-- ./proxy/Dockerfile
-- ./proxy/default.conf.tpl
-- ./proxy/run.sh
-- ./scripts/run.sh
-- ./.dockerignore
-- ./.gitignore
-- ./Dockerfile
-- ./docker-compose.yml
-- ./requirements.txt
-- ./requirements.dev.txt

-- lua/include_files.lua
local M = {}

function M.include_files()
  local input_file = "include.txt"
  local output_file = "output.txt"

  local patterns = {}
  local f = io.open(input_file, "r")
  if not f then
    print("Не удалось открыть входной файл: " .. input_file)
    return
  end

  -- Читаем строки из файла и игнорируем строки, начинающиеся с ">>>" или "#", а также пустые строки
  for line in f:lines() do
    if not line:match("^>>>") and not line:match("^#") and line:match("%S") then
      table.insert(patterns, line)
    end
  end
  f:close()

  local files_set = {}
  for _, pattern in ipairs(patterns) do
    local files = vim.fn.glob(pattern, false, true)
    for _, file in ipairs(files) do
      files_set[file] = true
    end
  end

  local all_files = {}
  for file, _ in pairs(files_set) do
    table.insert(all_files, file)
  end
  table.sort(all_files)

  local out = io.open(output_file, "w")
  if not out then
    print("Не удалось создать выходной файл: " .. output_file)
    return
  end

  for _, file in ipairs(all_files) do
    out:write(file .. "\n")
    out:write('"""\n')
    local f2 = io.open(file, "r")
    if f2 then
      local content = f2:read("*a")
      out:write(content)
      f2:close()
    else
      out:write("-- Не удалось открыть файл: " .. file .. "\n")
    end
    out:write('\n"""\n')
  end

  out:close()
  print("Файл успешно создан: " .. output_file)
end

vim.api.nvim_create_user_command("IncludeFiles", M.include_files, {})

return M
