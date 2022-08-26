#!/bin/bash

set -e -o pipefail
set -v

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

rclone purge :ftp:behavior_packs
rclone mkdir :ftp:behavior_packs/Pets
rclone copy behavior :ftp:behavior_packs/Pets

for f in addons/*; do
    rclone copy ./addons/$f/behavior :ftp:behavior_packs/$f
    rclone copy ./addons/$f/resource :ftp:resource_packs/$f
done

rclone copy world :ftp:worlds/Legoland
rclone copy settings :ftp:
