$repo = "$home\.psbuild_repo"

$hgInstaller = "tortoisehg-2.5.0-hg-2.3.1-x64.msi"

Function Download-Hg {
	if (Test-Path "$repo\$hgInstaller") {
		return
	}
	cp "\\10.18.1.16\Share\User\khan\$hgInstaller" "$repo"
}

Function Silent-Install-Hg {
	iex "$repo\$hgInstaller /quiet"
}

Function Hg-Installation-Completed {
	Hg-Installed
}

Function Hg-Installed {
	Test-Path "hklm:\software\TortoiseHG"
}

