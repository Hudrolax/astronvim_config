-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/polish.lua
-- Здесь подключаем ваши кастомные модули/хелперы
pcall(require, "include_files")
pcall(require, "include_open_tabs")
pcall(require, "autowrite")

-- сюда можно добавлять любую "финишную" инициализацию

-- Даем Vim понимать команды в русской раскладке и дублируем маппинги
local function escape(str)
  return vim.fn.escape(str, [[;,."|\]])
end

local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,./]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмитьбю.]]

vim.opt.langmap = table.concat({
  escape(ru_shift) .. ";" .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")

local ok, langmapper = pcall(require, "langmapper")
if ok then
  langmapper.automapping { global = true, buffer = false } -- дублируем уже объявленные маппинги
end
