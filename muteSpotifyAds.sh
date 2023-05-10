#!/usr/bin/env bash

mutedByScript=0
initial_volume="$(playerctl -p spotify volume 2> /dev/null | echo 1)"
while true
do
	if pgrep -x "spotify" > /dev/null; then
		status="$(playerctl -p spotify status)"
		if [ "$status" = "Playing" ]; then
			title="$(playerctl -p spotify metadata -f '{{title}}')"
			if [ "$title" = "Advertisement" ]; then
				if (( $(echo "`playerctl -p spotify volume` > 0" | bc -l) )); then
					initial_volume="$(playerctl -p spotify volume)"
					playerctl -p spotify volume 0
					mutedByScript=1
				fi
			else
				if [ $mutedByScript -eq 1 ]; then
					playerctl -p spotify volume $initial_volume
					mutedByScript=0
				fi
			fi
		fi
	fi
	sleep 2
done
