# Ublue Custom &nbsp; [![build-ublue](https://github.com/legitcamper/ublue-hyprland/actions/workflows/build.yml/badge.svg)](https://github.com/legitcamper/ublue-hyprland/actions/workflows/build.yml)

## Flavors
Both have Capuccin Themes preinstalled and some of my preferred installed apps
- Hyprland
- Sway
- Niri

## Themes
- Catppuccin is preinstalled in 2 directories for both gtk and qt 
#### Gtk
- themes are located in `/usr/share/themes/`
- can be applied with `GTK_THEME=Catppuccin-Macchiato-Standard-Lavender-Dark`
#### Qt/Kvantum
- themes are located in `/usr/share/Kvantum/`
- ensure to set `QT_QPA_PLATFORMTHEME=kvantum` and either  launch Kvantum and change the theme, or edit the `~/.config/Kvantum/kvantum.kvconfig`

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/legitcamper/ublue-hyprland:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/legitcamper/ublue-hyprland:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

```
IMAGE_REPO=ghcr.io/legitcamper
IMAGE_NAME=ublue-hyprland
IMAGE_TAG=latest
IMAGE_VARIANT=Silverblue
INSTALLER_VERSION=43

sudo podman run --rm --privileged --volume .:/isogenerator/output --security-opt label=disable --pull=newer \
-e IMAGE_REPO="$IMAGE_REPO" -e IMAGE_NAME="$IMAGE_NAME" -e IMAGE_TAG="$IMAGE_TAG" -e VARIANT="$IMAGE_VARIANT" \
ghcr.io/ublue-os/isogenerator:$INSTALLER_VERSION
```

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/legitcamper/ublue-hyprland
```
