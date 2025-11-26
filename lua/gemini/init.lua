local M = {}

local win = nil       -- окно
local buf = nil       -- буфер
local term = nil      -- id терминала
local float = true    -- режим: false = split, true = float (по умолчанию float)

-- запускаем gemini CLI единожды
local function ensure_terminal()
  if term and vim.api.nvim_buf_is_valid(buf) then
    return
  end

  buf = vim.api.nvim_create_buf(false, true)
  -- привязываем job к скрытому буферу, не трогая текущий
  vim.api.nvim_buf_call(buf, function()
    term = vim.fn.termopen("gemini", {
      on_exit = function()
        term = nil
        buf = nil
      end,
    })
  end)
end

-- режим: сплит
local function open_split()
  vim.cmd("vsplit")
  win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
end

-- режим: плавающее окно
local function open_float()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    style = "minimal",
    border = "rounded",
    row = row,
    col = col,
    width = width,
    height = height,
  })
end

function M.toggle()
  if win and not vim.api.nvim_win_is_valid(win) then
    win = nil
  end

  ensure_terminal()

  -- если окно уже есть → закрываем
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
    return
  end

  -- иначе открываем в выбранном режиме
  if float then open_float() else open_split() end
end

-- переключение float/split
function M.set_mode(mode)
  if mode == "float" then
    float = true
  else
    float = false
  end
end

return M
