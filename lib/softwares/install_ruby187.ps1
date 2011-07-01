Function Download-Ruby187 {
	iex "$scriptDir\tools\curl.exe http://files.rubyforge.vm.bytemark.co.uk/rubyinstaller/rubyinstaller-1.8.7-p334.exe -o rubyinstaller.exe"
}

Function Ruby187-Installed {
	Try { ruby --version }
	Catch {}
	$?
}

Function Silent-Install-Ruby187 {
	iex ".\rubyinstaller.exe /verysilent"
	Add-To-Path "c:\ruby187\bin;"
}

Function Ruby187-Installation-Completed {
    Ruby187-Installed
}

Function Execute-Ending-Actions-For-Ruby187 {
	sleep 5
	iex "del .\rubyinstaller.exe"
}