# ==========================================================
# AUTO WINDOWS PRO
# MODULO: SOFTWARE
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - SOFTWARE"


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "              AUTO WINDOWS PRO - SOFTWARE" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



do {


Titulo


Write-Host "[1] Ver programas instalados"
Write-Host "[2] Buscar programa"
Write-Host "[3] Programas de inicio Windows"
Write-Host "[4] Procesos en ejecucion"
Write-Host "[5] Servicios Windows"
Write-Host "[6] Aplicaciones Microsoft Store"
Write-Host "[7] Actualizaciones instaladas"
Write-Host "[8] Generar inventario software"
Write-Host "[9] Abrir administrador aplicaciones"
Write-Host "[10] Limpiar temporales"
Write-Host "[11] Detectar software portable"

Write-Host ""
Write-Host "[0] Volver"
Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){


"1" {

Clear-Host

Write-Host "PROGRAMAS INSTALADOS"
Write-Host ""


Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
Where-Object {$_.DisplayName} |
Select-Object DisplayName,DisplayVersion,Publisher |
Sort-Object DisplayName |
Format-Table -AutoSize


Esperar

}



"2" {

Clear-Host


$buscar = Read-Host "Ingrese nombre del programa"


Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
Where-Object {

$_.DisplayName -like "*$buscar*"

} |
Select-Object DisplayName,DisplayVersion,Publisher |
Format-Table -AutoSize


Esperar

}



"3" {

Clear-Host


Write-Host "PROGRAMAS DE INICIO"


Get-CimInstance Win32_StartupCommand |
Select-Object Name,Command,Location |
Format-Table -AutoSize


Esperar

}



"4" {

Clear-Host


Write-Host "PROCESOS ACTIVOS"


Get-Process |
Sort-Object CPU -Descending |
Select-Object -First 30 Name,Id,CPU,WS |
Format-Table -AutoSize


Esperar

}



"5" {

Clear-Host


Write-Host "SERVICIOS WINDOWS"


Get-Service |
Sort-Object DisplayName |
Select-Object Status,Name,DisplayName |
Format-Table -AutoSize


Esperar

}



"6" {

Clear-Host


Write-Host "APLICACIONES MICROSOFT STORE"


Get-AppxPackage |
Select-Object Name,Version |
Sort-Object Name |
Format-Table -AutoSize


Esperar

}



"7" {

Clear-Host


Write-Host "ACTUALIZACIONES WINDOWS"


Get-HotFix |
Sort-Object InstalledOn -Descending |
Format-Table -AutoSize


Esperar

}



"8" {

Clear-Host


$ruta = "$env:USERPROFILE\Desktop\Inventario_Software.txt"


"====================================" | Out-File $ruta

"AUTO WINDOWS PRO - SOFTWARE" | Out-File $ruta -Append

"Fecha: $(Get-Date)" | Out-File $ruta -Append


Get-ItemProperty `
HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,
HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
Where-Object {$_.DisplayName} |
Select-Object DisplayName,DisplayVersion,Publisher |
Out-File $ruta -Append


Write-Host ""
Write-Host "Inventario creado correctamente:" -ForegroundColor Green
Write-Host $ruta


Esperar

}



"9" {

Clear-Host


Start-Process "ms-settings:appsfeatures"


Esperar

}



"10" {

Clear-Host


Write-Host "Limpiando archivos temporales..."


Remove-Item "$env:TEMP\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Remove-Item "C:\Windows\Temp\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "Limpieza completada" -ForegroundColor Green


Esperar

}



"11" {

Clear-Host


Write-Host "BUSCANDO EJECUTABLES PORTABLES"


Get-ChildItem C:\ `
-Recurse `
-Filter *.exe `
-ErrorAction SilentlyContinue |
Where-Object {

$_.FullName -notmatch "Windows"

} |
Select-Object FullName |
Format-Table -AutoSize


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
