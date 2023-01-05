#!/bin/bash

if zenity --question --title="Disclaimer" --text="This script will uninstall AppImage Deck.\n\n<b>Notice:</b> this will not remove downloaded AppImages. To remove those, simply delete the files from your desktop manually.\n\nProceed?" --width=600 2> /dev/null; then
    # Delete install directory
    rm -rf "$HOME/.appimage-deck"

    # Remove Desktop icons
    rm -rf ~/Desktop/UninstallAppImageDeck.desktop 2>/dev/null
    rm -rf ~/Desktop/AppImageDeck.desktop 2>/dev/null
    rm -rf ~/Desktop/UpdateAppImageDeck.desktop 2>/dev/null
fi
