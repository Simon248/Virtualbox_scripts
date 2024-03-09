# Virtualbox_scripts

## Script_clonage.ps1  
This script is for windows. It will clone VM in the same folder  
```
.\Script_clonage.ps1 -nomOriginalVM "MaVMOriginale" -nombreDeClones 5
```
check path where VboxManager is installed in the script.

## launch_VM.ps1
Launch multiple VM whose name begin with arg.
```
.\launch_VM.ps1 -vmPrefix "XXX" -headless $true
```
