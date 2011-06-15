Function Install-Firefox-4 {
	If(Firefox-Installed) { 
		Write-Host "Firefox is already installed on this computer, will by pass firefox installation"
		return 
	}
	
	curl "http://mozilla.snt.utwente.nl//firefox/releases/4.0.1/win32/en-US/Firefox%20Setup%204.0.1.exe" -o "firefox.exe"
    
	iex ".\firefox.exe -ms"
	Wait-For-Firefox-Install
	
	iex "del .\firefox.exe"
}	

Function Wait-For-Firefox-Install {
	$seconds = 120
	Write-Host "Firefox is installing." -NoNewLine

	while (!(Firefox-Installation-Completed)) {
		Sleep 1
		$seconds--
		Write-Host "." -NoNewLine
		if ($seconds -eq 0) { exit -1 }
	}

	Write-Host "."
	Write-Host "Firefox installation finished."
}

Function Firefox-Installation-Completed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}
Function Firefox-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}