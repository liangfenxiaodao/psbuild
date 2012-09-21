$repo = "$home\.psbuild_repo"

$packageName = "dotnetfx45_full_x86_x64.exe"

Function Download-DotNet45 {
	if (Test-Path "$repo/$packageName") {
		return
	}

	Write-Host "Start downloading .Net Framework 4.5 ..."
	iex "$scriptDir\tools\curl.exe http://download.microsoft.com/download/b/a/4/ba4a7e71-2906-4b2d-a0e1-80cf16844f5f/$packageName -o $repo/$packageName" 
}

Function Silent-Install-DotNet45 {
	Write-Host "Start installing .Net Framework 4.5"
	iex "$repo/$packageName /q /norestart"
}

Function DotNet45-Installation-Completed {
	DotNet45-Installed
}

Function DotNet45-Installed {
    $key = "hklm:\software\microsoft\NET Framework Setup\NDP\v4\Full"
	if (-not (Test-Path $key)) { return $false }

    $install = (gp $key).Install
    $version = (gp $key).Version
    return (($install -eq 1) -and ($version -eq "4.5.50709"))
}
