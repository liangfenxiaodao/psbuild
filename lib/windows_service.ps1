Function Create-Service {
	param(
       [Parameter(Mandatory=1)] $serviceName,
       [Parameter(Mandatory=1)] $binaryPathName
    )
	$result = $False
	$index = $binaryPathName.IndexOf("-")
	if($index -eq -1){
		$path = $binaryPathName.Trim()
	}
	else{
		$patb = $binaryPathName.SubString(0,$binaryPathName.IndexOf("-")).Trim()
	}
	if(!($path.EndsWith(".exe"))) {
		$path += ".exe"
	}
	if(!(Test-Service($serviceName))){
		if(Test-Path -Path $path){
			New-Service -Name $serviceName -BinaryPathName $binaryPathName
			$result = $True
		}
	}
	return $result
}

#return $True if service exists
Function Test-Service {
	param(
		[Parameter(Mandatory=1)] $serviceName
	)
	$result = Get-WmiObject -Class Win32_Service -Filter "Name = ""$serviceName"""
	return $result -ne $null
}

#to do
Function Delete-Service {
	param(
		[Parameter(Mandatory=1)] $serviceName
	)
	#need to some check
	$result = $False;
	if(Test-Service($serviceName)){
		$service = Get-WmiObject -Class Win32_Service -Filter " Name= '$serviceName'"
		if($service.Started){
			$service.StopService()
			Write-Host "Service $serviceName is stoped."
		}
		$deleteResult = $service.Delete()
		Write-Host "Service Delete result code is $($deleteResult.ReturnValue)"
		if($deleteResult.ReturnValue -eq 0){
			$result = $True
			Write-Host "Service $serviceName is deleted."
		}
	}
	return $result
}

#0  Success
#1  Not Supported
#2  Access Denied
#3  Dependent Services Running
#4  Invalid Service Control
#5  Service Cannot Accept Control
#6  Service Not Active
#7  Service Request Timeout
#8  Unknown Failure
#9  Path Not Found
#10  Service Already Running
#11  Service Database Locked
#12  Service Dependency Deleted
#13  Service Dependency Failure
#14  Service Disabled
#15  Service Logon Failure
#16  Service Marked For Deletion
#17  Service No Thread
#18  Status Circular Dependency
#19  Status Duplicate Name
#20  Status Invalid Name
#21  Status Invalid Parameter
#22  Status Invalid Service Account
#23  Status Service Exists
#24  Service Already Paused