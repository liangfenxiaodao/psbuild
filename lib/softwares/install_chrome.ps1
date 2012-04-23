Function Download-Chrome {
	iex "$scriptDir\tools\curl.exe http://10.18.8.222/other/Telstra/ChromeStandaloneEnterprise.msi -o chrome.msi"
}

Function Silent-Install-Chrome {
	iex ".\chrome.msi /quiet"
}

Function Chrome-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe"
}

Function Chrome-Installation-Completed {
	Chrome-Installed
}

Function Execute-Ending-Actions-For-Chrome {
	iex "del .\chrome.msi"
}
