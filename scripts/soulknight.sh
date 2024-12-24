#!/bin/bash
if pgrep -f ChillyRoom; then
    waydroid session stop
fi

weston --width=1920 --height=1080 &
weston_pid=$!
sleep 0.005

waydroid show-full-ui &
sleep 11

waydroid app launch com.ChillyRoom.DungeonShooter
wait $weston_pid

waydroid session stop
