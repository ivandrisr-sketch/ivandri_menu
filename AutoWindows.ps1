# ==========================================================
# AUTO WINDOWS PRO v2.0
# Desarrollado por: Ivan Salcedo
# GitHub: https://github.com/ivandrisr-sketch/ivandri_menu
# ==========================================================

Clear-Host
$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO"

# URL base del repositorio
$BaseURL = "https://raw.githubusercontent.com/ivandrisr-sketch/ivandri_menu/main/Modules"

#============================================================
# COMPROBAR ADMINISTRADOR
#============================================================

$Admin = ([Security.Principal.WindowsPrincipal] `
[Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltinRole]::Administrator)

#============================================================
# FUNCIONES
#============================================================

function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}

function Banner {

    Clear-Host

    Write-Host ""
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host "                 AUTO WINDOWS PRO v2.0" -ForegroundColor Green
    Write-Host "               Desarrollado por Ivan Salcedo" -ForegroundColor Yellow
    Write-Host "==============================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host (" Equipo      : {0}" -f $env:COMPUTERNAME)
    Write-Host (" Usuario     : {0}" -f $env:USERNAME)
    Write-Host (" Windows     : {0}" -f (Get-CimInstance Win32_OperatingSystem).Caption)
    Write-Host (" PowerShell  : {0}" -f $($PSVersionTable.PSVersion))
    Write-Host (" Fecha       : {0}" -f (Get-Date))

    if($Admin){

        Write-Host " Administrador : SI" -ForegroundColor Green

    }
    else{

        Write-Host " Administrador : NO" -ForegroundColor Red

    }

    Write-Host ""

}

function EjecutarModulo($Modulo){

    try{

        irm "$BaseURL/$Modulo" | iex

    }

    catch{

        Write-Host ""
        Write-Host "No fue posible cargar el módulo." -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Yellow
        Esperar

    }

}

#============================================================
# MENU
#============================================================

do{

Banner

Write-Host "==================== MENU PRINCIPAL ====================" -ForegroundColor Cyan
Write-Host ""

Write-Host " [1] Diagnóstico del Equipo"
Write-Host " [2] Seguridad"
Write-Host " [3] Mantenimiento"
Write-Host " [4] Red"
Write-Host " [5] WiFi"
Write-Host " [6] Microsoft Office"
Write-Host " [7] Windows"
Write-Host " [8] Software"
Write-Host " [9] Drivers"
Write-Host "[10] Herramientas del Sistema"
Write-Host "[11] Backup"
Write-Host "[12] Update"

Write-Host ""
Write-Host " [0] Salir" -ForegroundColor Red
Write-Host ""

$Opcion = Read-Host "Seleccione una opción"

switch($Opcion){

    "1"{

        EjecutarModulo "Diagnostico.ps1"

    }

    "2"{

        EjecutarModulo "Seguridad.ps1"

    }

    "3"{

        EjecutarModulo "Mantenimiento.ps1"

    }

    "4"{

        EjecutarModulo "Red.ps1"

    }

    "5"{

        EjecutarModulo "Wifi.ps1"

    }

    "6"{

        EjecutarModulo "Office.ps1"

    }

    "7"{

        EjecutarModulo "Windows.ps1"

    }

    "8"{

        EjecutarModulo "Software.ps1"

    }

    "9"{

        EjecutarModulo "Drivers.ps1"

    }

    "10"{

        EjecutarModulo "Herramientas.ps1"

    }

    "11"{

        EjecutarModulo "Backup.ps1"

    }

    "12"{

        EjecutarModulo "Update.ps1"

    }

    "0"{

        Clear-Host

        Write-Host ""
        Write-Host "Gracias por utilizar AUTO WINDOWS PRO" -ForegroundColor Green
        Write-Host "Desarrollado por Ivan Salcedo"
        Write-Host ""

        Start-Sleep 2

        break

    }

    default{

        Write-Host ""
        Write-Host "Opción inválida." -ForegroundColor Red
        Start-Sleep 2

    }

}

}while($true)
