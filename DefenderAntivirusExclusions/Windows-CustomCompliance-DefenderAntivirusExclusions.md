# Microsoft Intune - Windows - Custom Compliance - Defender Antivirus Exclusions

This compliance policy checks whether the Defender Antivirus exclusions contain any non-recommended values as described here:
[Common mistakes to avoid when defining exclusions](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/common-exclusion-mistakes-microsoft-defender-antivirus?view=o365-worldwide#processes)

## Intune Configuration Policy

Defender Antivirus confgigration settings is configured within the endpoint protection Antivirus policy.
Endpoint security | Antivirus

## Intune Compliance Detection Script

The detection script checks the Defender Path, Process and File Extension exclusions and reports if the configuration includes non-recommended exclusoins as described in the above referenced article.

[Defender Antivirus Exclusions](./Windows-CustomCompliance-DefenderAntivirusExclusions.ps1)

## Intune Compliance JSON

[Defender Antivirus Exclusions Compliance Policy](./Windows-CustomCompliance-DefenderAntivirusExclusions.json)

For compliance the expected results are:

- DefenderExclusionsPath:true
- DefenderExclusionsExtension:true
- DefenderExclusionsProcess:true

## Check Compliance Results

Run the below command in PowerShell to check the compliance script results on the device.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

```powershell
# Chck the logs
Get-Content -Path "c:\programdata\Microsoft\IntuneManagementExtension\Logs\AgentExecutor.log" | Select-String -Pattern 'DefenderExclusions'
Get-Content -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\HealthScripts.log" | Select-String -Pattern 'DefenderExclusions' 
```
