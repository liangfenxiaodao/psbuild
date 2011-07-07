Function Download-Flash4IE {
	iex "$scriptDir\tools\curl.exe http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_2_p3_64bit_activex_111710.exe -o Flash4IE.exe"
}

Function Silent-Install-Flash4IE {
	iex ".\Flash4IE.exe -install"
}

Function Flash4IE-Installed {
	Test-Path "C:\Windows\System32\Macromed\Flash\Flash64_10_3_162.ocx"
}

Function Flash4IE-Installation-Completed {
	Flash4IE-Installed
}

Function Execute-Ending-Actions-For-Flash4IE {
	iex "del .\Flash4IE.exe"
}
