Function Disable-UAC {
	$UAC = Get-ItemProperty -Path registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\policies\system
	Set-ItemProperty $UAC.PSPath -Name "EnableLUA" -Value 0
}