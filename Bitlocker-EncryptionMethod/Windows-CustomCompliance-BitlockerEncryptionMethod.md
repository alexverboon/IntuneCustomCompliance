# Microsoft Intune - Custom Compliance - Bitlocker Encryption Method

The Windows Custom Compliance Bitlocker Encryption method checks whether the Encryption method is set as defined.

Bitlocker can be configured using one of the following [Encryption Methods](https://learn.microsoft.com/en-us/graph/api/resources/intune-deviceconfig-bitlockerencryptionmethod?view=graph-rest-1.0)

| Member     | Value | Description      |
|------------|-------|------------------|
| aesCbc128  | 3     | AES-CBC 128-bit. |
| aesCbc256  | 4     | AES-CBC 256-bit. |
| xtsAes128  | 6     | XTS-AES 128-bit. |
| xtsAes256  | 7     | XTS-AES 256-bit. |

## Intune Compliance Detection Script

[Bitlocker Encryption Method](./Windows-CustomCompliance-BitlockerEncryptionMethod.ps1)

Change the *$ExpectedEncryptionMethod* variable if you require another Encryption Method.

## Intune Compliance JSON

[Bitlocker Encryption Compliance Policy](./Windows-CustomCompliance-BitlockerEncryptionMethod.json)

For compliance the expected results are:

- EncryptionMethod:xtsAes256

## Check Compliance Results

Run the below command in PowerShell to check the compliance script results on the device.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

```powershell
# Chck the logs
Get-Content -Path "c:\programdata\Microsoft\IntuneManagementExtension\Logs\AgentExecutor.log" | Select-String -Pattern 'EncryptionMethod'
Get-Content -Path "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\HealthScripts.log" | Select-String -Pattern 'EncryptionMethod'
```
