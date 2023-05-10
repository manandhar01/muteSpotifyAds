# Mute Spotify Ads

A script written in **bash** to mute Spotify Ads on Linux.

## Requirements

Ensure that the following tools are installed before installing the script.

- playerctl
- bc

### Note

Run the `install.sh` script only on system running systemd.

The `install.sh` script copies `muteSpotifyAds.sh` script to _/home/<user>/bin/_ and creates a systemd service `muteSpotifyAds.service` for the given user. The service is started and enabled by the script so the script runs in the background automatically on startup.

## Installation

Run `install.sh` bash script to install the script.

```bash
./install.sh
```
