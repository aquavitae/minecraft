#!/bin/bash

set -eo pipefail

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

function rc() {
  set +eo pipefail

  echo ">>> rclone $@"
  output=$(rclone $@ 2>&1 | grep -P "^<3>ERROR : " | grep -v 'SetModTime: 550 Not enough privileges')
  if [ "$output" != "" ]; then
    echo "$output"
    return 1
  fi
}

# rc purge :ftp:development_behavior_packs
# rc purge :ftp:development_resource_packs
# rc mkdir :ftp:development_behavior_packs
# rc mkdir :ftp:development_resource_packs

function rccopy() {
  local src
  local dest
  src=$1
  dest=$2

  for dir in $(find "$src" -type d ); do
    echo "Creating $dest/$dir"
    # rc mkdir $dest/$dir
  done

  echo "Copy $src $dest"
  # rc copy --retries=1 $src $dest

}

for path in addons/*; do
  f="$(basename $path)"
  # rc mkdir :ftp:development_behavior_packs/$f
  rccopy ./addons/$f/behavior :ftp:development_behavior_packs/$f
  # rc mkdir :ftp:development_resource_packs/$f
  rccopy ./addons/$f/resource :ftp:development_resource_packs/$f
done

rccopy world :ftp:worlds/Legoland
rccopy settings :ftp:
