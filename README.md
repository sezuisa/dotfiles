# Irrennix
This is Irrennix. It builds on a so-called 'Irrenflake' - which is an abhorrent amalgamation of German and English mashed together into one word, which is a crime in itself already. A system built on such sin can therefore only be most stable and reasonable.

Or in other words, I have no idea what I am doing and the more sophisticated mind will probably get an aneurism if they stare at this too long.

## Theme
This config follows a general design theme - fittingly named `Sezziato` to combine two things that define me: my username and a caffeine addiction. The theme is defined [here](theme/sezziato.md).

## Snippets
Because why would I trust my memory to keep track of a few simple commands?

### Formatting
`nix fmt`

### Flake Update
`nix flake update`

### Clonerer
The `clonerer` is a shitty bash script, which clones the defined git repos and adds the given git remotes to them.
`clonerer`

### Nix/Flake Rebuild
`sudo nixos-rebuild switch --flake .#[hostname]`

### Firmware Updates
`fwupdmgr`

### List packages installed in system profile
`nix search wget`

### Fingerprint authentication

```bash
# add fingerprint
sudo fprintd-enroll sez

# verify fingerprint
sudo fprintd-verify sez
```

### agenix
``` bash
# make sure to be in secrets directory
cd secrets

# create/edit secrets file
agenix -e <file>

# Re-key files, use if public keys have been changed
agenix -r
```

## Troubleshooting
It is the number one law of software that things break and go wrong. This might prevent some future mild annoyance.

### Buggy GUI for Chromium/Electron apps
For some reason, the GUI for Electron-based apps like VSCodium and Cider can become extremely buggy sometimes - this seems to be a Chromium issue, see [here](https://github.com/electron/electron/issues/40366) and [here](https://chromium-review.googlesource.com/c/chromium/src/+/4988290). In any case, the GUI can usually be fixed by deleting some GPU-cache-directories for the affected app:

`rm -r ~/.config/<APPNAME>/GPUCache ~/.config/<APPNAME>/Crashpad`

### Problems with missing files after garbage collection
Try a nix-store repair, then try rebuilding the system again:

`sudo nix-store --repair --verify --check-contents`
