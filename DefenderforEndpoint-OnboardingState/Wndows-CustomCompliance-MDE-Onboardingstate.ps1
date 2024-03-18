<#
   .SYNOPSIS
   DefenderforEndpoint-OnboardingState

   .DESCRIPTION
   DefenderforEndpoint-OnboardingState checks the Client onboarding state for Defender for Endpoint

   .INPUTS
   None. You cannot pipe objects to the script.

   .OUTPUTS
   System.Management.Automation.PSCustomObject

   .NOTES
    Example output: {"OnboardingState":1}

   .COMPONENT
   Microsoft Intune
#>

# Defender for Endpoint - Onboardingstate Registry settings
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows Advanced Threat Protection\Status"
$propertyName = "OnboardingState"
$expectedValue = 1

# Get the Defender for Endpoint Onboarding State
# Check if the registry key exists
if (Test-Path $registryPath) {
    try {
        # Try to get the value of the specified property
        $OnboardingState = (Get-ItemProperty -Path $registryPath -Name $propertyName).$propertyName
        if ($OnboardingState -eq $expectedValue) {
            Write-output "Registry key '$registryPath\$propertyName' exists and has the expected value ($expectedValue)."
        } else {
            Write-output "Registry key '$registryPath\$propertyName' exists, but its value is not $expectedValue."
        }
    } catch {
        Write-output "Failed to retrieve the value of '$propertyName' in registry key '$registryPath'."
    }
} else {
    Write-output "Registry key '$registryPath' does not exist."
}


# Return the encryption method
$OnboardingStateResult = [pscustomobject]@{
    OnboardingState = $OnboardingState
}

# Return the encryption method as JSON
$OnboardingStateResult | Select-object -Property OnboardingState | ConvertTo-Json -Compress
