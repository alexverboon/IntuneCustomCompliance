# Microsoft Intune - Custom Compliance - Defender for Endpoint - Onboarding State

Check the following registry key to check whether a device is onboarded in Microsoft Defender for Endpoint:

HKLM:\SOFTWARE\Microsoft\Windows Advanced Threat Protection\Status\OnboardingState

| Value         | Onboardingsate |
| --------------| ---------------|
| 0 (default)   | Not onboarded  |
| 1             | Onboarded      |

- [WindowsAdvancedThreatProtection CSP](https://learn.microsoft.com/en-us/windows/client-management/mdm/windowsadvancedthreatprotection-csp)
- [Configure Microsoft Defender for Endpoint in Intune](https://learn.microsoft.com/en-us/mem/intune/protect/advanced-threat-protection-configure)

## Intune Configuration Policy

Defender for Endpoint onboarding confgigration settings is configured within the Endpoint and response policy.
Endpoint security | Endpoint detection and response

- [Microsoft Defender for Endpoint client configuration package type](https://learn.microsoft.com/en-us/mem/intune/protect/endpoint-security-edr-policy)

## Intune Compliance Detection Script

[Defender for Endpoint Onboarding State](./Wndows-CustomCompliance-MDE-Onboardingstate.ps1)

## Intune Compliance JSON

[Defender for Endpoint Onbaording State Compliance Policy](./Windows-CustomCompliance-MDE-Onboardingstate.json)

For compliance the expected results are:

- OnboardingState:1

## Check Compliance Results

Run the below command in PowerShell to check the compliance script results on the device.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

```powershell
# Chck the logs
Get-Content -Path "c:\programdata\Microsoft\IntuneManagementExtension\Logs\AgentExecutor.log" | Select-String -Pattern '"OnboardingState":'
Get-Content -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\HealthScripts.log" | Select-String -Pattern '"OnboardingState":'
```
