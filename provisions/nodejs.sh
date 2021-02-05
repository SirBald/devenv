#!/bin/sh

echo "[SCRIPT] Install Node.JS."

echo "[STEP] Add the NodeSource package signing key."
wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo "[STEP] Add the desired NodeSource repository."
VERSION=node_10.x
DISTRO="$(lsb_release -s -c)"
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | tee -a /etc/apt/sources.list.d/nodesource.list

echo "[STEP] Update package lists and install Node.js."
apt-get update
apt-get install -y nodejs
