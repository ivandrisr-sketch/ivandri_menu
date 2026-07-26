Clear-Host
$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - DIAGNÓSTICO"

function Esperar {
    Read-Host "`nPresione ENTER para continuar"
}

do {
    Clear-Host

    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "           MÓDULO DIAGNÓSTICO" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Cyan

    Write-Host ""
    Write-Host "[1] Información del equipo"
    Write-Host "[2] Procesador"
    Write-Host "[3] Memoria RAM"
    Write-Host "[4] Disco"
    Write-Host "[5] Sistema Operativo"
    Write-Host "[6] Tarjetas de Red"
    Write-Host "[7] Espacio en Disco"
    Write-Host "[8] Procesos"
    Write-Host "[9] Servicios"
    Write-Host "[0] Volver"

    $op = Read-Host "`nSeleccione"

    switch($op){

        "1"{
            systeminfo
            Esperar
        }

        "2"{
            Get-CimInstance Win32_Processor | Format-List Name,NumberOfCores,MaxClockSpeed
            Esperar
        }

        "3"{
            Get-CimInstance Win32_PhysicalMemory | Format-Table Manufacturer,Capacity,Speed
            Esperar
        }

        "4"{
            Get-Disk
            Esperar
        }

        "5"{
            Get-ComputerInfo | Select WindowsProductName,WindowsVersion,OsArchitecture
            Esperar
        }

        "6"{
            Get-NetAdapter
            Esperar
        }

        "7"{
            Get-Volume
            Esperar
        }

        "8"{
            Get-Process | Sort CPU -Descending | Select -First 20
            Esperar
        }

        "9"{
            Get-Service
            Esperar
        }

        "0"{
            return
        }

    }

}while($true)
