return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      ft = { "java", "xml", "jproperties" },
      opts = {
        servers = {
          jdtls = {
            -- Your custom jdtls settings goes here
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              spring_boot_tools = {
                enable = true,
              },
              jdk = {
                auto_install = true,
                version = "17.0.2",
              },
            })
          end,
        },
      },
    },
  },
}
