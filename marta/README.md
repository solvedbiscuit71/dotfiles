### Marta (macOS only)

1. Download and Install [Marta](https://marta.sh/docs/)
2. To enable `marta` in the command line, run the following command

```sh
sudo ln -s /Applications/Marta.app/Contents/Resources/Launcher /usr/local/bin/marta
```

3. Since Marta maintains user configuration on its own, run the following command to overwrite (or) copy-paste the user configuration from `/marta/conf.marco`

```sh
cp marta/conf.marco "$HOME/Library/Application Support/org.yanex.marta/conf.marco"
```