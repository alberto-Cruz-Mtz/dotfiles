if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#if status is-interactive
#   eval (zellij setup --generate-auto-start fish | string collect)
#end

if not set -q ZELLIJ
    zellij
end

set -gx PROJECT_PATHS ~/workspace ~/.config

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

starship init fish | source
fastfetch

# opencode
fish_add_path /home/tito/.opencode/bin
