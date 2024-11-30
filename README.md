# Prerequisites

Install Xcode and Homebrew.

```bash
xcode-select --install
```

```bash
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add brew to $PATH.

```sh
eval "$(/opt/homebrew/bin/brew shellenv)"
```

# Installation

Download all the necessary packages via homebrew.

```sh
brew install bash bash-completion fzf gcc git lazygit lsd neovim nnn tmux zoxide
```

Download [IosevkaTermSlab](https://www.nerdfonts.com/font-downloads) Nerd Font and Install it.

Alacritty is a simple and fast terminal emulator written in rust. Install alacritty via homebrew cask.

```sh
brew install --cask alacritty
```

# Setup

```sh
git clone https://github.com/solvedbiscuit71/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

To install the dotfiles

```sh
python3 .script/init.py
```

To remove the dotfiles
```sh
python3 .script/deinit.py
```

# Config

Set bash as your default shell

```bash
echo '/opt/homebrew/bin/bash' | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/bash
```

Install plugin manager for tmux. Enter tmux and install the plugins via `<C-a>I`

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

# Add-ons

Disable dock delay in MacOS

```bash
defaults write com.apple.Dock autohide-delay -float 0 && killall Dock
```

Tiling window manager for MacOS

```bash
brew install --cask amethyst spaceid
```

Using `pyenv` to manage different python version
```bash
brew update
brew install pyenv
```

```bash
pyenv install 3.11
pyenv global 3.11
```

Using `nvm` to manage different node version, follow the [nvm](https://github.com/nvm-sh/nvm) github page to install nvm.

```bash
nvm alias default <version>
```
