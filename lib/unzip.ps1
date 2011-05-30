Function Unzip($filename, $unzipToDir) {
	$shell_app=new-object -com shell.application
	$zip_file = $shell_app.namespace($filename)
	
	Remove-Item $unzipToDir -erroraction SilentlyContinue -recurse
	New-Item $unzipToDir -type directory

	$destination = $shell_app.namespace($unzipToDir)
	$destination.Copyhere($zip_file.items())
}