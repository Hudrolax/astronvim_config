-- lua/plugins/mason_tool_installer.lua
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  opts = function(_, opts)
    local function filter(list)
      local out = {}
      for _, name in ipairs(list or {}) do
        if name ~= "hadolint" then table.insert(out, name) end
      end
      return out
    end
    opts.ensure_installed = filter(opts.ensure_installed)
    -- опционально: не запускать авто-установку на старте
    -- opts.run_on_start = false
  end,
}
