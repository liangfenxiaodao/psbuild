Function Install-Firefox-4 {
	If(Firefox-Installed) { 
		Write-Host "Firefox is already installed on this computer, will by pass firefox installation"
		return 
	}
	curl "http://mozilla.snt.utwente.nl//firefox/releases/4.0.1/win32/en-US/Firefox%20Setup%204.0.1.exe" -o "firefox.exe"
    iex ".\firefox.exe -ms"
	iex "del .\firefox.exe"
}	

Function Firefox-Installed {
	Test-Path "HKLM:\SOFTWARE\Mozilla\Mozilla Firefox"
}