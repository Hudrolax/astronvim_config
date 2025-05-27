-- lua/include_open_tabs.lua
-- Плагин для AstroNvim: собирает все открытые буферы (вкладки) и записывает их содержимое в output.txt

local M = {}

function M.include_open_tabs()
  local output_file = "output.txt"
  -- Собираем все буферы
  local bufs = vim.api.nvim_list_bufs()
  local files = {}

  for _, buf in ipairs(bufs) do
    -- Проверяем, валиден ли буфер и отображается ли он в списке буферов
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        files[name] = buf
      end
    end
  end

  -- Сортируем имена файлов
  local names = {}
  for name in pairs(files) do
    table.insert(names, name)
  end
  table.sort(names)

  -- Открываем файл для записи
  local out = io.open(output_file, "w")
  if not out then
    print("Не удалось создать файл: " .. output_file)
    return
  end

  -- Записываем путь и содержимое каждого файла
  for _, name in ipairs(names) do
    local buf = files[name]
    out:write(name .. "\n")
    out:write('"""\n')
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    out:write(table.concat(lines, "\n"))
    out:write("\n\"\"\"\n\n")
  end

  out:close()
  print("Файл успешно создан: " .. output_file)
end

-- Регистрируем команду :IncludeOpenTabs
vim.api.nvim_create_user_command("IncludeOpenTabs", M.include_open_tabs, {})

return M
