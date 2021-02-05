#!/bin/sh

echo "[SCRIPT] Install .NET Core."

echo "[STEP] Add the Microsoft package signing key to your list of trusted keys and add the package repository."
wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
sudo dpkg -i /tmp/packages-microsoft-prod.deb

echo "[STEP] Install .NET Core SDK"
sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-5.0
