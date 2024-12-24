#!/bin/bash
if pgrep -f alto; then
    waydroid session stop
fi

weston --width=1920 --height=1080 &
weston_pid=$!
sleep 0.005

waydroid show-full-ui &
sleep 11

waydroid app launch com.noodlecake.altosadventure
wait $weston_pid

waydroid session stop
