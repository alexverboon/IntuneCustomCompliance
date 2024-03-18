# Microsoft Intune - Custom Compliance - Windows Application Identity service

The script checks whether the Application Identity service is running and set to start automatically.

- [Configure the Application Identity service](https://learn.microsoft.com/en-us/windows/security/application-security/application-control/windows-defender-application-control/applocker/configure-the-application-identity-service)

## Intune Configuration Policy

Pending

## Intune Compliance Detection Script

[Application Identity service](./Wndows-CustomCompliance-ApplicationIdentityservice.ps1)

## Intune Compliance JSON

[Application Identity service Compliance Policy](./Wndows-CustomCompliance-ApplicationIdentityservice.json)

For compliance the expected results are:

- ServiceState:4 ([Running](https://learn.microsoft.com/en-us/dotnet/api/system.serviceprocess.servicecontrollerstatus?view=dotnet-plat-ext-8.0))
- ServiceStartupMode:2 ([Automatic](https://learn.microsoft.com/en-us/dotnet/api/system.serviceprocess.servicestartmode?view=dotnet-plat-ext-8.0))

## Check Compliance Results

Run the below command in PowerShell to check the compliance script results on the device.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

```powershell
# Chck the logs
Get-Content -Path "c:\programdata\Microsoft\IntuneManagementExtension\Logs\AgentExecutor.log" | Select-String -Pattern 'ServiceState|ServiceStartupMode'
Get-Content -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\HealthScripts.log" | Select-String -Pattern 'ServiceState|ServiceStartupMode'
```
