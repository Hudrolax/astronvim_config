-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/astroui.lua
---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    colorscheme = "gruvbox",
  },
  specs = {
    -- собственно тема
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      opts = {
        italic = { strings = false, comments = true, operators = false, folds = true },
        contrast = "hard", -- soft | medium | hard
      },
      config = function(_, opts)
        require("gruvbox").setup(opts)
        vim.cmd.colorscheme "gruvbox"
      end,
    },
  },
}

