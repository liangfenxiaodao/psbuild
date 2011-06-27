$dotnetLogPath = "C:\dotnetlog.html"

Function Download-DotNet4 {
	iex "$scriptDir\tools\curl.exe -O http://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe"
}

Function Silent-Install-DotNet4 {
	If(!(Test-Path $dotnetLogPath)){
		New-Item $dotnetLogPath
	}
	iex ".\dotNetFx40_Full_setup.exe /passive /log $dotnetLogPath"
}

Function Delete-Downloaded-DotNet4 {
	iex "del .\dotNetFx40_Full_setup.exe"
}

Function DotNet4-Installation-Completed {
	 $log = ""
	 get-content $dotnetLogPath | % { $log += $_ }
	 $log.Contains("completed successfully.")      
}

Function DotNet4-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4.0"
}