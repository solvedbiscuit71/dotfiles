# Installation (MacOS)

Install Xcode

```sh
xcode-select --install
```

Install Homebrew

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install Packages

```sh
brew install fd fzf gcc git lazygit neovim nnn pyenv ripgrep zoxide
```

Install Softwares

1. [Aerospace](https://nikitabobko.github.io/AeroSpace/guide)
2. [Alacritty](https://alacritty.org/index.html)

# Instruction

1. Move `aerospace/.aerospace.toml` into `~`
2. Move `alacritty/alacritty.toml` into `~/.config/alacritty`
3. Move `nvim/init.lua` into `~/.config/nvim`
4. Move `zshr/.zshrc` and `zsh/.zprofile` into `~`
