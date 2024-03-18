<#
    .SYNOPSIS
    Custom compliance script to report Application Identity service state and startup configuration

    .DESCRIPTION
    This script checks the service Startup Type and Service state. The service must be 'running' and startup must be set to 'Automatic'
    
    .Notes
    Example output: {"ServiceState":4,"ServiceStartupMode":2}
#>

$ServiceState = get-service -name "Appidsvc" | Select-object Status
$ServiceStartupMode = get-service -name "Appidsvc" | Select-object StartType

$output = @{
	ServiceState = $ServiceState.Status
	ServiceStartupMode = $ServiceStartupMode.StartType
}

return $output | ConvertTo-Json -Compress