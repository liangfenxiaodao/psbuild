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
