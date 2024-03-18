<#
    .SYNOPSIS
    Custom compliance script to check for non-recommended Windows Defender Antivirus exclusions

    .DESCRIPTION
    This script checks whether the Defender Antivirus Exclusions are set to non-recommended values.

    .INPUTS
    None. You cannot pipe objects to the script.

    .OUTPUTS
    System.Management.Automation.PSCustomObject

   .COMPONENT
    Microsoft Intune
        
    .NOTES
    Example output: {"DefenderExclusionsPath":true,"DefenderExclusionsExtension":true,"DefenderExclusionsProcess":true}
    Reference: https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/common-exclusion-mistakes-microsoft-defender-antivirus?view=o365-worldwide
#>

# Define non-recommended Defender Path Antivirus exclusions
$NonRecommendedDefenderPathExclusions = @(
"%systemdrive%","C","C:\","C:\*",    
"C:\Temp","C:\temp\","c:\temp\*"
"C:\Program Files\",
"C:\Program Files (x86)\",
"C:\Windows\",
"C:\Users\","c:\users\*"
)

$NonRecommendedDefenderFileExtensions = @(
    ".7z",
    ".bat",
    ".bin",
    ".cab",
    ".cmd",
    ".com",
    ".cpl",
    ".dll",
    ".exe",
    ".fla",
    ".gif",
    ".gz",
    ".hta",
    ".inf",
    ".java",
    ".jar",
    ".job",
    ".jpeg",
    ".jpg",
    ".js",
    ".ko or .ko.gz",
    ".msi",
    ".ocx",
    ".png",
    ".ps1",
    ".py",
    ".rar",
    ".reg",
    ".scr",
    ".sys",
    ".tar",
    ".tmp",
    ".url",
    ".vbe",
    ".vbs",
    ".wsf",
    ".zip"
)


# Define non-recommended Defender Process Antivirus exclusions
$NonRecommendedDefenderProcessExclusions = @(
"AcroRd32.exe",
"addinprocess.exe",
"addinprocess32.exe",
"addinutil.exe",
"bash.exe",
"bginfo.exe",
"bitsadmin.exe",
"cdb.exe",
"csi.exe",
"cmd.exe",
"cscript.exe",
"dbghost.exe",
"dbgsvc.exe",
"dnx.exe",
"dotnet.exe",
"excel.exe",
"fsi.exe",
"fsiAnyCpu.exe",
"iexplore.exe",
"java.exe",
"kd.exe",
"lxssmanager.dll",
"msbuild.exe",
"mshta.exe",
"ntkd.exe",
"ntsd.exe",
"outlook.exe",
"psexec.exe",
"powerpnt.exe",
"powershell.exe",
"rcsi.exe",
"svchost.exe",
"schtasks.exe",
"system.management.automation.dll",
"windbg.exe",
"winword.exe",
"wmic.exe",
"wscript.exe",
"wuauclt.exe"
)

# Get the Defender Antivirus Path exclusions
$DefenderPathExclusions = Get-MpPreference | Select-Object -expandproperty ExclusionPath

# Check whether the Defender Path Antivirus exclusions are set to non-recommended values
$PathCompliance = if ($DefenderPathExclusions -in $NonRecommendedDefenderPathExclusions) {
    $false
} else {
    $true
}

# show the non recommended values that match with the current configuration
write-output $DefenderPathExclusions | Where-Object {$_ -in $NonRecommendedDefenderPathExclusions}


# Get the Defender File Extension Antivirus exclusions
$DefenderFileExclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionExtension

# Check whether the Defender File Extension Antivirus exclusions are set to non-recommended values
$ExtensionCompliance = if ($DefenderFileExclusions -in $NonRecommendedDefenderFileExtensions) {
    $false
} else {
    $true
}
# show the non recommended values that match with the current configuration
Write-output $DefenderFileExclusions | Where-Object {$_ -in $NonRecommendedDefenderFileExtensions}

# Get the Defender Process Antivirus exclusions
$DefenderProcessExclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionProcess

# Check whether the Defender Process Antivirus exclusions are set to non-recommended values
$ProcessCompliance = if ($DefenderProcessExclusions -in $NonRecommendedDefenderProcessExclusions) {
    $false
} else {
    $true
}
# show the non recommended values that match with the current configuration
Write-output $DefenderProcessExclusions | Where-Object {$_ -in $NonRecommendedDefenderProcessExclusions}


$output = @{
    DefenderExclusionsPath = $PathCompliance
    DefenderExclusionsExtension = $ExtensionCompliance
    DefenderExclusionsProcess = $ProcessCompliance
    }
    
    return $output | ConvertTo-Json -Compress
