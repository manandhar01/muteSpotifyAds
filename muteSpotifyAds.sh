#!/usr/bin/env bash

mutedByScript=0
while true
do
	if pgrep -x "spotify" > /dev/null; then
		status="$(playerctl --player=spotify metadata --format '{{status}}')"
		if [ "$status" = "Playing" ]; then
			title="$(playerctl --player=spotify metadata --format '{{title}}')"
			if [ "$title" = "Advertisement" ]; then
				muteStatus="$(pactl get-sink-mute @DEFAULT_SINK@)"
				if [ "$muteStatus" = "Mute: no" ]; then
					pactl set-sink-mute @DEFAULT_SINK@ toggle
					mutedByScript=1
				fi
			else
				if [ $mutedByScript -eq 1 ]; then
					pactl set-sink-mute @DEFAULT_SINK@ toggle
					mutedByScript=0
				fi
			fi
		fi
	fi
	sleep 2
done
