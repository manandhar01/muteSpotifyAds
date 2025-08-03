#!/usr/bin/env bash

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
YELLOW=$'\033[1;33m'
RESET=$'\033[0m'

script_file="$HOME/bin/mute_spotify_ads.sh"
service_file="$HOME/.config/systemd/user/mute-spotify-ads.service"

function install() {
    printf "\n%s🛠️ Installing...%s\n\n" "$GREEN" "$RESET"

    mkdir -p "$(dirname "$script_file")"
    mkdir -p "$(dirname "$service_file")"

    cp "./mute_spotify_ads.sh" "$script_file"
    printf "%s✅ Installed script: %s%s\n" "$GREEN" "$script_file" "$RESET"

    cp "./mute-spotify-ads.service" "$service_file"
    printf "%s✅ Installed service: %s%s\n" "$GREEN" "$service_file" "$RESET"

    printf "%s🛠️ Enabling service...%s\n" "$GREEN" "$RESET"
    systemctl --user daemon-reload

    printf "%s" "$YELLOW"
    systemctl --user enable --now mute-spotify-ads.service
    printf "%s" "$RESET"

    printf "\n%s💯 Installation Complete%s\n\n" "$GREEN" "$RESET"
}

function remove() {
    printf "\n%s🚮 Removing...%s\n\n" "$RED" "$RESET"

    printf "%s🛠️ Disabling service...%s\n" "$GREEN" "$RESET"

    printf "%s" "$YELLOW"
    systemctl --user disable --now mute-spotify-ads.service
    printf "%s" "$RESET"

    systemctl --user daemon-reload

    rm "$service_file"
    printf "%s🗑️ Deleted service: %s%s\n" "$RED" "$service_file" "$RESET"

    rm "$script_file"
    printf "%s🗑️ Deleted script: %s%s\n" "$RED" "$script_file" "$RESET"

    printf "\n%s💯 Removal Complete%s\n\n" "$RED" "$RESET"
}

printf "\n%s👉 Please select an operation:%s\n" "$GREEN" "$RESET"
printf " 1) 🛠️ Install\n"
printf " 2) 🗑️ Remove\n"
printf " 0) ❌ Exit\n\n"

read -rp "${YELLOW}🔢 Enter a number: ${RESET}" operation

if [[ "$operation" -eq 0 ]]; then
    printf "\n%s🚶🏼‍♂️ Exiting%s\n\n" "$RED" "$RESET"
    exit 0
elif [[ "$operation" -ne 1 && "$operation" -ne 2 ]]; then
    printf "\n%s❗ Invalid input. 🚶🏼‍♂️ Exiting.%s\n\n" "$RED" "$RESET" >&2
    exit 1
fi

if [ "$operation" -eq 1 ]; then
    install
else
    remove
fi
