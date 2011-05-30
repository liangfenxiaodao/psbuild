$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\unzip.ps1
. $scriptDir\environment.ps1
. $scriptDir\unblock_file.ps1
Function Install-Curl($curlZipFile, $installToDir) {
	Unzip $curlZipFile $installToDir
	Add-To-Environment-Path "$installToDir;"
	Unblock-File "$installToDir\curl.exe"
}