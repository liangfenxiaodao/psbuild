Function Install-NPP-591 {
	curl "http://download.tuxfamily.org/notepadplus/5.9.1/npp.5.9.1.Installer.exe" -o "npp.exe"
    iex ".\npp.exe /S"
	iex "del .\npp.exe"
}