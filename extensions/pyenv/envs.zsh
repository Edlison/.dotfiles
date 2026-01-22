#!/bin/zsh

export PYENV_ROOT="$HOME/.pyenv"
if [ -d "$PYENV_ROOT" ]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    if command -v pyenv-virtualenv >/dev/null 2>&1; then
      eval "$(pyenv virtualenv-init -)"
    fi
  fi
fi
