. $libDir\webadministration_extensions.ps1

$testAppPoolName = "testAppPool"

Describe "invoke Set-WebAppPoolManagedPipelineMode with valid parameter" {

    It "change ManagedPipelineMode" {
        New-WebAppPool $testAppPoolName -force
        Set-WebAppPoolManagedPipelineMode $testAppPoolName "Classic"

        $testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName } 
        $testAppPool.managedPipelineMode.should.be("Classic")        
        
        Remove-WebAppPool $testAppPoolName
    }
    
    It "if Mode is not either Classic or Integrated, it will fail" {
        New-WebAppPool $testAppPoolName -force
        Set-WebAppPoolManagedPipelineMode $testAppPoolName "InvalidMode"

        $testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName } 
        $testAppPool.managedPipelineMode.should.be("Integrated")        
        
        Remove-WebAppPool $testAppPoolName
    }

}

Describe "invoke Set-WebAppPoolManagedRuntimeVersion with valid parameter" {
    It "if Version is not supported by OS, then nothing happened" {
        New-WebAppPool $testAppPoolName -force
        Set-WebAppPoolManagedRuntimeVersion $testAppPoolName "invalid_version"
        
        $testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName } 
        $testAppPool.managedRuntimeVersion.should.be("v2.0")

        Remove-WebAppPool $testAppPoolName
    }
  
    It "set managedRuntimeVersion to v4.0" {
        New-WebAppPool $testAppPoolName -force
        Set-WebAppPoolManagedRuntimeVersion $testAppPoolName "v4.0"
        
        $testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName } 
        $testAppPool.managedRuntimeVersion.should.be("v4.0")

        Remove-WebAppPool $testAppPoolName
    }
    
    It "set managedRuntimeVersion to 'No Managed Code'" {
        New-WebAppPool $testAppPoolName -force
        Set-WebAppPoolManagedRuntimeVersion $testAppPoolName "no managed"
        
        $testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName } 
        $testAppPool.managedRuntimeVersion.should.be("")

        Remove-WebAppPool $testAppPoolName
     }
}

Describe "invoke Set-WebAppPoolIdentityType" {
	It "set identity to networkservice" {
		New-WebAppPool $testAppPoolName -force
		Set-WebAppPoolIdentityType $testAppPoolName "NetworkService"
		
		$testAppPool = ls "IIS:\AppPools" | ? {$_.Name -eq $testAppPoolName }
		$testAppPool.processModel.identityType.should.be("NetworkService")
		
		Remove-WebAppPool $testAppPoolName
	}
}