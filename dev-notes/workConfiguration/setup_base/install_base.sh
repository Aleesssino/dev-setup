#!/bin/bash

sudo dnf update -y

sudo dnf install -y \
  fzf \
  zoxide \
  alacritty \
  neovim \
  tmux \
  gnome-tweaks \
  ripgrep \
  fd-find \
  stow \
  zsync \
  curl \
  wget \
  gcc

sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit

# Nerd Fonts (Mono)
NERD_FONT_VERSION="3.0.2"
NERD_FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_FONT_VERSION}/FiraCode.zip"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget "$NERD_FONT_URL" -O FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip
fc-cache -fv

bash <(curl -s https://updates.zen-browser.app/install.sh)
bash <(curl https://updates.zen-browser.app/appimage.sh)

# Verify installations
echo "Installation complete!"
fzf --version
zoxide --version
alacritty --version
nvim --version
tmux -V
gnome-tweaks --version
lazygit --version
rg --version
fd --version
stow --version
echo "Nerd Fonts installed in ~/.local/share/fonts"
echo "Zen Browser installation complete."
