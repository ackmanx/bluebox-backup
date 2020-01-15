#!/usr/bin/env bash

#If getting unknown file transfers, check the itemize column on the left for details.
#Even a different permission group will trigger a change

#Explanation of itemize-changes flags
#https://stackoverflow.com/questions/1113948/rsync-output#answer-7818340

. banners.sh

doRsync() {
    rsync \
        --verbose \
        --itemize-changes \
        --archive \
        --human-readable \
        --delete \
        --delete-excluded \
        --force \
        --exclude '.DS_Store' \
        --exclude '.dropbox' \
        --exclude 'Icon?' \
        --exclude 'node_modules' \
        "${SOURCE_DIR}" \
        "${TARGET_DIR}"
}

warn() {
  echo 'This will mirror...'
  echo ''
  echo '/Volumes/Storage/Dropbox to /Volumes/BlueBox/Backup/Dropbox'
  echo ''

  lastEntry=`tail -n 1 Backup/updates.txt`
  echo 'Last log entry:'
  echo $lastEntry
  echo ''

  if [[ $lastEntry == *"backup"* ]]; then
	echo 'WARNING! Last entry was a backup and not a restore. Backing up before restore may cause changes to be lost.'
  fi

  echo ''
  echo 'Continue?'

  read answer

  if [ $answer != 'y' ]; then
    echo "Aborting."
    exit 1
  fi
}

warn

dropbox
SOURCE_DIR='/Volumes/Storage/Dropbox'
TARGET_DIR='/Volumes/BlueBox/Backup'
doRsync

#-e enables interpretation of certain backslash-escaped characters, like my \t in there
echo -e "backup\t$(hostname)\t$(date)" >> /Volumes/BlueBox/Backup/updates.txt
