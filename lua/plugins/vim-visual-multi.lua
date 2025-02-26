return {
  "mg979/vim-visual-multi",
  branch = "master",
  opts = {
    priority = 1000,
  },
  config = function()
    vim.g.VM_silent_exit = true
    vim.g.VM_skip_empty_lines = true
    vim.g.VM_skip_shorter_lines = true
    vim.keymap.set("n", "<C-c>", "<Plug>(VM-Add-Cursor-Down)", { silent = true })
    vim.keymap.set("n", "<C-a>", "<Plug>(VM-Select-All)", { silent = true })
  end,
}
