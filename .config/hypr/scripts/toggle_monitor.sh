#!/usr/bin/env bash

MONITOR="$1"

if [ -z "$MONITOR" ]; then
    exit 1
fi

if [ "$MONITOR" = "DP-1" ]; then
    CONFIG="$MONITOR, 2560x1440@144, 0x0, 1, transform, 1"
elif [ "$MONITOR" = "DP-3" ]; then
    CONFIG="$MONITOR, 2560x1440@144, 1440x560, 1"
else
    exit 1
fi

# On compte combien d'écrans sont actuellement allumés
ACTIVE_MONITORS=$(hyprctl monitors | grep -c "Monitor ")

if hyprctl monitors | grep -q "Monitor $MONITOR"; then
    if [ "$ACTIVE_MONITORS" -le 1 ]; then
        exit 1
    fi
    hyprctl keyword monitor "$MONITOR, disable"
else
    hyprctl keyword monitor "$CONFIG"
fi
