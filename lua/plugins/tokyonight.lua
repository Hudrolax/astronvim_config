return {
  "folke/tokyonight.nvim",
  -- грузим сразу при старте, чтобы можно было сразу выставить colorscheme
  lazy    = false,
  priority = 1000,

  -- передача опций в require("tokyonight").setup
  opts = {
    -- доступные стили: "storm", "night", "day"
    style           = "night",
    light_style     = "day",
    transparent     = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
    },
    sidebars         = { "qf", "help", "packer" },
    hide_inactive_statusline = false,
    dim_inactive     = false,
  },

  -- вызываем установку и сразу применяем тему
  config = function(_, opts)
    require("tokyonight").setup(opts)
    -- vim.cmd("colorscheme tokyonight")
  end,
}
