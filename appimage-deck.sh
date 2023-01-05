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
