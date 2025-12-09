-- lua/plugins/dbee.lua
return {
  "kndndrj/nvim-dbee",
  cmd = "Dbee",
  dependencies = { "MunifTanjim/nui.nvim" },
  build = function()
    require("dbee").install()
  end,
  keys = {
    {
      "<leader>td",
      function() require("dbee").toggle() end,
      desc = "Toggle DB client",
    },
  },
  config = function()
    require("dbee").setup()
  end,
}
