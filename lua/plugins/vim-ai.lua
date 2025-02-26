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

      Отвечай кратко, не пиши комментарии и советы, если тебя об этом не попросили.
      Форматируй ответ так, чтобы в нем не было длинных строк (больше 80 символов).
      Если ты прекрепляешь блок кода, то вставляй тип синтаксиса после ``` для правильной подсветки синтаксиса.
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
      \    "open_chat_command": "preset_right",
      \    "scratch_buffer_keep_open": 0,
      \    "populate_options": 0,
      \    "code_syntax_enabled": 1,
      \    "force_new_chat": 0,
      \    "paste_mode": 1,
      \  },
      \}

      let s:initial_edit_prompt =<< trim END
      >>> system

      Ты должен изменить часть кода согласно запросу. Не используй ``` для обрамления блоков кода.
      END
      let g:vim_ai_edit = {
      \  "prompt": "",
      \  "engine": "chat",
      \  "options": {
      \    "model": "gpt-4o",
      \    "endpoint_url": "https://api.openai.com/v1/chat/completions",
      \    "max_tokens": 0,
      \    "max_completion_tokens": 0,
      \    "temperature": 0.1,
      \    "request_timeout": 20,
      \    "stream": 1,
      \    "enable_auth": 1,
      \    "token_file_path": "",
      \    "selection_boundary": "#####",
      \    "initial_prompt": s:initial_edit_prompt,
      \  },
      \  "ui": {
      \    "paste_mode": 1,
      \  },
      \}
    ]]
  end,
}
