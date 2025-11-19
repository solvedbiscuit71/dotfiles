# Installation

Install Xcode

```sh
xcode-select --install
```

Install Homebrew

```sh
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install Softwares

1. [Alacritty](https://alacritty.org/index.html)
2. [Dropshelf](https://pilotmoon.com/dropshelf/)

# Scripts

1. `install-packages`: uses brew and git to install necessary packages and software.
2. `install-config`: creates folder and symlinks to configuration files.
3. `remove-config`: remove folder and unlink symlinks to configuration files.

# Home-Row Mod (Advanced)

1. Install [Karabinar-Elements](https://karabiner-elements.pqrs.org) and grant the requested premission.
2. Quit Karabinar-Elements.
3. Download [kanata](https://github.com/jtroo/kanata/releases) pre-built binary.
4. Copy the binary (with `cmd_allowed` enabled) to `/usr/local/bin/kanata`.
5. Ensure the binary has been allowed "Input Monitoring" and "Accessibility" permission under `System Settings > Privacy`.
6. Run the `install-config` script.
7. Run the above commands in the terminal:

```sh
sudo cp ~/.config/kanata/com.example.kanata.plist /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl enable system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

7. Reboot the system.
