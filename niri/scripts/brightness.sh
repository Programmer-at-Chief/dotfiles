#!/usr/bin/env bash

set -euo pipefail

LOCKFILE="${XDG_RUNTIME_DIR}/brightness-notify.lock"

# Prevent multiple key presses from running the script simultaneously.
exec 9>"$LOCKFILE"
flock -x 9

# Change brightness.
case "${1:-}" in
    up)
        brightnessctl --class=backlight set +5%
        ;;
    down)
        brightnessctl --class=backlight set 5%-
        ;;
    *)
        echo "Usage: $0 {up|down}" >&2
        exit 1
        ;;
esac

# Get current brightness percentage.
brightness="$(
    brightnessctl --class=backlight -m |
    awk -F',' '{gsub("%", "", $4); print $4}'
)"

# Safety clamp.
(( brightness < 0 )) && brightness=0
(( brightness > 100 )) && brightness=100

# Pick an icon based on brightness level.
if (( brightness <= 10 )); then
    icon="display-brightness-off-symbolic"
elif (( brightness <= 35 )); then
    icon="display-brightness-low-symbolic"
elif (( brightness <= 65 )); then
    icon="display-brightness-medium-symbolic"
else
    icon="display-brightness-high-symbolic"
fi

# Send notification.
# Mako uses the x-canonical-private-synchronous hint
# to replace the previous brightness notification.
notify-send \
    --app-name="brightness" \
    --hint="string:x-canonical-private-synchronous:brightness" \
    --hint="int:value:${brightness}" \
    --icon="$icon" \
    "Brightness" \
    "${brightness}%"
