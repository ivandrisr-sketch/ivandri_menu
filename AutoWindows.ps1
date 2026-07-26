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

        "1" { Modulo "DIAGNOSTICO" }

        "2" { Modulo "SEGURIDAD" }

        "3" { Modulo "MANTENIMIENTO" }

        "4" { Modulo "RED" }

        "5" { Modulo "WIFI" }

        "6" { Modulo "MICROSOFT OFFICE" }

        "7" { Modulo "WINDOWS" }

        "8" { Modulo "SOFTWARE" }

        "9" { Modulo "DRIVERS" }

        "10" { Modulo "INVENTARIO" }

        "11" { Modulo "BACKUP" }

        "12" {

            Clear-Host

            Write-Host "Buscando actualizaciones..." -ForegroundColor Green

            Start-Sleep -Seconds 2

            Write-Host ""
            Write-Host "No hay actualizaciones disponibles." -ForegroundColor Yellow

            Esperar

        }

        "0" {

            Clear-Host

            Write-Host ""
            Write-Host "Gracias por utilizar AUTO WINDOWS PRO" -ForegroundColor Green

            Start-Sleep -Seconds 2

            break

        }

        default{

            Write-Host ""
            Write-Host "Opción inválida." -ForegroundColor Red

            Start-Sleep -Seconds 2

        }

    }

}while($true)
