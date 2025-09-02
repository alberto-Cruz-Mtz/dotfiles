-- sugerencia: cambia el enabled = false y lazy = true de este plugin antes
-- para que instale paquetes que necesita este plugin
-- despues cambia nuevamente las propiedades de enable y lazy
-- a como se encontraban al inicio, si las dejas activido puede causar conflictos con nvim-jdtls.lua

local jdtls = {
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
  },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "",
            path = "/usr/lib/jvm/default",
            default = true,
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
      symbols = {
        includeSourceMethodDeclarations = true,
      },
      project = {
        referencedLibraries = {
          "~/Downloads/lombok.jar",
        },
      },
    },
  },
}

return {
  "nvim-java/nvim-java",
  lazy = true,
  enabled = false,
  config = function()
    require("java").setup({
      lombok = {
        version = "nightly",
      },
      spring_boot_tools = {
        enable = false,
      },
      jdk = {
        auto_install = false,
      },
      jdtls = {
        jvm = "/usr/lib/jvm/java-17-openjdk/bin/java",
      },
      verification = {
        invalid_order = true,
        duplicate_setup_calls = true,
        invalid_mason_registry = false,
      },
    })
    require("lspconfig").jdtls.setup(jdtls)
  end,
}
