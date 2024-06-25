# Script pour cloner une VM VirtualBox dans le même dossier et changer le nom d'hôte de chaque clone sous Windows

param(
    [string]$nomOriginalVM,  # Nom de la VM originale à cloner
    [int]$nombreDeClones     # Nombre de clones à créer
    [string]$prefixeNomVM    # Préfixe pour le nom des VMs clonées
)

# Chemin vers VBoxManage (ajuster si nécessaire)
$vboxManagePath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Obtenir le chemin du dossier de la VM originale
$infoVM = & $vboxManagePath showvminfo $nomOriginalVM --machinereadable
$dossierVM = ($infoVM | Where-Object { $_ -match "CfgFile=" }) -split '=' | Select-Object -Last 1
$dossierVM = $dossierVM.Trim('"')
$dossierVM = [System.IO.Path]::GetDirectoryName($dossierVM)

# Boucle pour créer les clones
for ($i = 1; $i -le $nombreDeClones; $i++) {
    $nouveauNomVM = "$prefixeNomVM$i"
    Write-Host "Création du clone: $nouveauNomVM dans le dossier: $dossierVM"

    # Commande pour cloner la VM avec le spécificateur de dossier
    & $vboxManagePath clonevm $nomOriginalVM --name $nouveauNomVM --basefolder $dossierVM --register
}

Write-Host "Clonage terminé pour $nombreDeClones clones."
