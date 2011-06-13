Set-ExecutionPolicy Unrestricted

$root    = Split-Path -Parent $MyInvocation.MyCommand.Path
$pester  = "$root\pester-port"
$libDir  = "$root\lib"
$testDir = "$root\test"

Function Add-ShouldPropertyForEachObject {
    . $pester\ObjectAdaptations\PesterFailure.ps1
    Update-TypeData -pre "$pester\ObjectAdaptations\types.ps1xml" -ErrorAction SilentlyContinue
}

Function Match-Test($testName, $parterns) {
    foreach ($p in $parterns) {
        if ($testName.FullName -match $p) { return $true }
    }
    return $false
}

Function Run-Test($testFile) {
	. $testFile.FullName
}

Add-ShouldPropertyForEachObject

. $pester/Pester.ps1

$tests = ls -path "$root\test" -filter *Test.ps1 -ErrorAction SilentlyContinue

if (!$tests) {
	Write-Warning "No Test found in test folder."
	exit
}

if ($args.Length -gt 0) {
    $parterns = $args
    $tests | ? { Match-Test $_ $parterns } | % { Run-Test $_ } 
} 
else {
    $tests | % { Run-Test $_ } 
}

Write-TestReport
Exit-WithCode