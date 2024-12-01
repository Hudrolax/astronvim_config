-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])

-- Копировать в локальный буфер обмена при каждом копировании
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    -- Проверяем, что оператор 'y' и регистр по умолчанию
    if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
      -- Копируем содержимое регистра '"' (безымянный регистр) в локальный буфер обмена
      vim.cmd('OSCYankRegister "')
    end
  end,
})
