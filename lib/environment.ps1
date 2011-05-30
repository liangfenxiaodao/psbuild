Function Add-To-Environment-Path($pathToBeAdded) {
	Add-To-Environment "Path" $pathToBeAdded
}

Function Add-To-Environment($variableName, $valueToBeAdded) {
    $value = [environment]::GetEnvironmentVariable($variableName,"Machine")
	if(!$value.Contains($valueToBeAdded)) {
		if(!$value.EndsWith(";")) {
			$valueToBeAdded = ";$valueToBeAdded"
		}
		[Environment]::SetEnvironmentVariable($variableName, $value+$valueToBeAdded, "Machine")
	}
}