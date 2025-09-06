return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["l"] = function(state)
          local node = state.tree:get_node()
          if node.type == "directory" and node:is_expanded() then
            -- если каталог раскрыт — свернуть
            require("neo-tree.sources.filesystem").toggle_directory(state, node)
          else
            -- иначе поведение по умолчанию (открыть)
            state.commands["open"](state)
          end
        end,
      },
    },
  },
}
