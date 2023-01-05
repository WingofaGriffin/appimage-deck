#!/bin/bash

# Remove directory if present
rm -rf "$HOME/.appimage-deck" &>/dev/null

# Create a hidden directory for the script
mkdir -p "$HOME/.appimage-deck" &>/dev/null

# Install Scripts
git clone https://github.com/WingofaGriffin/appimage-deck.git ~/.appimage-deck

# Create Desktop icons
rm -rf ~/Desktop/AppImageDeckUninstall.desktop 2>/dev/null
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Uninstall AppImageDeck
Exec=bash $HOME/.appimage-deck/uninstall.sh
Icon=delete
Terminal=true
Type=Application
StartupNotify=false' > ~/Desktop/UninstallAppImageDeck.desktop
chmod +x ~/Desktop/UninstallAppImageDeck.desktop

rm -rf ~/Desktop/AppImageDeck.desktop 2>/dev/null
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=AppImageDeck
Exec=bash $HOME/.appimage-deck/appimage-deck.sh
Icon=folder-appimage
Terminal=true
Type=Application
StartupNotify=false' > ~/Desktop/AppImageDeck.desktop
chmod +x ~/Desktop/AppImageDeck.desktop

rm -rf ~/Desktop/UpdateAppImageDeck.desktop 2>/dev/null
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Name=Update AppImageDeck
Exec=bash $HOME/.appimage-deck/install.sh
Icon=update-none
Terminal=true
Type=Application
StartupNotify=false' > ~/Desktop/UpdateAppImageDeck.desktop
chmod +x ~/Desktop/UpdateAppImageDeck.desktop
