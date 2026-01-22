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

if command_exists uv; then
    info "uv already installed"
    exit 0
fi

if command_exists curl; then
    info "Installing uv via official script..."
    curl -LsSf https://astral.sh/uv/install.sh | sh || warn "uv install failed"
else
    warn "curl not found; skipping uv install"
    warn "Manual: curl -LsSf https://astral.sh/uv/install.sh | sh"
fi
