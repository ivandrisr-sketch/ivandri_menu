Clear-Host

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO"

function Mostrar-Menu {

    Clear-Host

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "                AUTO WINDOWS PRO v1.0" -ForegroundColor Green
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host " [1] Diagnóstico" -ForegroundColor Yellow
    Write-Host " [2] Seguridad"
    Write-Host " [3] Mantenimiento"
    Write-Host " [4] Red"
    Write-Host " [5] WiFi"
    Write-Host " [6] Office"
    Write-Host " [7] Windows"
    Write-Host " [8] Software"
    Write-Host " [9] Drivers"
    Write-Host "[10] Inventario"
    Write-Host "[11] Backup"
    Write-Host "[12] Actualizar"
    Write-Host ""
    Write-Host " [0] Salir" -ForegroundColor Red
    Write-Host ""

}

do{

Mostrar-Menu

$opcion=Read-Host "Seleccione una opcion"

switch($opcion){

"1"{

Write-Host ""
Write-Host "Modulo Diagnostico" -ForegroundColor Green
Pause

}

"2"{

Write-Host ""
Write-Host "Modulo Seguridad"
Pause

}

"3"{

Write-Host ""
Write-Host "Modulo Mantenimiento"
Pause

}

"4"{

Write-Host ""
Write-Host "Modulo Red"
Pause

}

"5"{

Write-Host ""
Write-Host "Modulo WiFi"
Pause

}

"6"{

Write-Host ""
Write-Host "Modulo Office"
Pause

}

"7"{

Write-Host ""
Write-Host "Modulo Windows"
Pause

}

"8"{

Write-Host ""
Write-Host "Modulo Software"
Pause

}

"9"{

Write-Host ""
Write-Host "Modulo Drivers"
Pause

}

"10"{

Write-Host ""
Write-Host "Modulo Inventario"
Pause

}

"11"{

Write-Host ""
Write-Host "Modulo Backup"
Pause

}

"12"{

Write-Host ""
Write-Host "Buscando actualizaciones..."
Pause

}

"0"{

break

}

default{

Write-Host "Opcion invalida" -ForegroundColor Red
Pause

}

}

}while($true)
