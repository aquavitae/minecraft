#!/bin/bash

set -e -o pipefail
set -v

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

rclone purge :ftp:development_behavior_packs || echo "ok"
rclone purge :ftp:development_resource_packs || echo "ok"
rclone mkdir :ftp:development_behavior_packs || echo "ok"
rclone mkdir :ftp:development_resource_packs || echo "ok"

rclone mkdir :ftp:development_behavior_packs/Pets
rclone copy behavior :ftp:development_behavior_packs/Pets || echo "ok"

for f in addons/*; do
    rclone copy ./addons/$f/behavior :ftp:development_behavior_packs/$f || echo "ok"
    rclone copy ./addons/$f/resource :ftp:development_resource_packs/$f || echo "ok"
done

rclone copy world :ftp:worlds/Legoland || echo "ok"
rclone copy settings :ftp: || echo "ok"
