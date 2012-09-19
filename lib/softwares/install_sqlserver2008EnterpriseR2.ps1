$repo = "$home/.psbuild_repo"

$installer = "sqlserver2008_enterprise_r2\setup.exe"

Function Download-SqlServer2008EnterpriseR2 {
	if (-not (Test-Path "$repo\$installer")) {
		throw "Can't find sqlserver 2008 enterprise r2 installer $installer."
	}
}

Function Silent-Install-SqlServer2008EnterpriseR2 {
	$configFile = "$scriptDir\softwares\sqlserverconfig\InstallConfig-2008EnterpriseR2.ini"
	iex "$repo\$installer /ConfigurationFile=$configFile /IAcceptSQLServerLicenseTerms=True"
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
