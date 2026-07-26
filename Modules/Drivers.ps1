# ==========================================================
# AUTO WINDOWS PRO
# MODULO: DRIVERS
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - DRIVERS"


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "              AUTO WINDOWS PRO - DRIVERS" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



do {


Titulo


Write-Host "[1] Mostrar dispositivos instalados"
Write-Host "[2] Detectar dispositivos con error"
Write-Host "[3] Ver informacion de drivers"
Write-Host "[4] Ver drivers de red"
Write-Host "[5] Ver drivers de video"
Write-Host "[6] Ver drivers de audio"
Write-Host "[7] Exportar drivers instalados"
Write-Host "[8] Crear reporte de drivers"
Write-Host "[9] Abrir Administrador de dispositivos"
Write-Host "[10] Buscar actualizaciones Windows"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){



"1" {

Clear-Host

Write-Host "DISPOSITIVOS INSTALADOS"
Write-Host ""


Get-PnpDevice |
Sort-Object Class |
Select-Object Status,Class,FriendlyName |
Format-Table -AutoSize


Esperar

}



"2" {

Clear-Host

Write-Host "DISPOSITIVOS CON ERROR"
Write-Host ""


Get-PnpDevice |
Where-Object {
    $_.Status -ne "OK"
} |
Select-Object Status,Class,FriendlyName |
Format-Table -AutoSize


Esperar

}



"3" {

Clear-Host

Write-Host "INFORMACION DE DRIVERS"
Write-Host ""


Get-CimInstance Win32_PnPSignedDriver |
Select-Object `
DeviceName,
DriverProviderName,
DriverVersion,
DriverDate |
Sort-Object DeviceName |
Format-Table -AutoSize


Esperar

}



"4" {

Clear-Host

Write-Host "DRIVERS DE RED"
Write-Host ""


Get-CimInstance Win32_PnPSignedDriver |
Where-Object {

$_.DeviceName -match "Network|Ethernet|Wireless|Wi-Fi"

} |
Select-Object `
DeviceName,
DriverProviderName,
DriverVersion |
Format-Table -AutoSize


Esperar

}



"5" {

Clear-Host

Write-Host "DRIVERS DE VIDEO"
Write-Host ""


Get-CimInstance Win32_PnPSignedDriver |
Where-Object {

$_.DeviceName -match "Display|Video|NVIDIA|AMD|Intel"

} |
Select-Object `
DeviceName,
DriverProviderName,
DriverVersion |
Format-Table -AutoSize


Esperar

}



"6" {

Clear-Host

Write-Host "DRIVERS DE AUDIO"
Write-Host ""


Get-CimInstance Win32_PnPSignedDriver |
Where-Object {

$_.DeviceName -match "Audio|Sound|Realtek"

} |
Select-Object `
DeviceName,
DriverProviderName,
DriverVersion |
Format-Table -AutoSize


Esperar

}



"7" {

Clear-Host


$ruta = "$env:USERPROFILE\Desktop\Backup_Drivers"


if(!(Test-Path $ruta)){

New-Item `
-Path $ruta `
-ItemType Directory | Out-Null

}


Write-Host "Exportando drivers..."



dism /online /export-driver /destination:$ruta



Write-Host ""

Write-Host "Backup de drivers creado:" -ForegroundColor Green

Write-Host $ruta



Esperar

}



"8" {

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Reporte_Drivers.txt"



"AUTO WINDOWS PRO - REPORTE DRIVERS" |
Out-File $ruta


"Fecha: $(Get-Date)" |
Out-File $ruta -Append



Get-CimInstance Win32_PnPSignedDriver |
Select-Object `
DeviceName,
DriverProviderName,
DriverVersion,
DriverDate |
Out-File $ruta -Append



Write-Host ""

Write-Host "Reporte creado correctamente:" -ForegroundColor Green

Write-Host $ruta



Esperar

}



"9" {

Clear-Host


Start-Process `
"devmgmt.msc"


Esperar

}



"10" {

Clear-Host


Write-Host "Abriendo Windows Update..."

Start-Process `
"ms-settings:windowsupdate"



Esperar

}



"0" {

return

}



default {

Write-Host ""

Write-Host "Opcion invalida" -ForegroundColor Red

Start-Sleep 2

}



}


}
while($true)
