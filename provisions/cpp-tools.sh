#!/bin/sh

echo "[SCRIPT] Install CPP with related tools."

apt-get update

apt-get install --yes cmake
apt-get install --yes g++
