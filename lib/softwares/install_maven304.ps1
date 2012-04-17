Function Download-Maven304 {
	iex "$scriptDir\tools\curl.exe http://apache.cs.utah.edu/maven/binaries/apache-maven-3.0.4-bin.zip -o $scriptDir\maven.zip"
}

Function Silent-Install-Maven304 {
	Unzip $scriptDir\maven.zip C:\bin\
	Add-To-Path("C:\bin\apache-maven-3.0.4\bin;")
}

Function Maven304-Installed {
	Try { mvn --version }
	Catch {}
	$?
}

Function Maven304-Installation-Completed {
	Maven304-Installed
}

Function Execute-Ending-Actions-For-Maven304 {
	iex "del .\maven.zip"
}
