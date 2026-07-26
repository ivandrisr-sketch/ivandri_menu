# ==========================================================
# AUTO WINDOWS PRO
# Desarrollado por: Ivan Salcedo
# Version: 1.0
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO"

function Esperar {
    Write-Host ""
    Read-Host "Presione ENTER para volver al menú"
}

function MostrarBanner {

    Clear-Host

    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "               AUTO WINDOWS PRO v1.0" -ForegroundColor Green
    Write-Host "             Desarrollado por Ivan Salcedo" -ForegroundColor Yellow
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host " Equipo : $env:COMPUTERNAME"
    Write-Host " Usuario: $env:USERNAME"
    Write-Host " Fecha  : $(Get-Date)"
    Write-Host ""
}

function MostrarMenu {

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
    Write-Host "[12] Buscar Actualizaciones"
    Write-Host ""
    Write-Host " [0] Salir" -ForegroundColor Red
    Write-Host ""
}

function Modulo($titulo){

    Clear-Host

    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "               $titulo" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Este módulo se desarrollará en la siguiente fase." -ForegroundColor Yellow

    Esperar
}

do{

    MostrarBanner
    MostrarMenu

    $opcion = Read-Host "Seleccione una opción"

    switch($opcion){

    "1"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Diagnostico.ps1" | iex
    }

    "2"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Seguridad.ps1" | iex
    }

    "3"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Mantenimiento.ps1" | iex
    }

    "4"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Red.ps1" | iex
    }

    "5"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Wifi.ps1" | iex
    }

    "6"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Office.ps1" | iex
    }

    "7"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Windows.ps1" | iex
    }

    "8"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Software.ps1" | iex
    }

    "9"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Drivers.ps1" | iex
    }

    "10"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Inventario.ps1" | iex
    }

    "11"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Backup.ps1" | iex
    }

    "12"{
        irm "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules/Actualizar.ps1" | iex
    }

    "0"{
        break
    }

    default{
        Write-Host "Opción inválida" -ForegroundColor Red
        Start-Sleep 2
    }
}
