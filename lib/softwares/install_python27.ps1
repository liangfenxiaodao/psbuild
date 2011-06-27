$pythonLogPath = "c:\python.log"

Function Download-Python27 {
	iex "$scriptDir\tools\curl.exe http://python.org/ftp/python/2.7.1/python-2.7.1.msi -o python.msi"
	Unblock-File $python27InstallKit
}

Function Python27-Installed {
	Try { python --version }
	Catch {}
	$?
}

Function Silent-Install-Python27 {
	If(!(Test-Path $pythonLogPath)){
		New-Item $pythonLogPath -Type file
	}
	iex ".\python.msi /quiet /li $pythonLogPath"
	Add-To-Path "c:\python27;"
}

Function Python27-Installation-Completed {
	 $log = ""
	 get-content $pythonLogPath | % { $log += $_ }
	 $log.Contains("completed successfully.")      
}

Function Delete-Downloaded-Python27 {
	iex "del .\python.msi"
}