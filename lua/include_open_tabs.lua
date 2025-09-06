-- lua/include_open_tabs.lua
local M = {}

function M.include_open_tabs()
  local output_file = "output.txt"
  local bufs = vim.api.nvim_list_bufs()
  local files = {}

  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" then
        files[name] = buf
      end
    end
  end

  local names = {}
  for name in pairs(files) do
    table.insert(names, name)
  end
  table.sort(names)

  local out = io.open(output_file, "w")
  if not out then
    print("Не удалось создать файл: " .. output_file)
    return
  end

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

vim.api.nvim_create_user_command("IncludeOpenTabs", M.include_open_tabs, {})

return M
