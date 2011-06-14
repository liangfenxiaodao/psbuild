Function Disable-UAC {
	$UAC = Get-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system"
	Set-ItemProperty $UAC.PSPath -Name "EnableLUA" -Value 0
}