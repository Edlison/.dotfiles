# .dotfiles
## Usage
zsh
```sh
# add this to .zshrc
source ~/.dotfiles/.zshrc
# init
zsh
```

bash only (in case you don't have permission to change your shell)
```sh
# using bash
cat .bashrc >> ~/.bashrc
# git config
cp git/.gitconfig ..
# tmux config
cp tmux/.tmux.conf ..
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

Modify `~/.ssh/config`: 
```
Host gh
HostName github.com
User git
IdentityFile ~/.ssh/keys/your_key
```

Test connection:
```sh
ssh -T git@gh
```
