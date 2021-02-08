#!/bin/sh

echo '[SCRIPT] Install base development tools.'

apt-get update

echo '[STEP] Install Git.'
apt-get install --yes git

echo '[STEP] Install UnZip.'
apt-get install --yes unzip

echo '[STEP] Use Aspell spellchecker in Nano editor.'
apt-get install --yes aspell
NANO_CONFIG='/etc/nanorc'
ASPELL_COMMAND='set speller "aspell -x -c"'
if ! grep -Fxq "${ASPELL_COMMAND}" "${NANO_CONFIG}"; then
  echo '' | tee -a "${NANO_CONFIG}"
  echo "${ASPELL_COMMAND}" | tee -a "${NANO_CONFIG}"
fi

echo '[STEP] Bash prompt enchantments.'
HOME_DIR='/home/vagrant'
BASHRC_FILE="${HOME_DIR}/.bashrc"
BASHRC_ENHANCEMENT_FILE="${HOME_DIR}/.bashrc-enhancements"
BASHRC_ENHANCEMENT_COMMAND="source ${BASHRC_ENHANCEMENT_FILE}"
if [ -f "${BASHRC_ENHANCEMENT_FILE}" ]; then
  if ! grep -Fxq "${BASHRC_ENHANCEMENT_COMMAND}" "${BASHRC_FILE}"; then
    echo '' | tee -a "${BASHRC_FILE}"
    echo "${BASHRC_ENHANCEMENT_COMMAND}" | tee -a "${BASHRC_FILE}"
  fi
fi
