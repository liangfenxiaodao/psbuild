$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. $scriptDir\string.ps1

Function Add-To-Path($pathToBeAdded) {
	$path = [environment]::GetEnvironmentVariable("Path","Machine")
	if(!(Contains-IgnoreCase($path, $pathToBeAdded))) {
		if(!$path.EndsWith(";")) {
			$pathToBeAdded = ";$valueToBeAdded"
		}
		[Environment]::SetEnvironmentVariable("Path", $path+$pathToBeAdded, "Machine")
	}
}

Function Path-Contains($pathToBeAdded) {
	$path = [environment]::GetEnvironmentVariable("Path","Machine")
	return Contains-IgnoreCase $path $pathToBeAdded
}