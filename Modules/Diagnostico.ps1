Clear-Host
$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - DIAGNÓSTICO"

do {

    Clear-Host

    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "          MÓDULO DIAGNÓSTICO" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "[1] Información del equipo"
    Write-Host "[2] Procesador"
    Write-Host "[3] Memoria RAM"
    Write-Host "[4] Discos"
    Write-Host "[5] Adaptadores de red"
    Write-Host "[6] Espacio en disco"
    Write-Host "[7] Procesos"
    Write-Host "[8] Servicios"
    Write-Host "[0] Volver"

    $op = Read-Host "`nSeleccione una opción"

    switch ($op) {

        "1" {
            systeminfo
            Read-Host "`nPresione ENTER"
        }

        "2" {
            Get-CimInstance Win32_Processor | Format-List Name, NumberOfCores, MaxClockSpeed
            Read-Host "`nPresione ENTER"
        }

        "3" {
            Get-CimInstance Win32_PhysicalMemory |
                Format-Table Manufacturer, Capacity, Speed
            Read-Host "`nPresione ENTER"
        }

        "4" {
            Get-Disk
            Read-Host "`nPresione ENTER"
        }

        "5" {
            Get-NetAdapter
            Read-Host "`nPresione ENTER"
        }

        "6" {
            Get-Volume
            Read-Host "`nPresione ENTER"
        }

        "7" {
            Get-Process | Sort CPU -Descending | Select -First 20
            Read-Host "`nPresione ENTER"
        }

        "8" {
            Get-Service
            Read-Host "`nPresione ENTER"
        }

        "0" {
            return
        }

        default {
            Write-Host "Opción inválida" -ForegroundColor Red
            Start-Sleep 2
        }
    }

} while ($true)
