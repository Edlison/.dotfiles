# .dotfiles
## Usage
```sh
git clone
# using zsh
cp .zshrc ..
# using bash (if you can not change your shell)
cat .bashrc >> ~/.bashrc
# gitconfig
cp git/.gitconfig ..
```

## Before Cloning
### ZSH Installation
Please refer to [installing ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)

### OMZ Installation
Please refer to [installing oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

### Conda Installation
Please refer to [installing anaconda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/index.html)

Mount conda on zsh:
```sh
/path/to/anaconda/bin/conda init zsh
```

### Git Auth
Upload private key to `~/.ssh/keys`  
Modify `~/.ssh/config`
