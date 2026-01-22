#!/bin/sh

set -e

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

if command_exists pyenv; then
    info "pyenv already installed"
    exit 0
fi

if command_exists curl; then
    info "Installing pyenv via official script..."
    curl -s https://pyenv.run | bash || warn "pyenv install failed"
else
    warn "curl not found; skipping pyenv install"
    warn "Manual: curl https://pyenv.run | bash"
fi
