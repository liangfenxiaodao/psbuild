Function Install-Firefox4 {
	curl "http://mozilla.snt.utwente.nl//firefox/releases/4.0.1/win32/en-US/Firefox%20Setup%204.0.1.exe" -o "firefox.exe"
    iex "& .\firefox.exe -ms"
	iex "del .\$firefox.exe"
}