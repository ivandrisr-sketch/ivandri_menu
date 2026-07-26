# ==========================================================
# AUTO WINDOWS PRO
# MODULO: MANTENIMIENTO v3.0
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
    Write-Host "            AUTO WINDOWS PRO - MANTENIMIENTO" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}


function Admin {

    $usuario = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($usuario)

    return $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)

}


# ================= VALIDAR ADMIN =================


if(!(Admin)){

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
Write-Host "[10] Optimizar discos"
Write-Host "[11] Reiniciar Explorador"
Write-Host "[12] Reiniciar Windows Update"
Write-Host "[13] Mostrar espacio discos"
Write-Host "[14] Rendimiento del equipo"
Write-Host "[15] Limpiar DNS"
Write-Host "[16] Crear punto restauracion"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$op = Read-Host "Seleccione una opcion"



switch($op){



# -------------------------------------------------

"1"{

Clear-Host

cleanmgr.exe

Esperar

}



# -------------------------------------------------

"2"{

Clear-Host


try{

Remove-Item "$env:TEMP\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP usuario eliminado correctamente" -ForegroundColor Green


}

catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# -------------------------------------------------

"3"{

Clear-Host


try{


Remove-Item "C:\Windows\Temp\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP Windows eliminado" -ForegroundColor Green


}

catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# -------------------------------------------------

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



# -------------------------------------------------

"5"{

Clear-Host

sfc /scannow

Esperar

}



# -------------------------------------------------

"6"{

Clear-Host

DISM /Online /Cleanup-Image /CheckHealth

Esperar

}



# -------------------------------------------------

"7"{

Clear-Host

DISM /Online /Cleanup-Image /ScanHealth

Esperar

}



# -------------------------------------------------

"8"{

Clear-Host

DISM /Online /Cleanup-Image /RestoreHealth

Esperar

}



# -------------------------------------------------

"9"{

Clear-Host


$unidad = Read-Host "Unidad a revisar ejemplo C:"


chkdsk $unidad


Esperar

}



# -------------------------------------------------

"10"{

Clear-Host


Write-Host "Unidades encontradas:"
Write-Host ""


Get-Disk |
Format-Table Number,FriendlyName,MediaType,Size -Auto


$disk = Read-Host "Numero del disco"


try{


Optimize-Volume `
-DiskNumber $disk `
-ReTrim `
-Verbose


}

catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# -------------------------------------------------

"11"{

Clear-Host


Stop-Process explorer -Force


Start-Process explorer.exe


Write-Host ""
Write-Host "Explorador reiniciado" -ForegroundColor Green


Esperar

}



# -------------------------------------------------

"12"{

Clear-Host


Write-Host "Reiniciando servicios Windows Update"


Stop-Service wuauserv `
-Force `
-ErrorAction SilentlyContinue


Stop-Service bits `
-Force `
-ErrorAction SilentlyContinue



Start-Service bits

Start-Service wuauserv


Write-Host ""
Write-Host "Servicios reiniciados" -ForegroundColor Green


Esperar

}



# -------------------------------------------------

"13"{

Clear-Host


Get-Volume |
Where-Object DriveLetter |
Select DriveLetter,

@{N="Libre GB";E={
[Math]::Round($_.SizeRemaining/1GB,2)}},

@{N="Total GB";E={
[Math]::Round($_.Size/1GB,2)}}

|
Format-Table -Auto



Esperar

}



# -------------------------------------------------

"14"{

Clear-Host


Write-Host ""
Write-Host "============== RENDIMIENTO EQUIPO ==============" -ForegroundColor Cyan
Write-Host ""


try{


$pc = Get-CimInstance Win32_ComputerSystem


Write-Host "Equipo      : $($pc.Name)"


$cpu = Get-CimInstance Win32_Processor


Write-Host "CPU         : $($cpu.Name)"

Write-Host "Nucleos     : $($cpu.NumberOfCores)"

Write-Host "Hilos       : $($cpu.NumberOfLogicalProcessors)"

Write-Host ""


$usoCPU = $cpu.LoadPercentage


Write-Host "Uso CPU     : $usoCPU %" -ForegroundColor Yellow


$ram = Get-CimInstance Win32_OperatingSystem


$total = [Math]::Round(
$ram.TotalVisibleMemorySize/1MB,2)


$libre = [Math]::Round(
$ram.FreePhysicalMemory/1MB,2)


$usada = [Math]::Round(
$total-$libre,2)



Write-Host ""

Write-Host "RAM Total   : $total GB"

Write-Host "RAM Usada   : $usada GB"

Write-Host "RAM Libre   : $libre GB"



Write-Host ""



$uptime=(Get-Date)-$ram.LastBootUpTime


Write-Host "Encendido   : $($uptime.Days) dias $($uptime.Hours) horas"



}

catch{

Write-Host $_.Exception.Message -ForegroundColor Red

}


Esperar


}



# -------------------------------------------------

"15"{

Clear-Host


ipconfig /flushdns


Esperar


}



# -------------------------------------------------

"16"{

Clear-Host


try{


Checkpoint-Computer `
-Description "AUTO WINDOWS PRO" `
-RestorePointType MODIFY_SETTINGS


Write-Host ""
Write-Host "Punto creado correctamente" -ForegroundColor Green


}

catch{


Write-Host ""
Write-Host "Restauracion del sistema deshabilitada" -ForegroundColor Yellow


}


Esperar


}



# -------------------------------------------------

"0"{

return

}



default{

Write-Host "Opcion incorrecta" -ForegroundColor Red

Start-Sleep 2

}



}



}while($true)
