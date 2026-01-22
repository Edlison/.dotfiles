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

ZSHRC="$HOME/.zshrc"
PYENV_PATH_LINE='export PATH="$HOME/.pyenv/bin:$PATH"'
PYENV_PATH_COMMENT="# pyenv"
PYENV_INIT_LINE='eval "$(pyenv init -)"'

if [ -f "$ZSHRC" ]; then
    if ! grep -Fqs "$PYENV_PATH_LINE" "$ZSHRC"; then
        printf "\n%s\n%s\n" "$PYENV_PATH_COMMENT" "$PYENV_PATH_LINE" >> "$ZSHRC"
        info "Added pyenv PATH to $ZSHRC"
    else
        info "pyenv PATH already present in $ZSHRC"
    fi

    if ! grep -Fqs "$PYENV_INIT_LINE" "$ZSHRC"; then
        printf "%s\n" "$PYENV_INIT_LINE" >> "$ZSHRC"
        info "Added pyenv init to $ZSHRC"
    else
        info "pyenv init already present in $ZSHRC"
    fi
else
    warn "$ZSHRC not found; skipping PATH update"
fi
