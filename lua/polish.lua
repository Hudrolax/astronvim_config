-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    -- Проверяем, что оператор 'y' и регистр по умолчанию
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      -- Копируем содержимое регистра '"' (безымянный регистр) в локальный буфер обмена
      vim.cmd('OSCYankRegister "')
    end
  end,
})

