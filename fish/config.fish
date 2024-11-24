if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx PROJECT_PATHS ~/workspace ~/src
set -x PATH $PATH /home/linuxbrew/.linuxbrew/bin/git /usr/bin/date

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

fastfetch
