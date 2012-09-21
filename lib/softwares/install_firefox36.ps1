$repo = "$home\.psbuild_repo"

$firfoxInstaller = "Firefox_Setup_3.6.28.exe"

Function Download-Firefox36 {
	if (Test-Path "$repo\$firfoxInstaller") {
		return
	}
	cp "\\10.18.1.16\Share\User\khan\$firfoxInstaller" "$repo"
}

Function Silent-Install-Firefox36 {
	iex "$repo\$firfoxInstaller -ms"
}

Function Firefox36-Installed {
	Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe"
}

Function Firefox36-Installation-Completed {
	Firefox36-Installed
}
