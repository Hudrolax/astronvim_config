-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- lua/plugins/astrolsp.lua
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- серверы, которые нужно активировать
    servers = {
      -- языки
      "pyright",               -- Python
      "ts_ls",                 -- JS/TS (новое имя вместо tsserver)
      "lua_ls",                -- Lua
      "dockerls",              -- Dockerfile
      "yamlls",                -- YAML (для docker-compose схем)
      "clangd",                -- C/C++
      "arduino_language_server", -- Arduino (минимальный запуск)
      "cssls",                 -- CSS
      "sqls",                  -- SQL (универсальный LSP; Postgres ок)
      "bsl_ls",                -- 1C (BSL Language Server) если установлен через mason
    },

    -- точечные настройки серверов
    ---@diagnostic disable-next-line: missing-fields
    config = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
            },
          },
        },
      },

      ts_ls = {
        -- typescript-language-server (tsserver) через mason
        -- здесь можно включать/выключать форматирование, если используешь prettier в null-ls/none-ls
        -- on_attach = function(client, _)
        --   client.server_capabilities.documentFormattingProvider = false
        -- end,
      },

      lua_ls = {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            format = { enable = true }, -- форматтер stylua будет через none-ls
          },
        },
      },

      dockerls = {},

      -- ВАЖНО: docker-compose лучше вести через yamlls + schemaStore
      yamlls = {
        settings = {
          yaml = {
            validate = true,
            schemaStore = {
              enable = true,
              url = "https://www.schemastore.org/api/json/catalog.json",
            },
            schemas = {
              -- жёсткая привязка схемы docker-compose ко всем файлам docker-compose*
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                "docker-compose*.{yml,yaml}",
                "*compose*.{yml,yaml}",
              },
            },
            format = { enable = true },
            completion = true,
            hover = true,
          },
        },
      },

      clangd = {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      },

      cssls = {},

      -- Arduino: без специальных аргументов тоже работает, но для проекта можно добавить FQBN, если нужно
      arduino_language_server = {
        -- settings/command_defaults можно будет дописать под проект
      },

      -- SQL: sqls умеет Postgres. Подключения (DSN) можно добавить позже локально в проекте
      sqls = {
        settings = {
          sqls = {
            connections = {
              -- Пример (раскомментируй и поправь под себя):
              -- {
              --   driver = "postgresql",
              --   dataSourceName = "host=127.0.0.1 port=5432 user=postgres password=postgres dbname=postgres sslmode=disable",
              -- },
            },
          },
        },
      },

      -- 1C: bsl-language-server
      bsl_ls = {},
    },

    -- форматирование через LSP можно централизованно отключать/включать тут,
    -- если хочешь форсить форматтеры из none-ls (prettier/black/stylua/clang-format/…)
    -- formatting = {
    --   disabled = { "ts_ls" },
    -- },
  },
}
