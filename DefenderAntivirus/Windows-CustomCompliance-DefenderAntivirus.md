# Microsoft Intune - Windows - Custom Compliance - Defender Antivirus Settings

This compliance policy checks the following Defender Antivirus settings

| Setting   | Expected Value |
| ----------| ---------------|
| Tamper Protection | true   |
| Cloud Protection | 2       |
| Realtime Protection | true |
| Antivirus Enabled | true   |
| Cloud Block Level | 2 or higher |
| Cloud Block Extended Timeout | 50 |
| Network Protection | true |

## Intune Configuration Policy

Defender Antivirus confgigration settings is configured within the endpoint protection Antivirus policy.
Endpoint security | Antivirus

- [Tamper Protection](https://learn.microsoft.com/en-us/windows/client-management/mdm/defender-csp#configurationtamperprotection)
- [Cloud Protection](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender?WT.mc_id=Portal-fx#allowcloudprotection)
- [Allow Realtime Monitoring](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender?WT.mc_id=Portal-fx#allowrealtimemonitoring)
- [Cloud Block Level](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender?WT.mc_id=Portal-fx#cloudblocklevel)
- [Cloud Block Extended Timeout](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender?WT.mc_id=Portal-fx#cloudextendedtimeout)
- [Network Protection](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-defender?WT.mc_id=Portal-fx#enablenetworkprotection)

## Intune Compliance Detection Script

[Defender Antivirus Settings](./Windows-CustomCompliance-DefenderAntivirus.ps1)

## Intune Compliance JSON

[Defender Antivirus Settings Compliance Policy](./Windows-CustomCompliance-DefenderAntivirus.json)

For compliance the expected results are:

- RealTimeProtectionEnabled:true
- CloudBlockLevel:2
- CloudExtendedTimeout:50
- TamperProtectionEnabled:true
- NetworkProtectionEnabled:1
- CloudProtection:2
- AntivirusEnabled:true

## Check Compliance Results

Run the below command in PowerShell to check the compliance script results on the device.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

```powershell
# Chck the logs
Get-Content -Path "c:\programdata\Microsoft\IntuneManagementExtension\Logs\AgentExecutor.log" | Select-String -Pattern 'CloudBlockLevel|RealTimeProtectionEnabled|CloudExtendedTimeout|AntivirusEnabled|TamperProtectionEnabled|NetworkProtectionEnabled|CloudProtection'
Get-Content -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\HealthScripts.log" | Select-String -Pattern 'CloudBlockLevel|RealTimeProtectionEnabled|CloudExtendedTimeout|AntivirusEnabled|TamperProtectionEnabled|NetworkProtectionEnabled|CloudProtection'
