#!/bin/bash

# colors
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m"
GREEN="\033[0;32m"

# select package manager and fill INSTALL_ITEMS
if command -v apt; then
  echo -e "${BLUE}==> ${GREEN} Using apt${NC}"
  PACKAGE_INSTALL="sudo apt install -y "
  echo -e "${BLUE}==> ${GREEN} Updating packages...${NC}"
  sudo apt update && sudo apt upgrade -y
  INSTALL_ITEMS="neovim gh git fzf make nodejs cargo gcc zip python3 npm lazygit libreoffice lollypop "\
    "kitty audacity filezilla vlc gimp"
  $PACKAGE_INSTALL $INSTALL_ITEMS
elif command -v yay; then
  echo -e "${BLUE}==> ${GREEN} Using yay${NC}"
  PACKAGE_INSTALL="sudo yay -S --noconfirm "
  echo -e "${BLUE}==> ${GREEN} Updating packages...${NC}"
  yay -Syu
  INSTALL_ITEMS="tmux nvim github-cli git fzf make nodejs cargo gcc zip python3 npm lazygit zen-browser-bin libreoffice-fresh lollypop obsidian pycharm-community-edition intellij-idea-community-edition kitty telegram-desktop audacity discord postman-bin prismlauncher filezilla vlc gimp"
  $PACKAGE_INSTALL $INSTALL_ITEMS
elif command -v pacman; then
  echo -e "${BLUE}==> ${GREEN} Using pacman${NC}"
  PACKAGE_INSTALL="sudo pacman -S --noconfirm "
  echo -e "${BLUE}==> ${GREEN} Updating packages...${NC}"
  sudo pacman -Syu
  INSTALL_ITEMS="tmux nvim github-cli git fzf make nodejs cargo gcc zip python3 npm lazygit zen-browser-bin libreoffice-fresh lollypop "\
    "obsidian pycharm-community-edition intellij-idea-community-edition kitty telegram-desktop audacity discord" \ 
    "prismlauncher filezilla vlc gimp"
  $PACKAGE_INSTALL $INSTALL_ITEMS
else
  echo -e "${RED} ==> ${NC} Couldnt find any supported package manager"
  exit 1
fi

if [ "$PACKAGE_INSTALL" = "sudo apt install -y " ]; then
  SNAP_PACKAGES="obsidian telegram discord postman"
  echo -e "${BLUE} ==> ${GREEN} These packages are not available through apt, but can be installed with snap:"
  for package in $SNAP_PACKAGES; do
    echo "${BLUE} ==> ${NC} $package"
  done
  read -p "${BLUE} ==> ${GREEN} Do you want to install them? (y/N)${NC}" confirm
  if [[ $confirm == [Yy] || $confirm == [Yy][Ee][Ss] ]]; then
    $PACKAGE_INSTALL snapd
    sudo snap install $SNAP_PACKAGES
  fi
  read - p "do you want to install pycharm? (This will launch the app immediately as well) (y/N)" confirm
  if [[ $confirm == [Yy] || $confirm == [Yy][Ee][Ss] ]]; then
    curl --output pycharm.tar.gz "https://download.jetbrains.com/python/pycharm-2025.3.1.tar.gz"
    sudo tar xzf pycharm.tar.gz -C /opt/
    cd /opt/pycharm-2022.2.4/bin
    ./pycharm
  fi
  read - p "Zen Browser can only be installed through flathub, do you want to install it? (y/N)" confirm
  if [[ $confirm == [Yy] || $confirm == [Yy][Ee][Ss] ]]; then
    $PACKAGE_INSTALL flatpak
    sudo flatpak install flathub app.zen_browser.zen
    sudo mkdir -p /usr/local/share/applications
    sudo printf "%s\n" \
    "[Desktop Entry]" \
    "Version=1.0" \
    "Name=Zen Browser" \
    "Comment=Experience tranquillity while browsing the web without people tracking you!" \
    "GenericName=Web Browser" \
    "Keywords=Internet;WWW;Browser;Web;Explorer" \
    "Exec=flatpak run app.zen_browser.zen" \
    "Terminal=false" \
    "X-MultipleArgs=false" \
    "Type=Application" \
    "Icon=/opt/zen/browser/chrome/icons/default/default128.png" \
    "Categories=GNOME;GTK;Network;WebBrowser;" \
    "MimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;" \
    "StartupNotify=true" \
    >> /usr/local/share/applications/zen.desktop
  fi
elif [ "$PACKAGE_INSTALL" = "sudo pacman -S --noconfirm " ]; then
  AUR_PACKAGES="postman-bin"
  echo -e "${BLUE} ==> ${GREEN} These packages are not available through pacman, but can be installed with yay:"
  for package in $AUR_PACKAGES; do
    echo "${BLUE} ==> ${NC} $package"
  done
  read -p "${BLUE} ==> ${GREEN} Do you want to install them? (y/N)${NC}" confirm
  if [[ $confirm == [Yy] || $confirm == [Yy][Ee][Ss] ]]; then
    sudo pacman -S yay
    yay -S $AUR_PACKAGES
  fi
fi

read -p "Steam can only be installed through flatpak, do you want to install it? (y/N)" confirm
if [[ $confirm == [Yy] || $confirm == [Yy][Ee][Ss] ]]; then
  $PACKAGE_INSTALL flatpak
  flatpak install flathub com.valvesoftware.Steam
  printf "%s\n" \
  "[Desktop Entry]" \
  "Name=Steam" \
  "Comment=Application for managing and playing games on Steam" \
  "Exec=flatpak run com.valvesoftware.Steam %U" \
  "Icon=/var/lib/flatpak/exports/share/icons/hicolor/256x256/apps/com.valvesoftware.Steam.png" \
  "Terminal=false" \
  "Type=Application" \
  "Categories=Game;Network;" \
  "MimeType=x-scheme-handler/steam;" \
  "StartupNotify=true" \
  "StartupWMClass=Steam" \
  >> /usr/local/share/applications/steam.desktop
fi

echo -e "${BLUE} ==> ${GREEN} Successfully finished setup script!${NC}"

