Function Download-NPP {
	curl "http://download.tuxfamily.org/notepadplus/5.9.1/npp.5.9.1.Installer.exe" -o "npp.exe"
}

Function Silent-Install-NPP {
	iex ".\npp.exe /S"
}

Function NPP-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"
}

Function NPP-Installation-Completed {
	NPP-Installed
}

Function Delete-Downloaded-NPP {
	Sleep 5
	iex "del .\npp.exe"
}