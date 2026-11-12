#!/usr/bin/env bash
# Install SC8 Mixer + the PipeWire/WirePlumber configs that expose both SC8 outputs.
set -euo pipefail
cd "$(dirname "$0")"
install -Dm755 sc8-mixer "$HOME/.local/bin/sc8-mixer"
install -Dm644 sc8-mixer.desktop "$HOME/.local/share/applications/sc8-mixer.desktop"
sed -i "s|^Exec=.*|Exec=$HOME/.local/bin/sc8-mixer|" "$HOME/.local/share/applications/sc8-mixer.desktop"
install -Dm644 config/60-fifine-sc8-second-output.conf "$HOME/.config/pipewire/pipewire.conf.d/60-fifine-sc8-second-output.conf"
install -Dm644 config/60-fifine-sc8-rename.conf "$HOME/.config/wireplumber/wireplumber.conf.d/60-fifine-sc8-rename.conf"
systemctl --user restart pipewire pipewire-pulse wireplumber
echo "Installed. Launch 'SC8 Mixer' from your app menu."
