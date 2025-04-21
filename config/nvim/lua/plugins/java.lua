return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            require("lspconfig").jdtls.setup({
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      {
                        name = "JavaSE-8",
                        path = "/home/tito/.config/java/jdk8u442-b06/",
                        default = true,
                      },
                    },
                  },
                },
              },
            }),
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({})
          end,
        },
      },
    },
  },
}
