#!/usr/bin/env bash

doRsync() {
    rsync \
        --verbose \
        --archive \
        --human-readable \
        --delete \
        --exclude '.DS_Store' \
        --exclude '.dropbox*' \
        --exclude 'Icon?' \
        "${SOURCE_DIR}" \
        "${TARGET_DIR}"
}

warn() {
  echo 'This will mirror...'
  echo ''
  echo '/Volumes/BlueBox/Backup/Musik to /Volumes/Storage/Musik'
  echo '/Volumes/BlueBox/Backup/Meine Fotos to /Volumes/Storage/Meine Fotos'
  echo ''

  echo 'Continue?'

  read answer

  if [ $answer != 'y' ]; then
    echo "Aborting."
    exit 1
  fi
}

warn

SOURCE_DIR='/Volumes/BlueBox/Backup/Musik'
TARGET_DIR='/Volumes/Storage'
doRsync

SOURCE_DIR='/Volumes/BlueBox/Backup/Meine Fotos'
TARGET_DIR='/Volumes/Storage'
doRsync

hostname=`hostname`
date=`date`
#-e enables interpretation of certain backslash-escaped characters
echo -e "restore\t${hostname}\t${date}" >> /Volumes/BlueBox/Backup/updates.txt
