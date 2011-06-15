$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

. $scriptDir\softwares\util.ps1
. $scriptDir\softwares\install_npp.ps1
. $scriptDir\softwares\install_firefox.ps1
. $scriptDir\softwares\install_python.ps1

Function Install-Software($software){
	If(iex "$software-Installed"){
		Write-Host "$software is already installed on this computer, will by pass installation"
		return 
	}
	
	iex "Download-$software"
	
	Bypass-Error-Message {
		iex "Silent-Install-$software"
		Wait-For-Software-Install $software
	}
	
	iex "Delete-Downloaded-$software"
}

Function Wait-For-Software-Install($software) {
	$seconds = 120
	Write-Host "$software is installing." -NoNewLine

	while (!(iex "$software-Installation-Completed")) {
		Sleep 1
		$seconds--
		Write-Host "." -NoNewLine
		if ($seconds -eq 0) { exit -1 }
	}

	Write-Host "."
	Write-Host "$software installation finished."
}