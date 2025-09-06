-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/astrocore.lua
local function insert_ignore()
  local filetype = vim.bo.filetype
  if filetype == "python" then
    vim.cmd "normal! $a  # type: ignore"
    vim.cmd "normal! bbbbb"
  elseif filetype == "typescript" or filetype == "javascript" or filetype == "typescriptreact" then
    vim.cmd "normal! O// @ts-ignore"
    vim.cmd "normal! j"
  else
    print("Неизвестный тип файла: " .. filetype)
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = { virtual_text = true, underline = true },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        colorcolumn = "121",
        autowrite = true, -- писать при смене буфера/команды
        autowriteall = true, -- писать ВСЕ буферы при :quit/:qall и т.п.
        hidden = true, -- можно убирать буфер из окна без сохранения (не будет диалогов)
        swapfile = false,
        hlsearch = true,
        termguicolors = true,
        clipboard = "unnamedplus", -- << главное для системного буфера
        scrolloff = 5,
      },
      g = {
        -- глобальные переменные при необходимости
      },
    },
    mappings = {
      n = {
        ["<Leader>bn"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<Leader>bb"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- системный буфер (явно)
        ["<leader>y"] = { '"+y', desc = "Yank to system clipboard", noremap = true, silent = true },
        ["<leader>p"] = { '"+p', desc = "Paste from system clipboard", noremap = true, silent = true },

        ["<S-l>"] = "$",
        ["<S-h>"] = "^",

        ["ti"] = insert_ignore,

        ["A-j"] = ":m+<cr>",
        ["A-k"] = ":m-2<cr>",

        ["<C-,>"] = ":vertical resize -5<cr>",
        ["<C-.>"] = ":vertical resize +5<cr>",
        ["<C-4>"] = {
          function() require("toggleterm").toggle(nil, nil, nil, "float") end,
          desc = "Toggle float terminal",
        },
      },
      v = {
        ["("] = "c()<Esc>hp",
        ["["] = "c[]<Esc>hp",
        ["{"] = "c{}<Esc>hp",

        -- системный буфер (визуальный)
        ["<leader>y"] = { '"+y', desc = "Yank to system clipboard", noremap = true, silent = true },

        ["A-j"] = ":m '>+1<CR>",
        ["A-k"] = ":m '>-2<CR>",
        ["<S-l>"] = "$",
        ["<S-h>"] = "^",
      },
      i = {
        ["A-j"] = ":<Esc>m+<cr>",
        ["A-k"] = ":<Esc>m-2<cr>",
      },
      t = {
        ["<C-4>"] = {
          function() require("toggleterm").toggle(nil, nil, nil, "float") end,
          desc = "Toggle float terminal",
        },
      },
    },
  },
}
