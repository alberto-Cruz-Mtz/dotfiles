if status is-interactive
    # Commands to run in interactive sessions can go here
end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

set -gx PROJECT_PATHS ~/workspace ~/.config
