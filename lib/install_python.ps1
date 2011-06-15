$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\path.ps1
. $scriptDir\util.ps1

$python27InstallKit = "python-2.7.1.msi"
$pythonLogPath = "c:\python.log"
		
Function Install-Python-27 {
	If(Python-Installed) { 
		Write-Host "Python is already installed on this computer, will by pass Python installation"
		return 
	}
	
	Download-Python27
	Bypass-Error-Message {
		iex ".\$python27InstallKit /quiet /li $pythonLogPath"
		Wait-For-Python-Install
	}
	
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


Function Wait-For-Python-Install {
	$seconds = 120
	Write-Host "Python is installing." -NoNewLine

	while (!(Python-Installation-Completed)) {
		Sleep 1
		$seconds--
		Write-Host "." -NoNewLine
		if ($seconds -eq 0) { exit -1 }
	}

	Write-Host "."
	Write-Host "Python installation finished."
}

Function Python-Installation-Completed {
	 $log = ""
	 get-content $pythonLogPath | % { $log += $_ }
	 $log.Contains("completed successfully.")      
}