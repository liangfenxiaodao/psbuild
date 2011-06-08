Function Install-NPP-591 {
	If(NPP-Installed) { 
		Write-Host "Notepadd ++ is already installed on this computer, will by pass notepad ++ installation"
		return 
	}
	curl "http://download.tuxfamily.org/notepadplus/5.9.1/npp.5.9.1.Installer.exe" -o "npp.exe"
    iex ".\npp.exe /S"
	iex "del .\npp.exe"
}

Function NPP-Installed {
	Test-Path "HKLM:\SOFTWARE\Notepad++"
}