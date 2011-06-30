Function Contains-IgnoreCase($string1, $string2) {
	$string1.ToLower().Contains($string2.ToLower())
}

Function Unblock-File($file) {
    $fileZone = "$file" + ":Zone"
	iex "cmd /c 'echo . > $fileZone.Identifier'"
}

Function Unzip($filename, $unzipToDir) {
	$shell_app=new-object -com shell.application
	$zip_file = $shell_app.namespace($filename)
	
	Remove-Item $unzipToDir -erroraction SilentlyContinue -recurse
	New-Item $unzipToDir -type directory

	$destination = $shell_app.namespace($unzipToDir)
	$destination.Copyhere($zip_file.items())
}

Function Disable-IE-Welcome-Screen {
	$ie = Get-Item "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Main"
	Set-ItemProperty $ie.PSPath -Name "DisableFirstRunCustomize" -Value 1
}

Function Disable-UAC {
	$UAC = Get-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\policies\system"
	Set-ItemProperty $UAC.PSPath -Name "EnableLUA" -Value 0
}

Function Bypass-Error-Message ($block) {
	$ErrorActionPreference = "SilentlyContinue"
	& $block
	$ErrorActionPreference = "Continue"
}

Function WorksAt($location, $action) {
	Push-Location
	Set-Location $location
	& $action
	Pop-Location
}