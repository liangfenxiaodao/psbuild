$FWprofileTypes= @{1="Domain"; 2="Private" ; 4="Public"}
$FwAction      = @{1="Allow"; 0="Block"}
$FWDirection   = @{1="Inbound"; 2="outbound"; "Inbound"=1;"outbound"=2} 

Function Get-FirewallConfig {
	$fw=New-object -comObject HNetCfg.FwPolicy2

	"Active Profiles(s) :" + (Convert-fwprofileType $fw.CurrentProfileTypes)

	@(1,2,4) | select `
                  @{Name="Network Type"     ;expression={$fwProfileTypes[$_]}},
                  @{Name="Firewall Enabled" ;expression={$fw.FireWallEnabled($_)}},
                  @{Name="Block All Inbound";expression={$fw.BlockAllInboundTraffic($_)}},
                  @{name="Default In"       ;expression={$FwAction[$fw.DefaultInboundAction($_)]}},
                  @{Name="Default Out"      ;expression={$FwAction[$fw.DefaultOutboundAction($_)]}} `
            | Format-Table -auto
}

Function Convert-FWProfileType($profileCode){
	$descriptions= @()
	$FWprofileTypes.keys | %{
			if ($profileCode -bAND $_) { $descriptions += $FWProfileTypes[$_] } 
		}
    $descriptions
}