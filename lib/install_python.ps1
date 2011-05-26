$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\environment.ps1

Function Install-Python27($pythonInstallKit) {
	$pythonInstallDir = "c:\python27"
	$pythonLogPath = "c:\python.log"

	Remove-Item $pythonLogPath -erroraction SilentlyContinue
	New-Item $pythonLogPath -type file
	iex "$pythonInstallKit /quiet /li $pythonLogPath"
	Wait-For-Python-Install $pythonLogPath
	Add-To-Environment-Path "$pythonInstallDir;"
}

Function Wait-For-Python-Install($pythonLogPath) {
	$seconds = 120
	while (!(Python-Install-Completed $pythonLogPath)) {
		Sleep 1
		$seconds--

		if ($seconds -eq 0) { exit -1 }
	}
}

Function Python-Install-Completed($pythonLogPath) {
	 $log = ""
	 get-content "c:\python.log" | % { $log += $_ }
	 $log.Contains("completed successfully.")
}