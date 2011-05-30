Function Unblock-File($file) {
	iex "cmd /c 'echo . > $file:Zone.Identifier'"
}