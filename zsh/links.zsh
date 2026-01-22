#!/bin/bash
# links.zsh - Idempotent symlink setup script
# Called by install.sh during initial setup
# Can also be run standalone: bash zsh/links.zsh

# Ensure DOTFILES is set
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Function to create symlink if it doesn't exist or is broken
create_link() {
    local source="$1"
    local target="$2"
    
    # Check if source file exists
    if [ ! -f "$source" ]; then
        echo "[WARN] Source file not found: $source"
        return 1
    fi
    
    # Check if target is already a correct symlink
    if [ -L "$target" ]; then
        local current_link
        current_link=$(readlink "$target")
        if [ "$current_link" = "$source" ]; then
            echo "[OK] Already linked: $target -> $source"
            return 0
        fi
    fi
    
    # Backup existing file if it's not a symlink
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "[INFO] Backing up existing file: $target -> $target.backup"
        mv "$target" "$target.backup"
    fi
    
    # Create symlink
    ln -sf "$source" "$target"
    echo "[OK] Created link: $target -> $source"
}

# Create symlinks for config files
create_link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
create_link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
