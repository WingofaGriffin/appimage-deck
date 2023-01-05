#!/bin/bash

# Helper function to install App Images
installAI(){		
	name=$1
	url=$2	
	echo "Installing $name from $url"

    if test -f "$HOME/Desktop/$name.AppImage" ; then
        echo Deleting old file...
        rm -f "$HOME/Desktop/$name.AppImage"
    fi
    mkdir -p "$HOME/Desktop"
    echo "Downloading new file..."
    curl -L "$url" -o "$HOME/Desktop/$name.AppImage.temp"  && mv "$HOME/Desktop/$name.AppImage.temp" "$HOME/Desktop/$name.AppImage" 
	chmod +x "$HOME/Desktop/$name.AppImage"
    echo "Done!"
}

discord_install(){
    git_url='https://api.github.com/repos/srevinsaju/discord-appimage/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[] | select(.tag_name=="stable").assets[0].browser_download_url][0]')
    installAI 'Discord' $url
}

firefox_install(){ 
    git_url='https://api.github.com/repos/srevinsaju/Firefox-Appimage/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[] | select(.tag_name=="firefox").assets[0].browser_download_url][0]')
    installAI 'Firefox' $url
}

libreoffice_install(){ 
    url='https://appimage.sys42.eu/LibreOffice-fresh.full-x86_64.AppImage'
    installAI 'LibreOffice' $url
}

onlyoffice_install(){
    git_url='https://api.github.com/repos/ONLYOFFICE/DesktopEditors/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[].assets[] | select(.name | endswith("'".AppImage"'")).browser_download_url ][0]')
    installAI 'OnlyOffice' $url
}

thunderbird_install(){ 
    git_url='https://api.github.com/repos/srevinsaju/thunderbird-appimage/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[] | select(.tag_name=="stable").assets[0].browser_download_url][0]')
    installAI 'Thunderbird' $url
}

ungoogledchromium_install(){ 
    git_url='https://api.github.com/repos/clickot/ungoogled-chromium-binaries/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[].assets[] | select(.name | endswith("'".AppImage"'")).browser_download_url ][0]')
    installAI 'Ungoogled Chromium' $url
}

vscodium_install(){
    git_url='https://api.github.com/repos/VSCodium/vscodium/releases'
    url=$(curl -fSs "$git_url" | \
    jq -r '[ .[].assets[] | select(.name | endswith("'".AppImage"'")).browser_download_url ][0]')
    installAI 'VSCodium' $url
}
