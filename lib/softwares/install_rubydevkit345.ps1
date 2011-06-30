$rubydevkitInstallDir = "c:\rubydevkit"

Function Download-RubyDevkit345 {
	If(!(Test-Path $rubydevkitInstallDir)){
		New-Item $rubydevkitInstallDir -Type Directory
	}
	WorksAt $rubydevkitInstallDir {
		iex "$scriptDir\tools\curl.exe http://cloud.github.com/downloads/oneclick/rubyinstaller/DevKit-3.4.5-20100819-1535-sfx.exe -o rubydevkit.exe"
	}
}

Function Silent-Install-RubyDevkit345 {
	WorksAt $rubydevkitInstallDir {
		iex "$scriptDir\tools\7z\7z.exe x rubydevkit.exe"
	}
}

Function RubyDevkit345-Installation-Completed {
    return $true
}

Function Delete-Downloaded-RubyDevkit345 {
	#iex "del .\rubyinstaller.exe"
}

Function RubyDevkit345-Installed {
	return $false
}