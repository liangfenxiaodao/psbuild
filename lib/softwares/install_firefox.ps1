Function Download-Firefox {
	curl "http://mozilla.snt.utwente.nl//firefox/releases/4.0.1/win32/en-US/Firefox%20Setup%204.0.1.exe" -o "firefox.exe"
}

Function Silent-Install-Firefox {
	iex ".\firefox.exe -ms"
}

Function Firefox-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}

Function Firefox-Installation-Completed {
	Firefox-Installed
}

Function Delete-Downloaded-Firefox {
	iex "del .\firefox.exe"
}
