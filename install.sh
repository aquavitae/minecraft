#!/bin/bash

set -eo pipefail

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

function rc() {
  set +eo pipefail

  echo ">>> rclone $@"
  output=$(rclone $@ | grep -P "^<3>ERROR : " | grep -v 'SetModTime: 550 Not enough privileges')
  if [ output != "" ]; then
    echo output
    return 1
  fi
}

rc purge :ftp:development_behavior_packs
rc purge :ftp:development_resource_packs
rc mkdir :ftp:development_behavior_packs
rc mkdir :ftp:development_resource_packs

for path in addons/*; do
  f="$(basename $path)"
  rc mkdir :ftp:development_behavior_packs/$f
  rc copy --retries=1 ./addons/$f/behavior :ftp:development_behavior_packs/$f
  rc mkdir :ftp:development_resource_packs/$f
  rc copy --retries=1 ./addons/$f/resource :ftp:development_resource_packs/$f
done

rc copy --retries=1 world :ftp:worlds/Legoland
rc copy --retries=1 settings :ftp:
