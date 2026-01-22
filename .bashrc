# Dotfiles entry point - loads bashrc modules
export DOTFILES=$HOME/.dotfiles

# Load environment variables
source $DOTFILES/zsh/envs.zsh

# Load aliases
source $DOTFILES/zsh/alias.zsh

# Additional alias
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
