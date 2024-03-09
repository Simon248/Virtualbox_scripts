param (
    [string]$vmPrefix, # Préfixe pour identifier les VMs
    [bool]$headless = $false # Lancer en mode headless ou pas, false par défaut
)

# Chemin vers VBoxManage (ajuster si nécessaire)
$vboxManagePath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Liste toutes les VMs et filtre par le préfixe donné
$vms = $vboxManagePath list vms | Where-Object { $_ -like "`"$vmPrefix*" } | ForEach-Object {
    # Extrait le nom de la VM
    $vmName = ($_ -split ' ')[0].Trim('"')
    return $vmName
}

# Vérifie s'il y a des VMs à démarrer
if ($vms.Count -eq 0) {
    Write-Host "Aucune VM trouvée avec le préfixe '$vmPrefix'."
    exit
}

# Démarrer les VMs
foreach ($vm in $vms) {
    if ($headless) {
        Write-Host "Démarrage de la VM '$vm' en mode headless..."
        $vboxManagePath startvm $vm --type headless
    } else {
        Write-Host "Démarrage de la VM '$vm'..."
        $vboxManagePath startvm $vm
    }
}

Write-Host "Toutes les VMs spécifiées ont été démarrées."
