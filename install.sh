#!/bin/bash

set -e -o pipefail

rm -rf ~/minecraft
git clone https://github.com/aquavitae/minecraft.git
cd ~/minecraft

target="~/minecraftbe/mycraft"

rm -rf "$target/behavior_packs/Pets"
rm -rf "$target/behavior_packs/dragons.v14"
rm -rf "$target/resource_packs/dragons.v14"

cp -r ./behavior "$target/behavior_packs/Pets"
cp -r ./addons/dragons.v14/behavior "$target/behavior_packs/dragons.v14"
cp -r ./addons/dragons.v14/resource "$target/resource_packs/dragons.v14"

cd ~
rm -rf minecraft

$target/restart.sh
