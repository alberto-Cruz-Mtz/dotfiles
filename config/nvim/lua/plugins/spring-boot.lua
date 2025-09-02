return {
  "JavaHello/spring-boot.nvim",
  ft = { "java", "yaml", "jproperties" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-jdtls",
    "ibhagwan/fzf-lua",
  },
  ---@type bootls.Config
  opts = {},
}
