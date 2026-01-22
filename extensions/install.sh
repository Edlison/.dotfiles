#!/bin/sh

set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

install_extension() {
    extension_name="$1"
    extension_install="$2"
    response=""

    printf "Install extension '%s'? (type 'yes' to install): " "$extension_name"
    IFS= read -r response

    if [ "$response" = "yes" ]; then
        sh "$extension_install"
        echo "[OK] Installed: $extension_name"
    else
        echo "[SKIP] $extension_name"
    fi
}

for extension_dir in "$SCRIPT_DIR"/*; do
    if [ ! -d "$extension_dir" ]; then
        continue
    fi

    extension_name="$(basename "$extension_dir")"
    extension_install="$extension_dir/install.sh"

    if [ -f "$extension_install" ]; then
        install_extension "$extension_name" "$extension_install"
    fi
done
