#!/usr/bin/env bash

MONITOR="$1"

if [ -z "$MONITOR" ]; then
    echo "Erreur : Tu dois préciser un moniteur (DP-1 ou DP-3)."
    exit 1
fi

if [ "$MONITOR" = "DP-1" ]; then
    CONFIG="$MONITOR, 2560x1440@144, 0x0, 1, transform, 1"
elif [ "$MONITOR" = "DP-3" ]; then
    CONFIG="$MONITOR, 2560x1440@144, 1440x560, 1"
else
    echo "Erreur : Moniteur non reconnu."
    exit 1
fi

# On compte combien d'écrans sont actuellement allumés
ACTIVE_MONITORS=$(hyprctl monitors | grep -c "Monitor ")

if hyprctl monitors | grep -q "Monitor $MONITOR"; then
    # Avant de désactiver, on vérifie si c'est le dernier écran allumé
    if [ "$ACTIVE_MONITORS" -le 1 ]; then
        # Sécurité : on bloque l'action et on envoie une notification
        notify-send "Hyprland" "⚠️ Sécurité : Impossible d'éteindre le dernier écran !"
        exit 1
    fi
    # Si on a plus d'un écran, on peut le désactiver sereinement
    hyprctl keyword monitor "$MONITOR, disable"
else
    # On réactive l'écran
    hyprctl keyword monitor "$CONFIG"
fi
