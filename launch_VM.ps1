param(
    [string]$vmPrefix,
    [bool]$headless
)

$vboxManagePath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Assurer que VBoxManage.exe est accessible
if (-not (Test-Path -Path $vboxManagePath)) {
    Write-Error "VBoxManage.exe not found at path: $vboxManagePath"
    exit 1
}

# Récupérer la liste des VMs et filtrer selon le préfixe
$vms = & $vboxManagePath list vms | Where-Object { $_ -like "`"$vmPrefix*" } | ForEach-Object {
    # Extraire le nom de la VM entre guillemets
    if ($_ -match "`"(.+?)`"") {
        $matches[1]
    }
}

foreach ($vm in $vms) {
    if ($headless) {
        Write-Host "Starting VM $vm in headless mode..."
        & $vboxManagePath startvm $vm --type headless
    } else {
        Write-Host "Starting VM $vm in GUI mode..."
        & $vboxManagePath startvm $vm
    }
}
