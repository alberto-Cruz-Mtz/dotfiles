return {
  {
    "Alan-TheGentleman/oldworld.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "Gentleman-Programming/gentleman-kanagawa-blur",
    name = "gentleman-kanagawa-blur",
    priority = 1000,
    opts = {
      terminal_colors = true, -- habilitar colores para la terminal
      variant = "sakura_night_blur", -- puede usar: sakura_night_blur, blur
      styles = { -- Puedes definir el estilo utilizando el formato: estilo = valor
        comments = { italic = true }, -- estilo para comentarios
        keywords = { italic = true }, -- estilo para palabras clave
        identifiers = { italic = true }, -- estilo para identificadores
        functions = { italic = true }, -- estilo para funciones
        variables = { italic = true }, -- estilo para variables
        booleans = { italic = true }, -- estilo para valores booleanos
      },
      integrations = { -- Puedes habilitar/deshabilitar integraciones
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = false,
        indent_blankline = true,
        lazy = true,
        lsp = true,
        markdown = true,
        mason = true,
        navic = false,
        neo_tree = false,
        neogit = false,
        neorg = false,
        noice = true,
        notify = true,
        rainbow_delimiters = true,
        telescope = true,
        treesitter = true,
      },
      highlight_overrides = {},
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gentleman-kanagawa-blur",
    },
  },
}
