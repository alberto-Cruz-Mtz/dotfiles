### Mi configuración de Hyprland

Esta es mi configuración personal y modular para **Hyprland**

---

### 📷 Capturas de pantalla

#### Escritorio

Mi escritorio principal, mostrando la barra Waybar.

<img src="https://raw.githubusercontent.com/Alberto-Cruz-mtz/dotfiles/main/screenshots/2025-09-02-173759_hyprshot.png" >

#### Lanzador de aplicaciones

El lanzador de aplicaciones Rofi, configurado con un tema oscuro y bordes redondeados, haciendo juego con el estilo de Hyprland.

<img src="https://raw.githubusercontent.com/Alberto-Cruz-mtz/dotfiles/main/screenshots/2025-09-02-173936_hyprshot.png" >

#### Terminal y Neovim

Mi terminal (Ghostty) y la configuración de Neovim, mostrando las opciones del gestor de plugins (LazyVim).

<img src="https://raw.githubusercontent.com/Alberto-Cruz-mtz/dotfiles/main/screenshots/2025-09-02-173917_hyprshot.png" >
<img src="https://raw.githubusercontent.com/Alberto-Cruz-mtz/dotfiles/main/screenshots/2025-09-02-182938_hyprshot.png" >

### ✨ Características principales

- **Gestor de ventanas**: [Hyprland](https://hyprland.org)
- **Barra de estado**: [Waybar](https://github.com/Alexays/Waybar)
- **Lanzador de aplicaciones**: [Rofi](https://github.com/davatorium/rofi)
- **Terminal**: [Ghostty](https://www.google.com/search?q=https://github.com/Ghostty/Ghostty)
- **Editor de texto**: [Neovim](https://neovim.io/)
- **Notificaciones**: [Swaync](https://github.com/ErikReider/SwayNotificationCenter)
- **Bloqueo de pantalla**: [Hyprlock](https://github.com/hyprwm/hyprlock)
- **Gestión de fondos de pantalla**: [Waypaper](https://www.google.com/search?q=https://github.com/waypaper/waypaper) y [swww](https://www.google.com/search?q=https://github.com/L-o-o-i/swww)
- **Capturas de pantalla**: [Hyprshot](https://www.google.com/search?q=https://github.com/hyprwm/hyprshot)

---

### 📦 Dependencias

Necesitas tener instalados los siguientes paquetes para que la configuración funcione correctamente.

**Programas principales:**

- `hyprland`
- `waybar`
- `rofi`
- `ghostty`
- `swaync`
- `hyprlock`
- `hypridle`
- `hyprshot`

**Otras utilidades:**

- `waypaper` o `swww` (para los fondos de pantalla)
- `dolphin` (u otro gestor de archivos)
- `wlogout` (para el menú de salida)
- `xdg-desktop-portal-hyprland` (para diálogos de archivos)
- `polkit-gnome` (para la autenticación)
- `gnome-keyring` (para gestionar credenciales)
- `trash-cli` (para vaciar la papelera)
- `cliphist` (para el historial del portapapeles)
- `playerctl` (para los atajos multimedia)

---

### 📁 Estructura del proyecto

El repositorio sigue una estructura modular para mantener la organización y la claridad. La configuración principal de Hyprland (`hyprland.conf`) carga cada archivo por separado.

```
.
├── .config/
│   ├── hypr/
│   │   ├── configs/
│   │   │   ├── applications.conf
│   │   │   ├── decoration.conf
│   │   │   ├── env.conf
│   │   │   ├── exec.conf
│   │   │   ├── hypridle.conf
│   │   │   ├── hyprlock.conf
│   │   │   ├── input.conf
│   │   │   ├── keybinds.conf
│   │   │   ├── monitor.conf
│   │   │   └── rules.conf
│   │   ├── hyprland.conf
│   │   └── (otras configuraciones)
│   ├── rofi/
│   ├── waybar/
│   └── (otros directorios de configuración)
├── images/
├── install.sh
└── README.md
```

---

### ⚙️ Guía de instalación

1.  **Clonar el repositorio:**

    ```bash
    git clone https://github.com/tu_usuario/tus_dotfiles.git ~/.dotfiles
    ```

2.  **Copiar o crear enlaces simbólicos a los archivos:**

    ```bash
    # Puedes crear enlaces simbólicos para que los cambios se reflejen al instante
    ln -sf ~/.dotfiles/.config/hypr ~/.config/
    ln -sf ~/.dotfiles/.config/waybar ~/.config/
    # Repite el comando para cada carpeta de configuración que tengas
    ```

---

### ⌨️ Atajos de teclado

Aquí están algunos de los atajos más importantes para comenzar.

| Atajo                        | Acción                                                     |
| :--------------------------- | :--------------------------------------------------------- |
| **`SUPER + Enter`**          | Abrir la terminal                                          |
| **`SUPER + Espacio`**        | Abrir el lanzador de aplicaciones (Rofi)                   |
| **`SUPER + Q`**              | Cerrar la ventana activa                                   |
| **`SUPER + F`**              | Activar/desactivar pantalla completa                       |
| **`SUPER + L`**              | Bloquear la pantalla                                       |
| **`SUPER + W`**              | Cambiar el fondo de pantalla                               |
| **`SUPER + SHIFT + W`**      | Cambiar el fondo de pantalla aleatoriamente                |
| **`SUPER + [1-10]`**         | Cambiar a un espacio de trabajo específico                 |
| **`SUPER + SHIFT + [1-10]`** | Mover la ventana activa a un espacio de trabajo específico |
| **`SUPER + Shift + S`**      | Mover la ventana activa al "scratchpad"                    |
| **`Impr Pant`**              | Capturar la pantalla completa al portapapeles              |

📝 Créditos

Parte de mi configuración de Neovim está inspirada en los dotfiles de Gentleman Programming. Un gran agradecimiento por su excelente trabajo y las ideas que he tomado para mi propio flujo de trabajo.
