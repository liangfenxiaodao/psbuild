$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleDir = "$root\ChefDotNet"

if (Test-Path $moduleDir) { 
	rm $moduleDir -Recurse -Force 
	mkdir "$moduleDir"
	mkdir "$moduleDir\lib"
}

cp -r "$root\lib\*" "$moduleDir\lib"
cp *.psd1 $moduleDir
cp *.psm1 $moduleDir