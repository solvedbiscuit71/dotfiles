### Kanata

#### MacOS

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

8. Reboot the system.

#### Windows

> TODO: to be implemented soon.