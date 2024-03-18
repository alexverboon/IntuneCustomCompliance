<#
    .SYNOPSIS
    Custom compliance script to report Windows Firewall Auditing settings

    .DESCRIPTION
    This script checks the following Windows Firewall auditing settings
    "Filtering Platform Packet Drop" failure enabled
    "Filtering Platform Connection" failure enabled

    .INPUTS
    None. You cannot pipe objects to the script.

    .OUTPUTS
    System.Management.Automation.PSCustomObject

   .COMPONENT
   Microsoft Intune    
    .NOTES
    Example output: {"FilteringPlatformPacketDrop":"Failure","FilteringPlatformConnection":"Failure"}
#>

$categories = "Filtering Platform Packet Drop,Filtering Platform Connection"
$current = auditpol /get /subcategory:"$($categories)" /r | ConvertFrom-Csv

$output = @{
FilteringPlatformPacketDrop = $current | where-object Subcategory -eq "Filtering Platform Packet Drop" | select-object -expandproperty 'Inclusion Setting'
FilteringPlatformConnection = $current | where-object Subcategory -eq "Filtering Platform Connection" | select-object -expandproperty 'Inclusion Setting'
}

return $output | ConvertTo-Json -Compress
