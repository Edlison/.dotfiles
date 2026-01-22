# Dotfiles entry point - loads zsh modules
# Symlinks are managed by install.sh, not sourced here
export DOTFILES=$HOME/.dotfiles

# Load oh-my-zsh settings and plugins
source $DOTFILES/zsh/settings.zsh

# Load environment variables
source $DOTFILES/zsh/envs.zsh

# Load aliases
source $DOTFILES/zsh/alias.zsh
