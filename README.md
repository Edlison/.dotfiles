# .dotfiles

Personal dotfiles managed with zsh and oh-my-zsh.

## Quick Install

```sh
# Clone and run install script
git clone https://github.com/edlison/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bash install.sh
```

Or run directly (after cloning):

```sh
bash ~/.dotfiles/install.sh
```

The install script will:
1. Check if zsh is installed
2. Install oh-my-zsh if not present
3. Clone/update dotfiles into `~/.dotfiles` (requires git)
4. Create symlinks for config files (`.gitconfig`, `.tmux.conf`)
5. Link `.zshrc` to the dotfiles version

## Prerequisites

### ZSH
Please refer to [Installing ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

### Git
Required for cloning the repository.

## Structure

```
.dotfiles/
├── install.sh          # Installation script
├── .zshrc              # Main zsh config (entry point)
├── .bashrc             # Bash fallback
├── zsh/
│   ├── settings.zsh    # oh-my-zsh settings, theme, plugins
│   ├── alias.zsh       # Custom aliases
│   ├── envs.zsh        # Environment variables
│   └── links.zsh       # Symlink setup (called by install.sh)
├── git/
│   └── .gitconfig      # Git configuration
└── tmux/
    └── .tmux.conf      # Tmux configuration
```

## Manual Setup (Bash only)

If you don't have permission to use zsh:

```sh
# Append bash config
cat .bashrc >> ~/.bashrc

# Create config symlinks manually
bash zsh/links.zsh
```

## Additional Setup

### Conda

If using Anaconda/Miniconda:

```sh
/path/to/anaconda/bin/conda init zsh
```

### Git SSH Auth

1. Upload your private key to `~/.ssh/keys/`

2. Add to `~/.ssh/config`:
```
Host gh
    HostName github.com
    User git
    IdentityFile ~/.ssh/keys/your_key
```

3. Test connection:
```sh
ssh -T git@gh
```

## Customization

- **Theme**: Edit `ZSH_THEME` in `zsh/settings.zsh`
- **Plugins**: Edit `plugins=()` in `zsh/settings.zsh`
- **Aliases**: Add to `zsh/alias.zsh`
- **Environment variables**: Add to `zsh/envs.zsh`
