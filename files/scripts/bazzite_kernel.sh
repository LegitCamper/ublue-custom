#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail
  
ARCH="$(uname -m)"
REPO="https://api.github.com/repos/bazzite-org/kernel-bazzite/releases/latest"
LATEST=$(curl -sL "$REPO")

RPM_URLS=$(echo "$LATEST" \
    | grep "browser_download_url" \
    | grep ".rpm" \
    | grep "fc43" \
    | grep "$ARCH" \
    | grep -E "kernel(-(core|modules|modules-core|modules-extra|headers|devel))?-[0-9]" \
    | cut -d '"' -f 4)

# Figure out the newest Fedora release in this batch (fc42, fc43, etc.)
LATEST_FC=$(echo "$RPM_URLS" | grep -o "fc[0-9]\+" | sort -V | tail -n1)

RPM_URLS=$(echo "$RPM_URLS" | grep "$LATEST_FC")

WORKDIR="/tmp/bazzite-kernel"
mkdir -p "$WORKDIR"
cd "$WORKDIR"


for url in $RPM_URLS; do
    echo " - $url"
    curl -sL -O "$url"
done

rpm-ostree override replace "$WORKDIR"/*.rpm
