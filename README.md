# Intune Custom Compliance Policies

## The Intune Custom Compliance Policy Repository

This repository contains detection/discovery scripts and JSON files for Microsoft Intune *Custom* comppliance scripts and policies. Each Custom compliance contains the following artifacts.

| Artifact | Description |
| ---------|-------------|
| CustomCompliance.md | Description of the custom compliance with references to the detection script and compliance validation JSON file |
| CustomCompliance-.ps | PowerShell detection script |
| CustomCompliance-.json |  a JSON file that identifies the settings and value pairs that you want to use for custom compliance.|

## Microsoft Intune custom compliance policies

Microsoft Intune [custom compliance policies](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-use-custom-settings) allow organizations to define specific requirements and conditions that devices must meet to be considered compliant with organizational standards. These policies enable administrators to tailor compliance checks based on unique business needs and security requirements.

Examples:

- Microsoft Defender Antivirus Network Protection
- Microsoft Defender Antivirus settings and exclusions
- Bitlocker Encryption Method
- Windows Services (Startupmode and Running status)
- Microsoft Defender for Endpoint onboarding status

## Intune Custom Compliance Policies and Scripts

### Windows Complance

| Compliance Policy | Description |
| ------------------| ------------ |
| [Defender Antivirus Settings](./DefenderAntivirus/Windows-CustomCompliance-DefenderAntivirus.md) | Checks the configuration of several important Defender Antivirus settings |
| [Defender Antivirus Exclusions](./DefenderAntivirusExclusions/Windows-CustomCompliance-DefenderAntivirusExclusions.md) | Checks for non-recommended exclusions |
| [Defender for Endpoint Onboarding state](./DefenderforEndpoint-OnboardingState/Windows-CustomCompliance-MDE-Onboardingstate.md) | Checks the onboarding state of Defender for Endpoint |
| [Bitlocker Encyrption Method](./Bitlocker/Bitlocker-EncryptionMethod.md) | Checks the Bitlocker Encryption Mode configuration |
| [Windows Firewall Auditing](./Firewall-Auditing/Windows-CustomCompliance-FirewallAuditing.md) | Chckes the Windows Firewall auditing configuration |
| [Windows Application Identity Service](./Windows-Service/Application%20Identity%20service/Windows-CustomCompliance-ApplicationIdentityservice.md) | Checks service startup and running state |

### Linux Compliance

| Compliance Policy | Description  |
| ------------------| ------------ |

## Microsoft Intune custom compliance configuration

### Upload the detection script

1. Sign into Microsoft Intune admin center and go to Endpoint security > Device compliance > Scripts > Add > (choose your platform).
2. On Basics, provide a Name.
3. On Settings, add your script to Detection script. Review your script carefully. Intune doesn’t validate the script for syntax or programmatic errors.
4. For Windows only - On Settings, configure the following behavior for the PowerShell script:
    - Run this script using the logged on credentials – By default, the script runs in the System context on the device. Set this value to Yes to have it run in the context of the logged-on user. If the user isn’t logged in, the script defaults back to the System context.
    - Enforce script signature check – For more information, see about_Signing in the PowerShell documentation.
    - Run script in 64 bit PowerShell Host – By default, the script runs using the 32-bit PowerShell host. Set this value to Yes to force the script to run using the 64-bit host instead.
5. Complete the script creation process. The script is now visible in the Scripts pane of the Microsoft Intune admin center and is available to select when configuring compliance policies.

Source: [Add a discovery script to Intune](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-custom-script#add-a-discovery-script-to-intune)

### Create custom compliance policy

1. Sign in to the Microsoft Intune admin center.
2. Go to Devices > Compliance and choose Create policy.
3. Select a Platform for this policy: ***Windows 10 and later***
4. On the Basics tab, specify a Name that helps you identify them later.
5. On the Compliance settings tab, expand the available categories and select ***Custom Compliance***
    a. On the Compliance settings page, expand Custom Compliance and set Custom compliance to Require.
    b. For Select your discovery script, select Click to select, and then specify a script that’s been previously added to the Microsoft Intune admin center. This script must have been uploaded before you begin to create the policy.
    c. For Upload and validate the JSON file with your custom compliance settings, select the folder icon and then locate and add the JSON file for Windows that you want to use with this policy.
6. On the Actions for noncompliance tab, specify a sequence of actions to apply automatically to devices that don't meet this compliance policy.
7. On the Scope tags tab, select tags to help filter policies to specific groups if needed.
8. On the Assignments tab, assign the policy to your groups.
9. Review the settings and save the policy.

Source: [Create a compliance policy in Microsoft Intune](https://learn.microsoft.com/en-us/mem/intune/protect/create-compliance-policy)

### See the results

Now wait for the Compliance policy to be processed on the client. Run the following command on a device that has the policy assigned to enforece the Intune policy synch.

```powershell
# Trigger Intune Synch
Start-Process -FilePath "C:\Program Files (x86)\Microsoft Intune Management Extension\Microsoft.Management.Services.IntuneWindowsAgent.exe" -ArgumentList intunemanagementextension://synccompliance
```

![CustomCompliancePolicy](https://github.com/alexverboon/IntuneCustomCompliance/blob/739ceb82e083f2cb60deb80fa07bed4abf4f8517/media/CompliancePolicyResult1.png?raw=true)
![CustomComplianceResult](https://github.com/alexverboon/IntuneCustomCompliance/blob/739ceb82e083f2cb60deb80fa07bed4abf4f8517/media/CompliancePolicyResult2.png?raw=true)

## References

### Microsoft documentation

- [Use compliance policies to set rules for devices you manage with Intune](https://learn.microsoft.com/en-us/mem/intune/protect/device-compliance-get-started)
- [Use custom compliance policies and settings for Linux and Windows devices with Microsoft Intune](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-use-custom-settings)
- [Custom compliance discovery scripts for Microsoft Intune](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-custom-script)
- [Custom compliance JSON files for Microsoft Intune](https://learn.microsoft.com/en-us/mem/intune/protect/compliance-custom-json)

### GitHub

- [Intune Customer Experience Engineering Shell Script Repo](https://github.com/microsoft/shell-intune-samples/tree/master)
- [Linux custom compliance script returning null](https://github.com/microsoft/shell-intune-samples/issues/87)

### Blogs

- [Triggering Intune Management Extension (IME) Sync](https://oliverkieselbach.com/2020/11/03/triggering-intune-management-extension-ime-sync/)
- [Intune Policy Processing on Windows 10 explained](https://oliverkieselbach.com/2019/07/18/intune-policy-processing-on-windows-10-explained/)

## Credits

- [Nicola Suter](https://twitter.com/nicolonsky) provided me with helpful inputs, examples and concepts.

## Disclaimer

The scripts included in this repository are provided as-is, with no warranties. Always test scripts in a safe and recoverable environment before deploying them in production.

## Contributions, issues, and feature requests are welcome

Feel free to check the issues page.

## License

This project is MIT licensed.
