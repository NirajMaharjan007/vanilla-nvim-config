# Nvim Vanilla Config

**NOTE:** This is for Nvim

## [Installation](https://neovim.io/doc/install/)

#### Make a backup of your current nvim and shared folder

- For linux

  ```shell
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  mv ~/.local/state/nvim ~/.local/state/nvim.bak
  mv ~/.cache/nvim ~/.cache/nvim.bak
  ```

- For Windows Powershell

  ```shell
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
  ```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

- for linux/ unix like os
  ```shell
  https://github.com/NirajMaharjan007/vanilla-nvim-config.git ~/.config/nvim
  ```
- for Windows
  ```shell
  https://github.com/NirajMaharjan007/vanilla-nvim-config.git C:\Users\<YourUsername>\AppData\Local\nvim
  ```

#### Start Neovim

```shell
nvim
```

#### Nvim [Docs](https://neovim.io/doc/)
