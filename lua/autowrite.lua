vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    if vim.bo.buftype == "" and vim.fn.expand "%" ~= "" and vim.bo.modified then vim.cmd "silent! write" end
  end,
})
