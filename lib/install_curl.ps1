$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\path.ps1
. $scriptDir\util.ps1

Function Install-Curl($installToDir) {
	If(Curl-Installed) { 
		Write-Host "Curl is already installed on this computer, will by pass Curl installation"
		return 
	}
	
	If(!(Test-Path $installToDir)) { New-Item $installToDir -type "Directory"}
	Copy "$scriptDir\tools\curl.exe" $installToDir
	Add-To-Path "$installToDir;"
	Unblock-File "$installToDir\curl.exe"
}

Function Curl-Installed {
	Try {
		curl --version
	}
	Catch {}
	$?
}