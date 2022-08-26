#!/bin/bash

set -e -o pipefail
set -v

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

rclone purge :ftp:development_behavior_packs || 0
rclone purge :ftp:development_resource_packs || 0
rclone mkdir :ftp:development_behavior_packs || 0
rclone mkdir :ftp:development_resource_packs || 0

rclone mkdir :ftp:development_behavior_packs/Pets
rclone copy behavior :ftp:development_behavior_packs/Pets || 0

for f in addons/*; do
    rclone copy ./addons/$f/behavior :ftp:development_behavior_packs/$f || 0
    rclone copy ./addons/$f/resource :ftp:development_resource_packs/$f || 0
done

rclone copy world :ftp:worlds/Legoland || 0
rclone copy settings :ftp: || 0
