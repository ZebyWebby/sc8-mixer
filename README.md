# SC8 Mixer

A tiny Qt control panel for the **Fifine SC8** USB mixer on Linux, a lightweight stand-in for Fifine Genie.

![](https://img.shields.io/badge/PyQt5-Linux-blue)

## The problem

The SC8 exposes two playback devices (`hw:Chat,0` = Game, `hw:Chat,1` = Chat), but PipeWire's
default profile only uses the first one, so you get just one output. The Chat channel's hardware
volume may also be stuck at 10% (−20 dB) if it was never set by Fifine Genie.

## What's here

| File | Purpose |
|---|---|
| `sc8-mixer` | Qt GUI: Game / Chat / Mic hardware volume + mute, "set Game as default", save levels |
| `config/60-fifine-sc8-second-output.conf` | PipeWire: adds a **Fifine SC8 Chat** sink for `hw:Chat,1` |
| `config/60-fifine-sc8-rename.conf` | WirePlumber: renames the stock sink to **Fifine SC8 Game** |
| `install.sh` | Copies everything into `~/.local` / `~/.config` and restarts PipeWire |

## Install

Requires PipeWire + WirePlumber, `alsa-utils` (amixer), `python-pyqt5`.

```sh
git clone git@github.com:ZebyWebby/sc8-mixer.git
cd sc8-mixer && ./install.sh
```

Then in Discord: Settings → Voice & Video → Output Device → **Fifine SC8 Chat**.

## Notes

- The Game sink name and the rename rule include the device serial
  (`MV-SILICON_fifine_Chat_20190808`). If your unit differs, check `pactl list short sinks`
  and update `GAME_SINK` in `sc8-mixer` and the match in `config/60-fifine-sc8-rename.conf`.
- "Save levels" runs `pkexec alsactl store` so hardware volumes are restored on boot.

## Uninstall

```sh
rm ~/.local/bin/sc8-mixer ~/.local/share/applications/sc8-mixer.desktop \
   ~/.config/pipewire/pipewire.conf.d/60-fifine-sc8-second-output.conf \
   ~/.config/wireplumber/wireplumber.conf.d/60-fifine-sc8-rename.conf
systemctl --user restart pipewire pipewire-pulse wireplumber
```
