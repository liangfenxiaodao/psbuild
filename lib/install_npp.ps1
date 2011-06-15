Function Install-NPP-591 {
	If(NPP-Installed) { 
		Write-Host "Notepadd ++ is already installed on this computer, will by pass notepad ++ installation"
		return 
	}
	curl "http://download.tuxfamily.org/notepadplus/5.9.1/npp.5.9.1.Installer.exe" -o "npp.exe"
    
	iex ".\npp.exe /S"
	Wait-For-NPP-Install
	
	iex "del .\npp.exe"
}

Function NPP-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"
}

Function Wait-For-NPP-Install {
	$seconds = 120
	Write-Host "Notepad++ is installing." -NoNewLine

	while (!(NPP-Installation-Completed)) {
		Sleep 1
		$seconds--
		Write-Host "." -NoNewLine
		if ($seconds -eq 0) { exit -1 }
	}
	Sleep 5
	Write-Host "."
	Write-Host "Notepad++ installation finished."
}

Function NPP-Installation-Completed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\notepad++.exe"
}