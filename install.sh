#!/bin/bash

set -e -o pipefail
set -v

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

rclone purge --ignore-errors :ftp:development_behavior_packs
rclone purge --ignore-errors :ftp:development_resource_packs
rclone mkdir :ftp:development_behavior_packs
rclone mkdir :ftp:development_resource_packs

rclone mkdir :ftp:development_behavior_packs/Pets
rclone copy behavior :ftp:development_behavior_packs/Pets

for f in addons/*; do
    rclone copy ./addons/$f/behavior :ftp:development_behavior_packs/$f
    rclone copy ./addons/$f/resource :ftp:development_resource_packs/$f
done

rclone copy world :ftp:worlds/Legoland
rclone copy settings :ftp:
