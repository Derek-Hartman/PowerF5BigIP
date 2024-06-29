<#
.Synopsis
    Connects to F5 and outputs list of records for a specific data group

.EXAMPLE 
    Get-F5BigIPDataGroup -F5BigIpAddress "XXXX.xxx.com" -Partition "common" -DataGroupName "DataGroupName" -F5Creds "CredObject"

.NOTES
    Modified by: Derek Hartman
    Date: 6/14/2024

#>
Function Get-F5BigIPDataGroup {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your F5 BigIP Address.")]
        [string[]]$F5BigIpAddress,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Partition.")]
        [string[]]$Partition,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Data Group Name.")]
        [string[]]$DataGroupName,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your F5 Creds.")]
        [System.Management.Automation.PSCredential]$F5Creds
    )
	
	$Uri = "https://$($F5BigIpAddress)/mgmt/tm/ltm/data-group/internal/~$($Partition)~$($DataGroupName)"

    $Response = Invoke-RestMethod -Uri $Uri -Method Get -Credential $F5Creds -ContentType "application/json"
    Write-Output $Response
}