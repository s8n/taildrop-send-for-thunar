# taildrop-send-for-thunar

Adds a "Send via Taildrop" entry to Thunar's Send To menu. It opens a list of your Taildrop devices, and sends the selected files to the device you pick with `tailscale file cp`.

Folders are zipped before sending, since Taildrop only accepts files. You get a warning listing the zip files before that happens. A progress dialog shows overall progress across all selected files and can cancel the transfer, and a desktop notification is shown when it finishes.

## Requirements

- `tailscale`, with Taildrop (Send Files) enabled for your tailnet
- `zenity`
- `zip`
- `notify-send` (optional, for the notifications)

Your user needs to be able to run `tailscale file cp` without sudo. If it can't yet, set yourself as the operator:

```sh
sudo tailscale set --operator=$USER
```

## Install

```sh
./install.sh
```

This copies `taildrop-send-for-thunar` to `~/.local/bin` and writes `~/.local/share/Thunar/sendto/taildrop-send-for-thunar.desktop`. If the entry doesn't show up, restart Thunar with `thunar -q`.

To remove both:

```sh
./install.sh --uninstall
```

The script also works on its own: `taildrop-send-for-thunar FILE...`

## Notes

- Files are streamed to `tailscale file cp` through stdin so the progress bar can count bytes. Tailscale then doesn't know the file size up front, so the receiving device may not show its own progress.
- Offline devices are listed below online ones. Sending to one will usually fail with an error.
- Taildrop only sends between devices owned by the same user, and not to tagged devices.

## License

MIT, see [LICENSE](LICENSE).
