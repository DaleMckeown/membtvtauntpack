$modFolder = "C:\Users\Dale\Desktop\Code\membtvtauntpack\"

# Clean up the previous build.
Remove-Item "$modFolder\Compiled" -Recurse

# Loop over the aoe2 languages, copy the sounds into the correct language folder structure.
foreach($language in [System.IO.File]::ReadLines("$modFolder\Languages.txt"))
{
	New-Item -ItemType Directory -Force -Path "$modFolder\Compiled\resources\$language\sound\taunt"
	Copy-Item -Path "$modFolder\Source\Audio\*" -Destination "$modFolder\Compiled\resources\$language\sound\taunt" -Recurse
}

# Compress the resources into a .zip file.
$compressResources = @{
  Path = "$modFolder\Compiled\resources"
  CompressionLevel = "Fastest"
  DestinationPath = "$modFolder\Compiled\resources.zip"
}
Compress-Archive @compressResources


#Modify the readme.
$readme = "C:\Users\Dale\Desktop\Code\membtvtauntpack\readme.md"
$readmeContent = Get-Content $readme -Raw
$startText = "# Taunts"
$endText = "# Credits"
$startTextIndex = $readmeContent.IndexOf($startText) + $startText.Length + 2
$endTextIndex = $readmeContent.IndexOf($endText) -1
$readmeContent.Remove($startTextIndex, ($endTextIndex - $startTextIndex )) | Set-Content $readme
$readmeContent = Get-Content $readme -Raw

$tauntList = @()
Get-ChildItem "$modFolder\Source\Audio" -Filter *.wem | 
Foreach-Object {
    $tauntList += $_.name.Insert(3, ".").Replace(".wem", "");
}
$tauntsJoined = $tauntList -join "`n"
$tauntsJoined += "`n"
$readmeContent.Insert($startTextIndex, $tauntsJoined) | Set-Content $readme