-- sugerencia: cambia el enabled = false y lazy = true de jdtls.lua antes
-- para que instale paquetes que necesita este plugin
-- y instala manualmente con Mason vscode-spring-boot-tools
-- despues puedes cambiar nuevamente las propiedades de enable y lazy de jdtls.lua
-- a como se encontraban al inicio, si las dejas activido puede causar conflictos con este plugin

return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "JavaHello/spring-boot.nvim",
    "mfussenegger/nvim-dap",
  },
  init = function() end,
  config = function()
    local jdtls_setup = require("jdtls.setup")
    local jdtls = require("jdtls")

    local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = jdtls_setup.find_root(root_markers)

    if not root_dir then
      return
    end

    -- Esto es lo más importante: la configuración para Lombok
    local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin"
    local bundles_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter"

    local bundles = {}
    local lombok_path = vim.fn.glob(bundles_path .. "/lombok.jar")
    if #lombok_path > 0 then
      table.insert(bundles, vim.fn.glob(lombok_path))
    end

    -- También puedes añadir otros bundles si los necesitas, como el de depuración
    local java_debug_path = vim.fn.glob(bundles_path .. "/com.microsoft.java.debug.plugin-*.jar")
    if #java_debug_path > 0 then
      table.insert(bundles, vim.fn.glob(java_debug_path))
    end

    local config = {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.p2.data=@null",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. bundles_path .. "/lombok.jar",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        jdtls_path .. "/plugins/org.eclipse.jdt.ls.product_*.jar",
        "-configuration",
        jdtls_path .. "/config_linux",
        "-data",
        vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
      },
      root_dir = root_dir,
      settings = {
        java = {
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          inlayHints = { parameterNames = { enabled = "all" } },
          signatureHelp = { enabled = true },
          maven = { downloadSources = true },
          format = {
            settings = {
              url = "https://raw.githubusercontent.com/spring-io/spring-framework/main/spring-format/src/main/resources/eclipse/spring-format.xml",
              profile = "org.springframework.ide.eclipse.formatter.SpringProfile",
            },
          },
          configuration = {
            runtimes = {
              {
                name = "", -- Esta es la versión por defecto
                path = "/usr/lib/jvm/default",
                default = true,
              },
              {
                name = "java-21-openjdk",
                path = "/usr/lib/jvm/java-21-openjdk",
              },
              {
                name = "java-17-openjdk",
                path = "/usr/lib/jvm/java-17-openjdk",
              },
              {
                name = "java-8-openjdk",
                path = "/usr/lib/jvm/java-8-openjdk",
              },
            },
          },
          errors = {
            incomplete = "warning",
          },
          references = {
            includeDecompiledSources = true,
            includeBinarySources = true,
          },
          eclipse = {
            downloadSources = true,
            compiler = {
              problem = {
                unreferencedField = "ignore",
                unreferencedLocal = "ignore",
              },
            },
          },
          saveActions = {
            organizeImports = true,
          },
          completion = {
            -- When using an unimported static method, how should the LSP rank possible places to import the static method from
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            -- Try not to suggest imports from these packages in the code action window
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
            -- Set the order in which the language server should organize imports
            importOrder = {
              "java",
              "jakarta",
              "javax",
              "com",
              "org",
            },
            sources = {
              -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
              organizeImports = {
                starThreshold = 9999,
                staticThreshold = 9999,
              },
            },
            -- How should different pieces of code be generated?
            codeGeneration = {
              -- When generating toString use a json format
              toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
              },
              -- When generating hashCode and equals methods use the java 7 objects method
              hashCodeEquals = {
                useJava7Objects = true,
              },
              -- When generating code use code blocks
              useBlocks = true,
            },
            -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
            configuration = {
              updateBuildConfiguration = "interactive",
            },
            -- enable code lens in the lsp
            referencesCodeLens = {
              enabled = true,
            },
            -- enable inlay hints for parameter names,
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        },
      },
    }

    -- Los handlers se pueden configurar directamente en lspconfig.jdtls.setup
    require("lspconfig").jdtls.setup({
      handlers = {
        ["workspace/executeClientCommand"] = function(_, command, ctx)
          local cmd = command.command or ""

          if cmd == "editor.action.triggerParameterHints" then
            return {}
          end

          local default_handler = vim.lsp.handlers["workspace/executeClientCommand"]
          if default_handler then
            return default_handler(_, command, ctx)
          end
        end,
        on_attach = function(client)
          -- **Eliminamos la siguiente línea porque causa el error:**
          jdtls.setup_dap_and_test(client)
        end,
      },
    })

    jdtls.start_or_attach(config)
  end,
}
