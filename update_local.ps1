$target = "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"

Remove-Item -Path "$target\behavior_packs\*" -Recurse -Force
Remove-Item -Path "$target\resource_packs\*" -Recurse -Force

Copy-Item -Path .\behavior -Destination "$target\behavior_packs\Pets" -Recurse
Copy-Item -Path .\addons\dragons.v14\behavior -Destination "$target\behavior_packs\dragons.v14" -Recurse
Copy-Item -Path .\addons\dragons.v14\resource -Destination "$target\resource_packs\dragons.v14" -Recurse
