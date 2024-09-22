# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

alias nvim='lvim'
alias nue='sh ~/.config/ncmpcpp/scripts/ncmpcpp-ueberzug/ncmpcpp-ueberzug 2>/dev/null'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto'
alias lt='eza -lhD --icons=auto'
alias l='eza --icons=auto --tree'

alias pi='yay -S' # Install package
alias un='yay -Rns' # uninstall package
alias up='yay -Syu' # update system package/aur
alias pl='yay -Qs' # list installed package
alias pa='yay -Ss' # list available package
alias pc='yay -Sc' # remove unused cache
alias po='yay -Qtdq | yay -Rns -' # remove unused package

alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

eval "$(starship init zsh)"
