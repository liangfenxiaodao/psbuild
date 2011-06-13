Function Unblock-File($file) {
    $fileZone = "$file" + ":Zone"
	iex "cmd /c 'echo . > $fileZone.Identifier'"
}