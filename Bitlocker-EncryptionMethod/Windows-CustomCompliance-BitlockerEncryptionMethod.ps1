<#
   .SYNOPSIS
   Bitlocker-EncryptionMethod

   .DESCRIPTION
   Bitlocker-EncryptionMethod is a script that returns the encryption method of the Bitlocker volume.

   .INPUTS
   None. You cannot pipe objects to the script.

   .OUTPUTS
   System.Management.Automation.PSCustomObject

   .NOTES
    Example output: {"EncryptionMethod":"xtsAes256"}

   .COMPONENT
   Microsoft Intune
#>

# Required Encryption Method
$ExpectedEncryptionMethod = "xtsAes256"

# Get the encryption method of the Bitlocker volume
$EncryptionMethod = (Get-BitLockerVolume -MountPoint "C:" | Select-Object -ExpandProperty EncryptionMethod)

# Return the encryption method
$EncryptionMethodResult = [pscustomobject]@{
    EncryptionMethod = $EncryptionMethod
}

# Check whether the Encryption Method is as expected
if ($EncryptionMethodResult -ne $ExpectedEncryptionMethod) {
    Write-Output "The encryption method of the Bitlocker volume is not as expected. Expected: $ExpectedEncryptionMethod, Actual: $EncryptionMethod"
} else {
    Write-Output "The encryption method of the Bitlocker volume is as expected: $EncryptionMethod"
}

# Return the encryption method as JSON
$EncryptionMethodResult | Select-object -Property EncryptionMethod | ConvertTo-Json -Compress
