#!/bin/bash

# Source all apps
source ~/.appimage-deck/application-list.sh

# Tried making this dynamic but it didn't work as expected. Will see if I can fix.
binTable=()
binTable+=(FALSE "Discord")
binTable+=(FALSE "Firefox")
binTable+=(FALSE "LibreOffice")
binTable+=(FALSE "OnlyOffice")
binTable+=(FALSE "Thunderbird")
binTable+=(FALSE "Ungoogled Chromium")
binTable+=(FALSE "VSCodium")

#Binary selector
text="$(printf "Which AppImages would you like to install?\n\nThis tool will overwrite existing AppImages with the newest available.\n\nAll settings should be retained.")"
appList=$(
    zenity --list \
    --title="AppImage Deck" \
    --height=460 \
    --width=200 \
    --ok-label="OK" \
    --cancel-label="Exit" \
    --text="${text}" \
    --checklist \
    --column="Select" \
    --column="Name" \
    --print-column=2 \
    "${binTable[@]}" 2>/dev/null
)
ans=$?
messages=()
if [ $ans -eq 0 ]; then
    echo $appList
    awk -F'|' '{print NF}' <<<"$appList"
    let progresspct=0

        # Tried making this a for loop but it broke :(
        echo "User selected: $appList"
        if [[ "$appList" == *"Discord"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating Discord"
            if discord_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("Discord Updated Successfully")
            else
                messages+=("There was a problem updating Discord")
            fi
        fi
        if [[ "$appList" == *"Firefox"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating Firefox"
            if firefox_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("Firefox Updated Successfully")
            else
                messages+=("There was a problem updating Firefox")
            fi
        fi
        if [[ "$appList" == *"LibreOffice"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating LibreOffice"
            if libreoffice_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("LibreOffice Updated Successfully")
            else
                messages+=("There was a problem updating LibreOffice")
            fi
        fi
        if [[ "$appList" == *"OnlyOffice"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating OnlyOffice"
            if onlyoffice_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("OnlyOffice Updated Successfully")
            else
                messages+=("There was a problem updating OnlyOffice")
            fi
        fi
        if [[ "$appList" == *"Thunderbird"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating Thunderbird"
            if thunderbird_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("Thunderbird Updated Successfully")
            else
                messages+=("There was a problem updating Thunderbird")
            fi
        fi
        if [[ "$appList" == *"Ungoogled Chromium"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating Ungoogled Chromium"
            if ungoogledchromium_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("Ungoogled Chromium Updated Successfully")
            else
                messages+=("There was a problem updating Ungoogled Chromium")
            fi
        fi
        if [[ "$appList" == *"VSCodium"* ]]; then
            ((progresspct+=$pct))
            echo "$progresspct"
            echo "# Updating VSCodium"
            if vscodium_install 2>&1 | stdbuf -oL tr '\r' '\n' | sed -u 's/^ *\([0-9][0-9]*\).*\( [0-9].*$\)/\1\n#Download Speed\:\2/' | zenity --progress --title "Downloading" --width 600 --auto-close --no-cancel 2>/dev/null; then
                messages+=("VSCodium Updated Successfully")
            else
                messages+=("There was a problem updating VSCodium")
            fi
        fi

    if [ "$?" = -1 ]; then
        zenity --error \
        --text="Update canceled." 2>/dev/null
    fi
    if [[ ${#messages[@]} -gt 0 ]]; then
        zenity --list \
        --title="Update Status" \
        --text="" \
        --column="Messages" \
        "${messages[@]}" 2>/dev/null
    fi
fi

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
