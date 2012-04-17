Function Download-Firefox11 {
	iex "$scriptDir\tools\curl.exe 	http://mozilla.mirror.aarnet.edu.au/pub/mozilla/firefox/releases/11.0/win32/en-US/Firefox%20Setup%2011.0.exe -o firefox.exe"
}

Function Silent-Install-Firefox11 {
	iex ".\firefox.exe -ms"
}

Function Firefox11-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}

Function Firefox11-Installation-Completed {
	Firefox-Installed
}

Function Execute-Ending-Actions-For-Firefox11 {
	iex "del .\firefox.exe"
}
