#!/usr/bin/env bash

username="$(whoami)"
scriptDirectory="/home/$username/bin"
scriptFile="$scriptDirectory/muteSpotifyAds.sh"
serviceDirectory="/home/$username/.config/systemd/user"
serviceFile="$serviceDirectory/muteSpotifyAds.service"

mkdir -p "$scriptDirectory"
cp "./muteSpotifyAds.sh" "$scriptFile"
echo "copied script file to $scriptFile"
mkdir -p "$serviceDirectory"
echo -e "[Unit]\nDescription=Mute Spotify Ads\nAfter=graphical-session.target\n" > "$serviceFile"
echo -e "[Service]\nType=forking\nExecStartPre=/bin/bash -c \"$scriptFile & disown \$!\"\nExecStart=/bin/true\nRestart=always\n" >> "$serviceFile"
echo -e "[Install]\nWantedBy=graphical-session.target" >> "$serviceFile"
echo "created service file for user $username in $serviceFile"

systemctl --user daemon-reload
systemctl --user enable --now muteSpotifyAds.service
echo "Installation successful"
