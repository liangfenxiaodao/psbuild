$rubydevkitInstallDir = "c:\rubydevkit"

Function Download-RubyDevkit3245 {
	If(!(Test-Path $rubydevkitInstallDir)){
		New-Item $rubydevkitInstallDir -Type Directory
	}
	WorksAt $rubydevkitInstallDir {
		iex "$scriptDir\tools\curl.exe http://cloud.github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.1-20101214-1400-sfx.exe -o rubydevkit.exe"
	}
}

Function Silent-Install-RubyDevkit3245 {
	WorksAt $rubydevkitInstallDir {
		iex "$scriptDir\tools\7z\7z.exe x rubydevkit.exe"
	}
}

Function RubyDevkit3245-Installation-Completed {
    return $true
}

Function Execute-Ending-Actions-For-RubyDevkit3245 {
	WorksAt $rubydevkitInstallDir {
		iex "ruby dk.rb init"
		iex "ruby dk.rb install"
		iex "del .\rubydevkit.exe"
	}
}

Function RubyDevkit3245-Installed {
	return $false
}