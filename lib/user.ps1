function Test-User-Exist($username) {
	$computer = [ADSI]"WinNT://$env:computername"
	$user = $computer.psbase.children | ? {$_.Name -eq $username}
	return $user
}

function Create-User {
	param(
       [Parameter(Mandatory=1)] $username,
       [Parameter(Mandatory=1)] $password
    )
	If(Test-User-Exist $username){
		Write-Host "User: $username already exist. " -fore yellow
		return
	}
	
    iex "net user $username $password /add /passwordchg:no"
    $user = [adsi]"WinNT://$env:computername/$username"
    $user.userflags = $user.userflags[0] -bor 0X10000
    $user.SetInfo()

	Write-Host "User: $username created." -fore green
}

function Delete-User($username) {
	If(Test-User-Exist $username){
		$computer = [ADSI]"WinNT://localhost"
		$Computer.Delete("user",$username)
		Write-Host "User: $username deleted." -fore green
	} Else {
		Write-Host "User: $username doesn't exist." -fore yellow
	}
}