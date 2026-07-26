# ==========================================================
# AUTO WINDOWS PRO
# MÓDULO: DIAGNÓSTICO
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - DIAGNÓSTICO"

function Esperar {
    Write-Host ""
    Read-Host "Presione ENTER para continuar"
}

do{

Clear-Host

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "            AUTO WINDOWS PRO - DIAGNÓSTICO" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host " [1] Información General"
Write-Host " [2] Procesador"
Write-Host " [3] Memoria RAM"
Write-Host " [4] Discos"
Write-Host " [5] BIOS"
Write-Host " [6] Tarjeta Madre"
Write-Host " [7] Tarjetas de Red"
Write-Host " [8] Adaptadores WiFi"
Write-Host " [9] Tarjeta Gráfica"
Write-Host "[10] Sistema Operativo"
Write-Host "[11] Espacio en Disco"
Write-Host "[12] Procesos"
Write-Host "[13] Servicios"
Write-Host "[14] Programas Instalados"
Write-Host "[15] Variables de Entorno"
Write-Host "[16] Usuarios Locales"
Write-Host "[17] Carpetas Compartidas"
Write-Host "[18] Conexiones TCP"
Write-Host "[19] Exportar Informe"
Write-Host ""
Write-Host " [0] Volver"
Write-Host ""

$opc = Read-Host "Seleccione una opción"

switch($opc){

"1"{

Clear-Host

systeminfo

Esperar

}

"2"{

Clear-Host

Get-CimInstance Win32_Processor |
Format-List *

Esperar

}

"3"{

Clear-Host

Get-CimInstance Win32_PhysicalMemory |
Format-Table Manufacturer,BankLabel,Capacity,Speed,PartNumber -Auto

Esperar

}

"4"{

Clear-Host

Get-Disk

Esperar

}

"5"{

Clear-Host

Get-CimInstance Win32_BIOS |
Format-List *

Esperar

}

"6"{

Clear-Host

Get-CimInstance Win32_BaseBoard |
Format-List *

Esperar

}

"7"{

Clear-Host

Get-NetAdapter

Esperar

}

"8"{

Clear-Host

netsh wlan show interfaces

Esperar

}

"9"{

Clear-Host

Get-CimInstance Win32_VideoController |
Select Name,AdapterRAM,DriverVersion |
Format-Table -Auto

Esperar

}

"10"{

Clear-Host

Get-ComputerInfo |
Select WindowsProductName,
WindowsVersion,
OsArchitecture,
CsName

Esperar

}

"11"{

Clear-Host

Get-Volume |
Format-Table DriveLetter,
FileSystemLabel,
SizeRemaining,
Size -Auto

Esperar

}

"12"{

Clear-Host

Get-Process |
Sort CPU -Descending |
Select -First 25 |
Format-Table Name,CPU,ID

Esperar

}

"13"{

Clear-Host

Get-Service |
Sort Status |
Format-Table Name,Status

Esperar

}

"14"{

Clear-Host

Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select DisplayName,DisplayVersion |
Sort DisplayName

Esperar

}

"15"{

Clear-Host

Get-ChildItem Env:

Esperar

}

"16"{

Clear-Host

Get-LocalUser

Esperar

}

"17"{

Clear-Host

Get-SmbShare

Esperar

}

"18"{

Clear-Host

netstat -ano

Esperar

}

"19"{

Clear-Host

$archivo="$env:USERPROFILE\Desktop\Informe_PC.txt"

systeminfo > $archivo

Write-Host ""
Write-Host "Informe exportado correctamente." -ForegroundColor Green
Write-Host ""
Write-Host $archivo

Esperar

}

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
