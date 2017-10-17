#!/usr/bin/env bash

. banners.sh

musik
diff \
  --recursive \
  --exclude='.DS_Store' \
  '/Volumes/Storage/Musik' \
  '/Volumes/BlueBox/Backup/Musik'

meineFotos
diff \
  --recursive \
  --exclude='.DS_Store' \
  '/Volumes/Storage/Meine Fotos' \
  '/Volumes/BlueBox/Backup/Meine Fotos'
