Import-Module servermanager

Function Enable-DotNet3 {
	Add-WindowsFeature NET-Framework-Core
}

Function Enable-IIS {
	Add-WindowsFeature Web-Server
	Add-WindowsFeature Web-Asp-Net
	Add-WindowsFeature WAS-Process-Model
	Add-WindowsFeature WAS-NET-Environment
	Add-WindowsFeature WAS-Config-APIs
}