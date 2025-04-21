function clan_trash --wraps='sudo pacman -Rns ' --description 'alias clan_trash=sudo pacman -Rns '
  sudo pacman -Rns  $argv
        
end
