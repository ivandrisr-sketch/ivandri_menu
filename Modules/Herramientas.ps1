# ==========================================================
# AUTO WINDOWS PRO
# MODULO: HERRAMIENTAS DEL SISTEMA
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - HERRAMIENTAS DEL SISTEMA"


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "      AUTO WINDOWS PRO - HERRAMIENTAS DEL SISTEMA" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



do {


Titulo


Write-Host "[1] Abrir CMD Administrador"
Write-Host "[2] Abrir PowerShell"
Write-Host "[3] Administrador de tareas"
Write-Host "[4] Administracion de equipos"
Write-Host "[5] Administracion de discos"
Write-Host "[6] Administrador de dispositivos"
Write-Host "[7] Servicios Windows"
Write-Host "[8] Visor de eventos"
Write-Host "[9] Editor de registro"
Write-Host "[10] Directivas locales"
Write-Host "[11] Usuarios y grupos locales"
Write-Host "[12] Informacion BIOS/UEFI"
Write-Host "[13] Informacion del sistema"
Write-Host "[14] Variables de entorno"
Write-Host "[15] Comprobar integridad Windows"
Write-Host "[16] Reparacion DISM"
Write-Host "[17] Conexiones de red"
Write-Host "[18] Tareas programadas"
Write-Host "[19] Recursos compartidos"
Write-Host "[20] Diagnostico completo"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){



"1" {

Start-Process cmd -Verb RunAs

Esperar

}



"2" {

Start-Process powershell -Verb RunAs

Esperar

}



"3" {

Start-Process taskmgr

Esperar

}



"4" {

Start-Process compmgmt.msc

Esperar

}



"5" {

Start-Process diskmgmt.msc

Esperar

}



"6" {

Start-Process devmgmt.msc

Esperar

}



"7" {

Start-Process services.msc

Esperar

}



"8" {

Start-Process eventvwr.msc

Esperar

}



"9" {

Start-Process regedit.exe

Esperar

}



"10" {

Start-Process gpedit.msc

Esperar

}



"11" {

Start-Process lusrmgr.msc

Esperar

}



"12" {

Clear-Host

Write-Host "INFORMACION BIOS / UEFI"
Write-Host ""


Get-CimInstance Win32_BIOS |
Format-List Manufacturer,Name,Version,SerialNumber


Esperar

}



"13" {

Clear-Host

Write-Host "INFORMACION DEL SISTEMA"
Write-Host ""


Get-ComputerInfo |
Select-Object `
WindowsProductName,
WindowsVersion,
OsArchitecture,
CsName,
CsManufacturer,
CsModel |
Format-List


Esperar

}



"14" {

Clear-Host

Write-Host "VARIABLES DE ENTORNO"
Write-Host ""


Get-ChildItem Env: |
Format-Table Name,Value -AutoSize


Esperar

}



"15" {

Clear-Host

Write-Host "Comprobando archivos del sistema..."
Write-Host ""

sfc /scannow


Esperar

}



"16" {

Clear-Host

Write-Host "Reparacion DISM"
Write-Host ""

DISM /Online /Cleanup-Image /RestoreHealth


Esperar

}



"17" {

Clear-Host

Write-Host "CONEXIONES DE RED ACTIVAS"
Write-Host ""


netstat -ano


Esperar

}



"18" {

Clear-Host

Write-Host "TAREAS PROGRAMADAS"

Write-Host ""


Get-ScheduledTask |
Select TaskName,State,TaskPath |
Format-Table -AutoSize


Esperar

}



"19" {

Clear-Host

Write-Host "RECURSOS COMPARTIDOS"

Write-Host ""


Get-SmbShare |
Format-Table -AutoSize


Esperar

}



"20" {

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Diagnostico_AutoWindowsPro.txt"



"AUTO WINDOWS PRO - DIAGNOSTICO COMPLETO" |
Out-File $ruta


"Fecha: $(Get-Date)" |
Out-File $ruta -Append



"===== EQUIPO =====" |
Out-File $ruta -Append


Get-ComputerInfo |
Out-File $ruta -Append



"===== BIOS =====" |
Out-File $ruta -Append


Get-CimInstance Win32_BIOS |
Out-File $ruta -Append



"===== RED =====" |
Out-File $ruta -Append


ipconfig /all |
Out-File $ruta -Append



"===== PROCESOS =====" |
Out-File $ruta -Append


Get-Process |
Select-Object -First 50 |
Out-File $ruta -Append



Write-Host ""

Write-Host "Diagnostico generado correctamente:" -ForegroundColor Green

Write-Host $ruta



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
