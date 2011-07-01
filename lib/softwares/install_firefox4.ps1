Function Download-Firefox4 {
	iex "$scriptDir\tools\curl.exe http://mozilla.snt.utwente.nl//firefox/releases/4.0.1/win32/en-US/Firefox%20Setup%204.0.1.exe -o firefox.exe"
}

Function Silent-Install-Firefox4 {
	iex ".\firefox.exe -ms"
}

Function Firefox4-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}

Function Firefox4-Installation-Completed {
	Firefox-Installed
}

Function Execute-Ending-Actions-For-Firefox4 {
	iex "del .\firefox.exe"
}
