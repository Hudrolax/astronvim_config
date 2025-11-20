local function set_markdown_heading_colors()
  local hl = vim.api.nvim_set_hl

  -- Gruvbox Material dark
  local colors = {
    "#fabd2f", -- H1 yellow
    "#fe8019", -- H2 orange
    "#8ec07c", -- H3 aqua
    "#83a598", -- H4 blue
    "#d3869b", -- H5 purple
    "#928374", -- H6 gray
  }

  for i, color in ipairs(colors) do
    -- Новые treesitter-группы
    hl(0, "@markup.heading." .. i .. ".markdown", { fg = color, bold = true })
    -- Старое имя (на всякий случай)
    hl(0, "@text.title." .. i .. ".markdown", { fg = color, bold = true })
  end
end

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    -- рендер заголовков ОТКЛЮЧАЕМ (не будет полос, иконок и скрытия #)
    opts = {
      heading = {
        enabled = false,
      },
    },
    init = function()
      -- красим заголовки при старте темы и для markdown
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_markdown_heading_colors,
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = set_markdown_heading_colors,
      })
    end,
  },
}
