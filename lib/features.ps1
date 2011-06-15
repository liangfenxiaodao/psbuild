Import-Module servermanager

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\util.ps1

$dotnetLogPath = "C:\dotnetlog.html"

Function Enable-DotNet3 {
	Add-WindowsFeature NET-Framework-Core
}

Function Enable-IIS {
	Add-WindowsFeature Web-Server
	Add-WindowsFeature Web-Asp-Net
	Add-WindowsFeature WAS-Process-Model
	Add-WindowsFeature WAS-NET-Environment
	Add-WindowsFeature WAS-Config-APIs
}

Function Install-DotNet-4 {
	If(DotNet-4-Installed){
		return
	}
	curl -O "http://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"
	
	Bypass-Error-Message {
		iex ".\dotNetFx40_Full_setup.exe /passive /log $dotnetLogPath"
		Wait-For-DotNet-Install	
	}
	
	iex "del .\dotNetFx40_Full_setup.exe"
}

Function Wait-For-DotNet-Install {
	$seconds = 900
	Write-Host ".Net Framework 4.0 is installing, please wait." -NoNewLine
	
	while (!(DotNet-Installation-Completed)) {
		Sleep 1
		$seconds--
		Write-Host "." -NoNewLine
		if ($seconds -eq 0) { exit -1 }
	}

	Write-Host "."
	Write-Host ".Net Framework installation finished."
}

Function DotNet-Installation-Completed {
	 $log = ""
	 get-content $dotnetLogPath | % { $log += $_ }
	 $log.Contains("completed successfully.")      
}

Function DotNet-4-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0"
}