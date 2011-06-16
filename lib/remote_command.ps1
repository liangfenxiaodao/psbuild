Function Execute-Function-Remotely($computername, $functionName) {
	Trust-Remote-Host($computername)
	$session = New-PSSession -ComputerName $computername
	$command = ls -path function: | ? {$_.Name -eq $functionName}
	$arguments = $args
	Invoke-Command -Session $session -ScriptBlock $command.ScriptBlock -Arg $arguments
	Remove-PSSession -Session $session
}

Function Trust-Remote-Host($computername) {
	$remoteComputerTrusted = ls wsman:\Localhost\Client\TrustedHosts | ? {$_.Value -eq $computername}
	If(!$remoteComputerTrusted) {
		Write-Host "Adding $computername to trusted hosts..."
		set-item -path wsman:\Localhost\Client\TrustedHosts -value $computername -Force
	}
}