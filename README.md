# Irrennix
This is Irrennix. It builds on a so-called 'Irrenflake' - which is an abhorrent amalgamation of German and English mashed together into one word, which is a crime in itself already. A system built on such sin can therefore only be most stable and reasonable.

Or in other words, I have no idea what I am doing and the more sophisticated mind will probably get an aneurism if they stare at this too long.

## Snippets
Because why would I trust my memory to keep track of a few simple commands?

### Formatting
`nix fmt`

### Flake Update
`nix flake update`

### Nix/Flake Rebuild
`sudo nixos-rebuild switch --flake .#[hostname]`

### Firmware Updates
`fwupdmgr`

### List packages installed in system profile
`nix search wget`

## Troubleshooting
It is the number one law of software that things break and go wrong. This might prevent some future mild annoyance.

### Buggy GUI for Chromium/Electron apps
For some reason, the GUI for Electron-based apps like VSCodium and Cider can become extremely buggy sometimes - this seems to be a Chromium issue, see [here](https://github.com/electron/electron/issues/40366) and [here](https://chromium-review.googlesource.com/c/chromium/src/+/4988290). In any case, the GUI can usually be fixed by deleting some GPU-cache-directories for the affected app:

`rm -r ~/.config/<APPNAME>/GPUCache ~/.config/<APPNAME>/Crashpad`