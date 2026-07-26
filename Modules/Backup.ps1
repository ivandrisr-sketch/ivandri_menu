# ==========================================================
# AUTO WINDOWS PRO
# MODULO: BACKUP
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - BACKUP"


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "               AUTO WINDOWS PRO - BACKUP" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



function CarpetaBackup {

    $ruta="$env:USERPROFILE\Desktop\BACKUP_AUTO_WINDOWS_PRO_$(Get-Date -Format yyyy-MM-dd_HHmm)"

    if(!(Test-Path $ruta)){

        New-Item -Path $ruta -ItemType Directory | Out-Null

    }

    return $ruta

}



do {


Titulo


Write-Host "[1] Backup Documentos"
Write-Host "[2] Backup Escritorio"
Write-Host "[3] Backup Descargas"
Write-Host "[4] Backup perfil completo usuario"
Write-Host "[5] Backup favoritos navegadores"
Write-Host "[6] Exportar perfiles WiFi"
Write-Host "[7] Backup configuracion red"
Write-Host "[8] Backup drivers"
Write-Host "[9] Copia personalizada"
Write-Host "[10] Ver backups creados"
Write-Host "[11] Generar reporte Backup"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion=Read-Host "Seleccione una opcion"



switch($opcion){


"1" {

$ruta=CarpetaBackup

Copy-Item `
"$env:USERPROFILE\Documents" `
"$ruta\Documentos" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host "Backup Documentos creado" -ForegroundColor Green

Esperar

}



"2" {

$ruta=CarpetaBackup

Copy-Item `
"$env:USERPROFILE\Desktop" `
"$ruta\Escritorio" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host "Backup Escritorio creado" -ForegroundColor Green

Esperar

}



"3" {

$ruta=CarpetaBackup

Copy-Item `
"$env:USERPROFILE\Downloads" `
"$ruta\Descargas" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host "Backup Descargas creado" -ForegroundColor Green

Esperar

}



"4" {

$ruta=CarpetaBackup


Copy-Item `
"$env:USERPROFILE" `
"$ruta\Perfil_Usuario" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host "Perfil completo respaldado" -ForegroundColor Green


Esperar

}



"5" {

$ruta=CarpetaBackup


New-Item `
"$ruta\Favoritos" `
-ItemType Directory `
-Force | Out-Null


Copy-Item `
"$env:USERPROFILE\Favorites" `
"$ruta\Favoritos" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host "Favoritos respaldados" -ForegroundColor Green


Esperar

}



"6" {

$ruta=CarpetaBackup


netsh wlan export profile `
folder="$ruta\WiFi" `
key=clear


Write-Host "Perfiles WiFi exportados" -ForegroundColor Green


Esperar

}



"7" {

$ruta=CarpetaBackup


ipconfig /all |
Out-File "$ruta\Config_Red.txt"


route print |
Out-File "$ruta\Rutas_Red.txt"


Write-Host "Configuracion de red guardada" -ForegroundColor Green


Esperar

}



"8" {

$ruta=CarpetaBackup


New-Item `
"$ruta\Drivers" `
-ItemType Directory `
-Force | Out-Null


dism /online /export-driver /destination:"$ruta\Drivers"


Write-Host "Drivers exportados" -ForegroundColor Green


Esperar

}



"9" {

$ruta=CarpetaBackup


$origen=Read-Host "Ruta de carpeta a copiar"


Copy-Item `
$origen `
"$ruta\Copia_Personalizada" `
-Recurse `
-Force


Write-Host "Copia creada" -ForegroundColor Green


Esperar

}



"10" {

Clear-Host


Write-Host "BACKUPS DISPONIBLES"

Write-Host ""


Get-ChildItem `
"$env:USERPROFILE\Desktop" |
Where-Object {
$_.Name -like "BACKUP_AUTO_WINDOWS_PRO*"
} |
Format-Table Name,CreationTime


Esperar

}



"11" {

$ruta="$env:USERPROFILE\Desktop\Reporte_Backup.txt"


"AUTO WINDOWS PRO - REPORTE BACKUP" |
Out-File $ruta


"Fecha: $(Get-Date)" |
Out-File $ruta -Append


Get-ChildItem "$env:USERPROFILE\Desktop" |
Where-Object {
$_.Name -like "BACKUP_AUTO_WINDOWS_PRO*"
} |
Out-File $ruta -Append



Write-Host ""
Write-Host "Reporte creado:"
Write-Host $ruta -ForegroundColor Green


Esperar

}



"0" {

return

}



default {

Write-Host "Opcion invalida" -ForegroundColor Red

Start-Sleep 2

}



}


}
while($true)
