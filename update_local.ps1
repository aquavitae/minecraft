$target = "$env:LOCALAPPDATA\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang"

Remove-Item -Path "$target\development_behavior_packs\*" -Recurse -Force
Remove-Item -Path "$target\development_resource_packs\*" -Recurse -Force

foreach($file in Get-ChildItem ".\addons") {
    Copy-Item -Path "$($file.FullName)\behavior" -Destination "$target\development_behavior_packs\$($file.Name)" -Recurse
    Copy-Item -Path "$($file.FullName)\resource" -Destination "$target\development_resource_packs\$($file.Name)" -Recurse
}
