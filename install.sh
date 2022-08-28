#!/bin/bash

set -e -o pipefail
set -v

curl https://rclone.org/install.sh | sudo bash

export RCLONE_FTP_PASS=$(rclone obscure "$PLAIN_PASSWORD")

rclone purge :ftp:development_behavior_packs || echo "ok"
rclone purge :ftp:development_resource_packs || echo "ok"
rclone mkdir :ftp:development_behavior_packs || echo "ok"
rclone mkdir :ftp:development_resource_packs || echo "ok"

for path in addons/*; do
  f="$(basename $path)"
  rclone mkdir :ftp:development_behavior_packs/$f
  rclone copy --retries=0 ./addons/$f/behavior :ftp:development_behavior_packs/$f || echo "ok"
  rclone mkdir :ftp:development_resource_packs/$f
  rclone copy --retries=0 ./addons/$f/resource :ftp:development_resource_packs/$f || echo "ok"
done

rclone copy --retries=0 world :ftp:worlds/Legoland || echo "ok"
rclone copy --retries=0 settings :ftp: || echo "ok"
