function ri --wraps='sudo pacman -S' --description 'alias ri=sudo pacman -S'
  sudo pacman -S $argv
        
end
