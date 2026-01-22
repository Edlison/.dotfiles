#!/bin/bash
# uninstall.sh - Dotfiles uninstall script
# Usage: bash uninstall.sh [--remove-dotfiles] [--remove-omz]

set -e

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
OMZ_DIR="${OMZ_DIR:-$HOME/.oh-my-zsh}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

usage() {
    cat <<'EOF'
Usage:
  bash uninstall.sh [--remove-dotfiles] [--remove-omz]

Options:
  --remove-dotfiles   Remove ~/.dotfiles directory
  --remove-omz        Remove ~/.oh-my-zsh directory
  -h, --help          Show this help
EOF
}

REMOVE_DOTFILES=false
REMOVE_OMZ=false

while [ "$#" -gt 0 ]; do
    case "$1" in
        --remove-dotfiles) REMOVE_DOTFILES=true ;;
        --remove-omz) REMOVE_OMZ=true ;;
        -h|--help) usage; exit 0 ;;
        *) error "Unknown option: $1" ;;
    esac
    shift
done

remove_link_and_restore_backup() {
    local target="$1"
    local source="$2"
    local backup="${target}.backup"

    if [ -L "$target" ]; then
        local current_link
        current_link=$(readlink "$target")
        if [ "$current_link" = "$source" ]; then
            rm -f "$target"
            success "Removed symlink: $target"
        else
            warn "Skipped non-dotfiles symlink: $target -> $current_link"
        fi
    elif [ -e "$target" ]; then
        warn "Skipped existing non-symlink file: $target"
    else
        info "No file to remove: $target"
    fi

    if [ -f "$backup" ] && [ ! -e "$target" ]; then
        mv "$backup" "$target"
        success "Restored backup: $target"
    fi
}

info "Uninstalling dotfiles..."

# Remove symlinks created by links.zsh
remove_link_and_restore_backup "$HOME/.tmux.conf" "$DOTFILES_DIR/tmux/.tmux.conf"
remove_link_and_restore_backup "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
remove_link_and_restore_backup "$HOME/.vimrc" "$DOTFILES_DIR/vim/.vimrc"

# Remove .zshrc symlink created by install.sh
remove_link_and_restore_backup "$HOME/.zshrc" "$DOTFILES_DIR/.zshrc"

if [ "$REMOVE_OMZ" = true ]; then
    if [ -d "$OMZ_DIR" ]; then
        rm -rf "$OMZ_DIR"
        success "Removed oh-my-zsh: $OMZ_DIR"
    else
        info "oh-my-zsh not found at $OMZ_DIR"
    fi
else
    info "Keeping oh-my-zsh (use --remove-omz to remove)"
fi

if [ "$REMOVE_DOTFILES" = true ]; then
    if [ -d "$DOTFILES_DIR" ]; then
        rm -rf "$DOTFILES_DIR"
        success "Removed dotfiles: $DOTFILES_DIR"
    else
        info "dotfiles not found at $DOTFILES_DIR"
    fi
else
    info "Keeping dotfiles (use --remove-dotfiles to remove)"
fi

success "Uninstall complete."
