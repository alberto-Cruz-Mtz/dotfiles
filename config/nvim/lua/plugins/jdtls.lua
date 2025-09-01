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
    },
  },
}

return {
  "nvim-java/nvim-java",
  config = function()
    require("java").setup({
      spring_boot_tools = {
        enable = false,
      },
      jdk = {
        auto_install = false,
      },
      jdtls = {
        jvm = "/usr/lib/jvm/java-17-openjdk/bin/java",
      },
    })
    require("lspconfig").jdtls.setup(jdtls)
  end,
}
