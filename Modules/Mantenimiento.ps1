# ==========================================================
# AUTO WINDOWS PRO
# MODULO: MANTENIMIENTO v3.1
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - MANTENIMIENTO"


# ================= FUNCIONES =================

function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "          AUTO WINDOWS PRO - MANTENIMIENTO" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}


function EsAdministrador {

    $usuario = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($usuario)

    return $principal.IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )

}



# ================= VALIDACION =================

if(!(EsAdministrador)){

    Write-Host ""
    Write-Host "Ejecute AUTO WINDOWS PRO como Administrador" -ForegroundColor Red

    Esperar

    return

}



# ================= MENU =================

do{


Titulo


Write-Host "[1] Liberador de espacio Windows"
Write-Host "[2] Limpiar TEMP usuario"
Write-Host "[3] Limpiar TEMP Windows"
Write-Host "[4] Vaciar papelera"
Write-Host "[5] Reparar Windows SFC"
Write-Host "[6] DISM CheckHealth"
Write-Host "[7] DISM ScanHealth"
Write-Host "[8] DISM RestoreHealth"
Write-Host "[9] Comprobar disco CHKDSK"
Write-Host "[10] Optimizar unidades"
Write-Host "[11] Reiniciar Explorador"
Write-Host "[12] Reiniciar Windows Update"
Write-Host "[13] Mostrar espacio discos"
Write-Host "[14] Rendimiento del equipo"
Write-Host "[15] Limpiar DNS"
Write-Host "[16] Crear punto restauracion"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){



# ==================================================
# 1
# ==================================================

"1"{

Clear-Host

Start-Process cleanmgr.exe

Esperar

}



# ==================================================
# 2
# ==================================================

"2"{

Clear-Host

try{

Remove-Item "$env:TEMP\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP usuario limpiado" -ForegroundColor Green

}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}

Esperar

}



# ==================================================
# 3
# ==================================================

"3"{

Clear-Host

try{

Remove-Item "C:\Windows\Temp\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP Windows limpiado" -ForegroundColor Green

}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 4
# ==================================================

"4"{

Clear-Host

try{

Clear-RecycleBin `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "Papelera vaciada" -ForegroundColor Green

}
catch{

Write-Host "No fue posible vaciar papelera" -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 5
# ==================================================

"5"{

Clear-Host

sfc /scannow

Esperar

}



# ==================================================
# 6
# ==================================================

"6"{

Clear-Host

DISM /Online /Cleanup-Image /CheckHealth

Esperar

}



# ==================================================
# 7
# ==================================================

"7"{

Clear-Host

DISM /Online /Cleanup-Image /ScanHealth

Esperar

}



# ==================================================
# 8
# ==================================================

"8"{

Clear-Host

DISM /Online /Cleanup-Image /RestoreHealth

Esperar

}



# ==================================================
# 9
# ==================================================

"9"{

Clear-Host

$unidad = Read-Host "Unidad ejemplo C:"

chkdsk $unidad

Esperar

}



# ==================================================
# 10
# ==================================================

"10"{

Clear-Host

try{

Get-Volume |
Where-Object {$_.DriveLetter} |
Format-Table DriveLetter,FileSystem,SizeRemaining,Size


$unidad = Read-Host "Letra unidad ejemplo C"


Optimize-Volume `
-DriveLetter $unidad `
-Verbose


}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 11
# ==================================================

"11"{

Clear-Host

Stop-Process explorer -Force

Start-Process explorer.exe


Write-Host ""
Write-Host "Explorador reiniciado" -ForegroundColor Green


Esperar

}



# ==================================================
# 12
# ==================================================

"12"{

Clear-Host


Stop-Service wuauserv `
-Force `
-ErrorAction SilentlyContinue


Stop-Service bits `
-Force `
-ErrorAction SilentlyContinue


Start-Service bits

Start-Service wuauserv


Write-Host ""
Write-Host "Windows Update reiniciado" -ForegroundColor Green


Esperar

}



# ==================================================
# 13
# ==================================================

"13"{

Clear-Host


try{


Get-Volume |
Where-Object {$_.DriveLetter -ne $null} |
Select-Object DriveLetter,
@{
Name="Libre GB"
Expression={
[Math]::Round($_.SizeRemaining / 1GB,2)
}
},
@{
Name="Total GB"
Expression={
[Math]::Round($_.Size / 1GB,2)
}
} |
Format-Table -Auto


}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 14
# ==================================================

"14"{

Clear-Host


Write-Host ""
Write-Host "=========== RENDIMIENTO EQUIPO ===========" -ForegroundColor Cyan
Write-Host ""


try{


$pc = Get-CimInstance Win32_ComputerSystem

Write-Host "Equipo : $($pc.Name)"


$cpu = Get-CimInstance Win32_Processor


Write-Host "CPU    : $($cpu.Name)"

Write-Host "Nucleos: $($cpu.NumberOfCores)"

Write-Host "Hilos  : $($cpu.NumberOfLogicalProcessors)"


Write-Host ""


$ram = Get-CimInstance Win32_OperatingSystem


$total = [math]::Round(
$ram.TotalVisibleMemorySize / 1MB,2)


$libre = [math]::Round(
$ram.FreePhysicalMemory / 1MB,2)


$usada = [math]::Round(
$total-$libre,2)



Write-Host "RAM Total : $total GB"

Write-Host "RAM Usada : $usada GB"

Write-Host "RAM Libre : $libre GB"



$tiempo = (Get-Date)-$ram.LastBootUpTime


Write-Host ""

Write-Host "Tiempo activo: $($tiempo.Days) dias $($tiempo.Hours) horas"


}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 15
# ==================================================

"15"{

Clear-Host

ipconfig /flushdns

Esperar

}



# ==================================================
# 16
# ==================================================

"16"{

Clear-Host


try{


Checkpoint-Computer `
-Description "AUTO WINDOWS PRO" `
-RestorePointType MODIFY_SETTINGS


Write-Host ""
Write-Host "Punto restauracion creado" -ForegroundColor Green


}
catch{

Write-Host ""
Write-Host "Restauracion del sistema deshabilitada" -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# SALIR
# ==================================================

"0"{

return

}



default{

Write-Host ""
Write-Host "Opcion invalida" -ForegroundColor Red

Start-Sleep 2

}



}


}while($true)
