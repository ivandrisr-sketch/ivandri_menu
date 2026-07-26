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

do {

    Clear-Host

    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "           AUTO WINDOWS PRO - MANTENIMIENTO" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

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
    Write-Host "[12] Reiniciar servicios de Windows Update"
    Write-Host "[13] Mostrar espacio libre"
    Write-Host "[14] Mostrar uso de CPU y RAM"
    Write-Host "[15] Limpiar caché DNS"
    Write-Host "[16] Crear punto de restauración"
    Write-Host ""
    Write-Host " [0] Volver"
    Write-Host ""

    $opc = Read-Host "Seleccione una opción"

    switch ($opc) {

        "1" {
            Clear-Host
            Start-Process cleanmgr.exe
            Esperar
        }

        "2" {
            Clear-Host
            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Archivos temporales del usuario eliminados." -ForegroundColor Green
            Esperar
        }

        "3" {
            Clear-Host
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Archivos temporales de Windows eliminados." -ForegroundColor Green
            Esperar
        }

        "4" {
            Clear-Host
            try {
                Clear-RecycleBin -Force -ErrorAction Stop
                Write-Host "Papelera vaciada correctamente." -ForegroundColor Green
            }
            catch {
                Write-Host "No fue posible vaciar la papelera." -ForegroundColor Yellow
            }
            Esperar
        }

        "5" {
            Clear-Host
            sfc /scannow
            Esperar
        }

        "6" {
            Clear-Host
            DISM /Online /Cleanup-Image /CheckHealth
            Esperar
        }

        "7" {
            Clear-Host
            DISM /Online /Cleanup-Image /ScanHealth
            Esperar
        }

        "8" {
            Clear-Host
            DISM /Online /Cleanup-Image /RestoreHealth
            Esperar
        }

        "9" {
            Clear-Host
            $unidad = Read-Host "Ingrese la letra de la unidad (Ejemplo C:)"
            chkdsk $unidad
            Esperar
        }

        "10" {
            Clear-Host
            Optimize-Volume -DriveLetter C -Analyze -Verbose
            $r = Read-Host "¿Desea optimizar la unidad? (S/N)"
            if ($r -match "^[Ss]$") {
                Optimize-Volume -DriveLetter C -Defrag -Verbose
            }
            Esperar
        }

        "11" {
            Clear-Host
            Stop-Process -Name explorer -Force
            Start-Process explorer.exe
            Write-Host "Explorador reiniciado." -ForegroundColor Green
            Esperar
        }

        "12" {
            Clear-Host

            Stop-Service wuauserv -Force -ErrorAction SilentlyContinue
            Stop-Service bits -Force -ErrorAction SilentlyContinue
            Stop-Service cryptsvc -Force -ErrorAction SilentlyContinue

            Start-Service cryptsvc
            Start-Service bits
            Start-Service wuauserv

            Write-Host "Servicios de Windows Update reiniciados." -ForegroundColor Green
            Esperar
        }

        "13" {
            Clear-Host

            Get-Volume | Format-Table DriveLetter,FileSystemLabel,
            @{Name="Libre (GB)";Expression={[math]::Round($_.SizeRemaining/1GB,2)}},
            @{Name="Total (GB)";Expression={[math]::Round($_.Size/1GB,2)}} -Auto

            Esperar
        }

        "14" {
            Clear-Host

            Get-Counter '\Processor(_Total)\% Processor Time'

            Get-Counter '\Memory\Available MBytes'

            Esperar
        }

        "15" {
            Clear-Host
            ipconfig /flushdns
            Esperar
        }

        "16" {
            Clear-Host

            Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue

            Checkpoint-Computer `
            -Description "AUTO WINDOWS PRO" `
            -RestorePointType MODIFY_SETTINGS

            Write-Host "Punto de restauración creado." -ForegroundColor Green

            Esperar
        }

        "0" {
            return
        }

        default {
            Write-Host "Opción inválida." -ForegroundColor Red
            Start-Sleep 2
        }

    }

} while ($true)
