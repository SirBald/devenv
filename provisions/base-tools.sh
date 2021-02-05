#!/bin/sh

echo "[SCRIPT] Install base development tools."

apt-get update

echo "[STEP] Install Git."
apt-get install --yes git

echo "[STEP] Use 'aspell' spellchecker in 'nano' editor."
apt-get install --yes aspell
NANO_CONFIG='/etc/nanorc'
ASPELL_COMMAND='set speller "aspell -x -c"'
if ! grep -Fxq "${ASPELL_COMMAND}" "${NANO_CONFIG}"; then
  echo "\n" >> "${NANO_CONFIG}"
  echo "${ASPELL_COMMAND}" >> "${NANO_CONFIG}"
fi

echo "[STEP] Bash prompt enchantments."
BASHRC_FILE='/home/vagrant/.bashrc'
BASHRC_ENHANCEMENT_FILE='/home/vagrant/.bashrc-enhancements'
BASHRC_ENHANCEMENT_COMMAND="source ${BASHRC_ENHANCEMENT_FILE}"
if [ -f "${BASHRC_ENHANCEMENT_FILE}" ]; then
  if ! grep -Fxq "${BASHRC_ENHANCEMENT_COMMAND}" "${BASHRC_FILE}"; then
    echo "\n" >> "${BASHRC_FILE}"
    echo "${BASHRC_ENHANCEMENT_COMMAND}" >> "${BASHRC_FILE}"
  fi
fi
