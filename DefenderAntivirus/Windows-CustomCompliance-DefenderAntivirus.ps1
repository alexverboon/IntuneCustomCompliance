<#
    .SYNOPSIS
    Custom compliance script to report several important Defender Antivirus Settings

    .DESCRIPTION
    This script checks the following important Defender Antivirus Settings

   .INPUTS
   None. You cannot pipe objects to the script.

   .OUTPUTS
   System.Management.Automation.PSCustomObject

   .COMPONENT
   Microsoft Intune    
   
    .NOTES
    Example output: {"RealTimeProtectionEnabled":true,"CloudBlockLevel":2,"CloudExtendedTimeout":50,"TamperProtectionEnabled":true,"NetworkProtectionEnabled":1,"CloudProtection":2,"AntivirusEnabled":true}
#>

$TamperProtection = Get-MpComputerStatus | Select-Object IsTamperProtected
$CloudProtection = Get-MpPreference | Select-object MAPSReporting
$RealTimeProtection = Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled
$AntivirusEnabled = Get-MpComputerStatus | Select-Object AntivirusEnabled
$CloudBlockLevel = Get-MpPreference | Select-object CloudBlockLevel
$CloudExtendedTimeout = Get-MpPreference | Select-object CloudExtendedTimeout
$NetworkProtectionEnabled= Get-MpPreference | select-object EnableNetworkProtection

$output = @{
    TamperProtectionEnabled = $TamperProtection.IsTamperProtected
    CloudProtection = $CloudProtection.MAPSReporting
    RealTimeProtectionEnabled = $RealTimeProtection.RealTimeProtectionEnabled
    AntivirusEnabled = $AntivirusEnabled.AntivirusEnabled
    CloudBlockLevel = $CloudBlockLevel.CloudBlockLevel
    CloudExtendedTimeout = $CloudExtendedTimeout.CloudExtendedTimeout
    NetworkProtectionEnabled = $NetworkProtectionEnabled.EnableNetworkProtection
}

return $output | ConvertTo-Json -Compress
