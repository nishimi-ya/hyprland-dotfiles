setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt CORRECT
setopt AUTOCD

# Enable menu-style completion
zstyle ':completion:*' menu select

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Completion for hidden files
_comp_options+=(globdots)

HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
HISTSIZE="10000"
SAVEHIST="10000"

if [ -z "$HISTFILE" ]; then
    echo "HISTFILE is not set. Please set HISTFILE to a valid path."
else
    if [ ! -d "$(dirname "$HISTFILE")" ]; then
        echo "$(dirname "$HISTFILE")/ directory does not exist. Creating it now..."
        mkdir -p "$(dirname "$HISTFILE")"
    fi
fi

alias nvim='lvim'
alias nue='sh ~/.config/ncmpcpp/scripts/ncmpcpp-ueberzugpp/ncmpcpp-ueberzugpp 2>/dev/null'
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
alias mkd='mkdir -p'

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Requires additional install
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

# Enable completion
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"
