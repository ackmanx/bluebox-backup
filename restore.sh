#!/usr/bin/env bash

. banners.sh

doRsync() {
    rsync \
        --verbose \
        --archive \
        --human-readable \
        --delete \
        --delete-excluded \
        --force \
        --exclude '.DS_Store' \
        --exclude '.dropbox*' \
        --exclude 'Icon?' \
        "${SOURCE_DIR}" \
        "${TARGET_DIR}"
}

warn() {
  echo 'This will mirror...'
  echo ''
  echo '/Volumes/BlueBox/Backup/Dropbox to /Volumes/Storage/Dropbox'
  echo ''

  echo 'Continue?'

  read answer

  if [ $answer != 'y' ]; then
    echo "Aborting."
    exit 1
  fi
}

warn

musik
SOURCE_DIR='/Volumes/BlueBox/Backup/Dropbox'
TARGET_DIR='/Volumes/Storage'
doRsync

#-e enables interpretation of certain backslash-escaped characters, like my \t in there
echo -e "restore\t$(hostname)\t$(date)" >> /Volumes/BlueBox/Backup/updates.txt
