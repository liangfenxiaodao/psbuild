Function Download-NotepadPP {
	iex "$scriptDir\tools\curl.exe http://download.tuxfamily.org/notepadplus/5.9.1/npp.5.9.1.Installer.exe -o npp.exe"
}

Function Silent-Install-NotepadPP {
	iex ".\npp.exe /S"
}

Function NotepadPP-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"
}

Function NotepadPP-Installation-Completed {
	NPP-Installed
}

Function Delete-Downloaded-NotepadPP {
	Sleep 5
	iex "del .\npp.exe"
}