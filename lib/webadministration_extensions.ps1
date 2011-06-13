function Get-WebAppPool {
    ls IIS:\AppPools
}

function Set-WebAppPoolManagedPipelineMode {
    param(
       [Parameter(Mandatory=1)] $AppPoolName,
       [Parameter(Mandatory=1)] $Mode
    )

    $appPool = ls 'IIS:\AppPools' | ? { $_.Name -eq $AppPoolName }
    if (!$appPool) { 
        Write-Warning "App Pool $AppPoolName Not Exist"
        return  
    }
    if (!$Mode.Equals("Classic") -and !$Mode.Equals("Integrated")) { 
        Write-Warning "Unknown Mode $Mode"
        return 
    }
    
    $filter = '/system.applicationHost/applicationPools/add[@name="' + $AppPoolName + '"]'
    $modeValue = @{managedPipeLineMode="$Mode" }
    Set-WebConfiguration $filter -value $modeValue
}
