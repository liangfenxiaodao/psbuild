$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\environment.ps1
. $scriptDir\unblock_file.ps1

$python27InstallKit = "python-2.7.1.msi"
$pythonLogPath = "c:\python.log"
		
Function Install-Python27 {
	If(Python-Installed) { return }
	
	Download-Python27
	Prepare-LogFile
	
	iex ".\$python27InstallKit /quiet /li $pythonLogPath"
	Wait-For-Python-Install
	
	Add-To-Path "c:\python27;"
	iex "del .\$python27InstallKit"
}

Function Python-Installed {
	Try {
		python --version
	}
	Catch {}
	$?
}

Function Download-Python27 {
	curl -O "http://python.org/ftp/python/2.7.1/python-2.7.1.msi"
	Unblock-File $python27InstallKit
}

Function Prepare-LogFile {
	Remove-Item $pythonLogPath -erroraction SilentlyContinue
	New-Item $pythonLogPath -type file
}
Function Wait-For-Python-Install {
	$seconds = 120
	while (!(Python-Install-Completed)) {
		Sleep 1
		$seconds--

		if ($seconds -eq 0) { exit -1 }
	}
}

Function Python-Install-Completed {
	 $log = ""
	 get-content $pythonLogPath | % { $log += $_ }
	 $log.Contains("completed successfully.")      
}