return {
  "Wansmer/langmapper.nvim",
  lazy = false, -- load early to wrap keymap helpers
  priority = 1000,
  opts = {
    hack_keymap = true,
    map_all_ctrl = true,
    default_layout = [[ABCDEFGHIJKLMNOPQRSTUVWXYZ<>:"{}~abcdefghijklmnopqrstuvwxyz,.;'[]`]],
    layouts = {
      ru = {
        id = "com.apple.keylayout.RussianWin",
        layout = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯБЮЖЭХЪËфисвуапршолдьтщзйкыегмцчнябюжэхъё",
      },
    },
  },
}
