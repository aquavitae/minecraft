#!/bin/bash

set -e -o pipefail
set -v

rm -rf $HOME/minecraft
git clone https://github.com/aquavitae/minecraft.git
cd $HOME/minecraft

target="$HOME/minecraftbe/mycraft"

rm -rf "$target/behavior_packs/Pets"
rm -rf "$target/behavior_packs/dragons.v14"
rm -rf "$target/resource_packs/dragons.v14"

pwd
ls
ls $target

cp -r ./behavior "$target/behavior_packs/Pets"
cp -r ./addons/dragons.v14/behavior "$target/behavior_packs/dragons.v14"
cp -r ./addons/dragons.v14/resource "$target/resource_packs/dragons.v14"

cd $HOME
rm -rf minecraft

$target/restart.sh
