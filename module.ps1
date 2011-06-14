$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$moduleDir = "$root\ChefDotNet"

Remove-Item $moduleDir -r -ErrorAction SilentlyContinue
mkdir "$moduleDir"
mkdir "$moduleDir\lib"
cp -r "$root\lib\*" "$moduleDir\lib"
cp *.psd1 $moduleDir
cp *.psm1 $moduleDir