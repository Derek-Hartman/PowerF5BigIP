<#
.Synopsis
    Connects to F5 and adds a mew Record

.EXAMPLE 
    Remove-F5BigIPDataGroupRecord -F5BigIpAddress "XXXX.xxx.com" -Partition "common" -DataGroupName "DataGroupName" -DataGroupRecordName "DataGroupRecordName" -F5Creds "CredObject"

.NOTES
    Modified by: Derek Hartman
    Date: 6/14/2024

#>
Function Remove-F5BigIPDataGroupRecord {
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
            HelpMessage = "Enter your Data Group Record Name.")]
        [string[]]$DataGroupRecordName,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your F5 Creds.")]
        [System.Management.Automation.PSCredential]$F5Creds
    )

    $Body = @{name="$DataGroupName"}
    $JsonBody = ConvertTo-Json $Body
	
    $Uri = "https://$($F5BigIpAddress)/mgmt/tm/ltm/data-group/internal/~$($Partition)~$($DataGroupName)?options=records+delete+{$($DataGroupRecordName)}"

    $Response = Invoke-RestMethod -Uri $Uri -Method Patch -Credential $F5Creds -ContentType "application/json" -Body $JsonBody
    Write-Output $Response
}