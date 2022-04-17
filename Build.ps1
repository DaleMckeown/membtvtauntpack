$modFolder = "C:\Users\Dale\Desktop\Code\membtvtauntpack\"

Remove-Item "$modFolder\resources" -Recurse

foreach($language in [System.IO.File]::ReadLines("$modFolder\Languages.txt"))
{
	New-Item -ItemType Directory -Force -Path "$modFolder\compiled\resources\$language\sound\taunt"
	Copy-Item -Path "$modFolder\Source\Audio" -Destination "$modFolder\compiled\resources\$language\sound\taunt" -Recurse
}

$compress = @{
  Path = "$modFolder\Compiled\resources"
  CompressionLevel = "Fastest"
  DestinationPath = "$modFolder\Compiled\resources.zip"
}

Compress-Archive @compress