Import-Module WebAdministration -Force

function Get-WebAppPool {
    ls IIS:\AppPools
}

function New-DotNet4WebSite{
	param(
       [Parameter(Mandatory=1)] $SiteName,
       [Parameter(Mandatory=1)] $PhysicalPath
    )
	$AppPool = $SiteName+"AppPool"
	New-WebAppPool -Name $AppPool
	Set-WebAppPoolManagedRuntimeVersion $AppPool "v4.0"
	Set-WebAppPoolIdentityType $AppPool "NetworkService"
	New-WebSite -Name $SiteName -PhysicalPath $PhysicalPath -ApplicationPool $AppPool
}

function Set-WebAppPoolManagedPipelineMode {
    param(
       [Parameter(Mandatory=1)] $AppPoolName,
       [Parameter(Mandatory=1)] $Mode
    )

    Given-AppPoolExist $AppPoolName {
    	Given-Valid-Mode $Mode {
    		$filter = '/system.applicationHost/applicationPools/add[@name="' + $AppPoolName + '"]'
    		$modeValue = @{managedPipeLineMode="$Mode" }
    		Set-WebConfiguration $filter -value $modeValue
		}
	}
}


function Set-WebAppPoolManagedRuntimeVersion {
    param(
       [Parameter(Mandatory=1)] $AppPoolName,
       [Parameter(Mandatory=1)] $Version
    )

    Given-AppPoolExist $AppPoolName {
    	if ($Version.ToLower() -eq "no managed") {
    	    $Version = ""
    	}
    	Given-Valid-Version $Version {
    		$filter = '/system.applicationHost/applicationPools/add[@name="' + $AppPoolName + '"]'
    		$versionValue = @{managedRuntimeVersion="$Version" } 
    		Set-WebConfiguration $filter -value $versionValue
		}
	}
}

function Set-WebAppPoolIdentityType {
    param(
       [Parameter(Mandatory=1)] $AppPoolName,
       [Parameter(Mandatory=1)] $Identity
    )

    Given-AppPoolExist $AppPoolName {
    	Given-Valid-Identity $Identity {
    		$filter = '/system.applicationHost/applicationPools/add[@name="' + $AppPoolName + '"]/processModel'
    		$identityValue = @{identityType="$Identity" } 
    		Set-WebConfiguration $filter -value $identityValue
		}
	}
}

function Given-AppPoolExist($AppPoolName, $block) {
	$appPool = ls 'IIS:\AppPools' | ? { $_.Name -eq $AppPoolName }
    if (!$appPool) { 
        Write-Warning "App Pool $AppPoolName Not Exist"
        return  
    }
	& $block
}

function Given-Valid-Mode($Mode, $block) {
	if (!$Mode.Equals("Classic") -and !$Mode.Equals("Integrated")) { 
	    Write-Warning "Unknown Mode $Mode"
	    return 
	}
	& $block
}

function Given-Valid-Version($Version, $block) {
	if (($Version -ne "v2.0") -and ($Version -ne "v3.0") -and ($Version -ne "v4.0") -and ($Version -ne "")) {
	    Write-Warning "Runtime Version $Version is not supported."
	    return  
	}
	& $block
}

function Given-Valid-Identity($Identity, $block) {
	if (($Identity -ne "ApplicationPoolIdentity") -and ($Identity -ne "NetworkService") -and ($Identity -ne "LocalService") -and ($Identity -ne "LocalSystem")) {
	    Write-Warning "Identity $Identity is not supported."
	    return  
	}
	& $block
}