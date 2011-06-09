Function Disable-Welcome-Screen {
	$ie = Get-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
	Set-ItemProperty $ie.PSPath -Name "DisableFirstRunCustomize" -Value 1
}