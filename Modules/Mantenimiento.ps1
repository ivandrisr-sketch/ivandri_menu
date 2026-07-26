# ==========================================================
# AUTO WINDOWS PRO
# MÓDULO: MANTENIMIENTO
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - MANTENIMIENTO"

function Esperar {
    Write-Host ""
    Read-Host "Presione ENTER para continuar"
}

function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "           AUTO WINDOWS PRO - MANTENIMIENTO" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}

do{

Titulo

Write-Host " [1] Liberador de espacio en disco"
Write-Host " [2] Limpiar TEMP del usuario"
Write-Host " [3] Limpiar TEMP de Windows"
Write-Host " [4] Vaciar Papelera de reciclaje"
Write-Host " [5] Reparar archivos del sistema (SFC)"
Write-Host " [6] DISM - CheckHealth"
Write-Host " [7] DISM - ScanHealth"
Write-Host " [8] DISM - RestoreHealth"
Write-Host " [9] Comprobar disco (CHKDSK)"
Write-Host "[10] Optimizar unidades"
Write-Host "[11] Reiniciar Explorador de Windows"
Write-Host "[12] Reiniciar Windows Update"
Write-Host "[13] Mostrar espacio libre"
Write-Host "[14] Mostrar uso de CPU y RAM"
Write-Host "[15] Limpiar caché DNS"
Write-Host "[16] Crear punto de restauración"
Write-Host ""
Write-Host " [0] Volver"
Write-Host ""

$opc = Read-Host "Seleccione una opción"

switch($opc){

#--------------------------------------------------------

"1"{

Clear-Host

Start-Process cleanmgr.exe

Esperar

}

#--------------------------------------------------------

"2"{

Clear-Host

try{

Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction Stop

Write-Host ""
Write-Host "Limpieza completada." -ForegroundColor Green

}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}

Esperar

}

#--------------------------------------------------------

"3"{

Clear-Host

try{

Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction Stop

Write-Host ""
Write-Host "Temp de Windows limpiado." -ForegroundColor Green

}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}

Esperar

}

#--------------------------------------------------------

"4"{

Clear-Host

try{

Clear-RecycleBin -Force -ErrorAction Stop

Write-Host ""
Write-Host "Papelera vaciada." -ForegroundColor Green

}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}

Esperar

}

#--------------------------------------------------------

"5"{

Clear-Host

sfc /scannow

Esperar

}

#--------------------------------------------------------

"6"{

Clear-Host

DISM /Online /Cleanup-Image /CheckHealth

Esperar

}

#--------------------------------------------------------

"7"{

Clear-Host

DISM /Online /Cleanup-Image /ScanHealth

Esperar

}

#--------------------------------------------------------

"8"{

Clear-Host

DISM /Online /Cleanup-Image /RestoreHealth

Esperar

}

#--------------------------------------------------------

"9"{

Clear-Host

$unidad=Read-Host "Ingrese la unidad (Ej: C:)"

chkdsk $unidad

Esperar

}

#--------------------------------------------------------

"10"{

Clear-Host

Get-Volume | Where-Object DriveLetter | Format-Table DriveLetter,HealthStatus,SizeRemaining

$unidad=Read-Host "`nUnidad a optimizar (Ej: C)"

Optimize-Volume -DriveLetter $unidad -Defrag -Verbose

Esperar

}

#--------------------------------------------------------

"11"{

Clear-Host

Stop-Process explorer -Force

Start-Process explorer.exe

Write-Host ""
Write-Host "Explorador reiniciado." -ForegroundColor Green

Esperar

}

#--------------------------------------------------------

"12"{

Clear-Host

Write-Host ""
Write-Host "Reiniciando servicios..." -ForegroundColor Cyan

Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
Stop-Service bits -Force -ErrorAction SilentlyContinue
Stop-Service cryptsvc -Force -ErrorAction SilentlyContinue

Start-Service cryptsvc
Start-Service bits
Start-Service wuauserv

Write-Host ""
Write-Host "Servicios reiniciados." -ForegroundColor Green

Esperar

}

#--------------------------------------------------------

"13"{

Clear-Host

Get-Volume |
Where-Object DriveLetter |
Select-Object DriveLetter,
@{Name="Libre (GB)";Expression={[math]::Round($_.SizeRemaining/1GB,2)}},
@{Name="Total (GB)";Expression={[math]::Round($_.Size/1GB,2)}} |
Format-Table -Auto

Esperar

}

#--------------------------------------------------------

"14"{

Clear-Host

$cpu=(Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue

$ram=(Get-CimInstance Win32_OperatingSystem)

$total=[math]::Round($ram.TotalVisibleMemorySize/1024/1024,2)

$libre=[math]::Round($ram.FreePhysicalMemory/1024/1024,2)

$usada=[math]::Round($total-$libre,2)

Write-Host ""
Write-Host "CPU utilizada : $([math]::Round($cpu,2)) %" -ForegroundColor Green
Write-Host ""
Write-Host "RAM Total     : $total GB"
Write-Host "RAM Libre     : $libre GB"
Write-Host "RAM Usada     : $usada GB"

Esperar

}

#--------------------------------------------------------

"15"{

Clear-Host

ipconfig /flushdns

Esperar

}

#--------------------------------------------------------

"16"{

Clear-Host

try{

Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue

Checkpoint-Computer `
-Description "AUTO WINDOWS PRO" `
-RestorePointType MODIFY_SETTINGS

Write-Host ""
Write-Host "Punto de restauración creado correctamente." -ForegroundColor Green

}
catch{

Write-Host ""
Write-Host "No fue posible crear el punto de restauración." -ForegroundColor Yellow

}

Esperar

}

#--------------------------------------------------------

"0"{

return

}

default{

Write-Host ""
Write-Host "Opción inválida." -ForegroundColor Red

Start-Sleep 2

}

}

}while($true)
