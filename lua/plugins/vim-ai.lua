return {
  "madox2/vim-ai",
  opts = {
    priority = 1000,
    config = true,
  },
  config = function()
    vim.g.vim_ai_roles_config_file = "~/.config/nvim/ai-roles.ini"
    vim.cmd [[
      let s:initial_chat_prompt =<< trim END
      >>> system

      Отвечай кратко, не пиши комментарии и советы, если тебя об этом не попросили. Вставляй в ответ перенос строки, чтобы не было строк длиннее 120 символов.
      END
      let g:vim_ai_chat = {
      \  "prompt": "",
      \  "options": {
      \    "model": "o3-mini",
      \    "temperature": 1,
      \    "stream": 1,
      \    "selection_boundary": "",
      \    "enable_auth": 1,
      \    "initial_prompt": s:initial_chat_prompt,
      \  },
      \  "ui": {
      \    "open_chat_command": "preset_below",
      \    "scratch_buffer_keep_open": 0,
      \    "populate_options": 0,
      \    "code_syntax_enabled": 1,
      \    "force_new_chat": 0,
      \    "paste_mode": 1,
      \  },
      \}
    ]]
  end,
}
