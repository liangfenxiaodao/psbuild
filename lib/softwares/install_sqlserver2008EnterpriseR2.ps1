$repo = "$home/.psbuild_repo"

$sqlServerInstaller = "sqlserver2008_enterprise_r2"

Function Download-SqlServer2008EnterpriseR2 {
	if (Test-Path "$repo\$sqlServerInstaller") {
		return
	}
	Write-Host "Downloading SQLServer 2008 Enterprise R2 isntall package"
	cp -recurse "\\10.18.1.16\Share\Microsoft\SQLServer\$sqlServerInstaller" "$repo"
}

Function Silent-Install-SqlServer2008EnterpriseR2 {
	$configFile = "$scriptDir\softwares\sqlserverconfig\InstallConfig-2008EnterpriseR2.ini"
	iex "$repo\$sqlServerInstaller\setup.exe /ConfigurationFile=$configFile /IAcceptSQLServerLicenseTerms=True"
}

Function SqlServer2008EnterpriseR2-Installation-Completed {
	SqlServer2008EnterpriseR2-Installed
}

Function SqlServer2008EnterpriseR2-Installed {
    $key = "hklm:\software\microsoft\Microsoft SQL Server\100\Tools\ClientSetup\CurrentVersion"
	if (-not (Test-Path $key)) { return $false }

    $currentVersion = (gp $key).CurrentVersion
    return $currentVersion -eq "10.50.1600.1"
}