#!/usr/bin/env bash
# Installs taildrop-send-for-thunar and adds "Send via Taildrop" to Thunar's Send To menu.
# Run with --uninstall to remove both.

set -euo pipefail

bin_dir="${XDG_BIN_HOME:-$HOME/.local/bin}"
sendto_dir="${XDG_DATA_HOME:-$HOME/.local/share}/Thunar/sendto"
script="$bin_dir/taildrop-send-for-thunar"
entry="$sendto_dir/taildrop-send-for-thunar.desktop"

if [[ ${1:-} == --uninstall ]]; then
    rm -fv "$script" "$entry"
    exit 0
fi

for cmd in tailscale zenity zip dd notify-send; do
    command -v "$cmd" >/dev/null || echo "warning: $cmd not found" >&2
done

install -Dm755 "$(dirname "$0")/taildrop-send-for-thunar" "$script"
# Point Exec at the installed script, since ~/.local/bin may not be on Thunar's PATH.
mkdir -p "$sendto_dir"
sed "s|^Exec=taildrop-send-for-thunar |Exec=\"$script\" |" \
    "$(dirname "$0")/taildrop-send-for-thunar.desktop" >"$entry"

echo "Installed $script"
echo "Installed $entry"
echo "Restart Thunar (thunar -q) if the entry doesn't show up."
