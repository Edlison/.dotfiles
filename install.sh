#!/bin/bash
# install.sh - Dotfiles installation script
# Usage: curl -fsSL <raw-url>/install.sh | bash
#    or: bash install.sh

set -e

# Configuration
DOTFILES_REPO="https://github.com/Edlison/.dotfiles.git"  # TODO: Update to your repo URL
DOTFILES_DIR="$HOME/.dotfiles"
OMZ_DIR="$HOME/.oh-my-zsh"

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

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Check zsh
check_zsh() {
    info "Checking zsh..."
    if command_exists zsh; then
        success "zsh is installed: $(which zsh)"
    else
        error "zsh is not installed. Please install zsh first."
    fi

    # Check if zsh is the default shell (informational only)
    if [ "$SHELL" != "$(which zsh)" ]; then
        warn "zsh is not your default shell. Run 'chsh -s \$(which zsh)' to change it."
    else
        success "zsh is the default shell"
    fi
}

# Step 2: Check and install oh-my-zsh
check_omz() {
    info "Checking oh-my-zsh..."
    if [ -d "$OMZ_DIR" ]; then
        success "oh-my-zsh is already installed at $OMZ_DIR"
    else
        info "Installing oh-my-zsh..."
        # Use RUNZSH=no to prevent oh-my-zsh from starting a new shell
        # Use CHSH=no to prevent oh-my-zsh from changing the default shell
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        if [ -d "$OMZ_DIR" ]; then
            success "oh-my-zsh installed successfully"
        else
            error "Failed to install oh-my-zsh"
        fi
    fi
}

# Step 3: Clone or update dotfiles
setup_dotfiles() {
    info "Setting up dotfiles..."
    if [ -d "$DOTFILES_DIR" ]; then
        success "dotfiles already exist at $DOTFILES_DIR"
        # Optionally pull latest changes
        info "Pulling latest changes..."
        cd "$DOTFILES_DIR" && git pull --rebase || warn "Could not pull latest changes"
    else
        info "Cloning dotfiles from $DOTFILES_REPO..."
        if ! command_exists git; then
            error "git is not installed. Please install git first."
        fi
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
        if [ -d "$DOTFILES_DIR" ]; then
            success "dotfiles cloned successfully"
        else
            error "Failed to clone dotfiles"
        fi
    fi
}

# Step 4: Create symlinks
setup_links() {
    info "Setting up symlinks..."
    
    # Source the DOTFILES variable
    export DOTFILES="$DOTFILES_DIR"
    
    # Run the links script
    if [ -f "$DOTFILES_DIR/zsh/links.zsh" ]; then
        bash "$DOTFILES_DIR/zsh/links.zsh"
        success "Symlinks created"
    else
        error "links.zsh not found at $DOTFILES_DIR/zsh/links.zsh"
    fi
}

# Step 5: Setup .zshrc symlink
setup_zshrc() {
    info "Setting up .zshrc..."
    
    local zshrc_target="$HOME/.zshrc"
    local zshrc_source="$DOTFILES_DIR/.zshrc"
    
    if [ -L "$zshrc_target" ]; then
        # Already a symlink
        local current_link
        current_link=$(readlink "$zshrc_target")
        if [ "$current_link" = "$zshrc_source" ]; then
            success ".zshrc is already linked correctly"
            return
        fi
    fi
    
    # Backup existing .zshrc if it exists and is not a symlink
    if [ -f "$zshrc_target" ] && [ ! -L "$zshrc_target" ]; then
        warn "Backing up existing .zshrc to .zshrc.backup"
        mv "$zshrc_target" "$zshrc_target.backup"
    fi
    
    # Create symlink
    ln -sf "$zshrc_source" "$zshrc_target"
    success ".zshrc linked to $zshrc_source"
}

# Main
main() {
    echo ""
    echo "=========================================="
    echo "       Dotfiles Installation Script       "
    echo "=========================================="
    echo ""
    
    check_zsh
    check_omz
    setup_dotfiles
    setup_links
    setup_zshrc
    
    echo ""
    echo "=========================================="
    success "Installation complete!"
    echo "=========================================="
    echo ""
    info "Please restart your terminal or run 'source ~/.zshrc' to apply changes."
    echo ""
}

main "$@"
