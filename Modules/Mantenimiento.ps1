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


function Verificar-Admin {

    $identidad = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($identidad)

    return $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
    )

}


# ================= VALIDAR ADMIN =================

if(!(Verificar-Admin)){

    Write-Host ""
    Write-Host "Debe ejecutar AUTO WINDOWS PRO como Administrador" -ForegroundColor Red
    Esperar
    return

}



# ================= MENU PRINCIPAL =================

do{


Titulo


Write-Host "[1] Liberador de espacio Windows"
Write-Host "[2] Limpiar TEMP usuario"
Write-Host "[3] Limpiar TEMP Windows"
Write-Host "[4] Vaciar papelera"
Write-Host "[5] Reparar archivos Windows SFC"
Write-Host "[6] DISM CheckHealth"
Write-Host "[7] DISM ScanHealth"
Write-Host "[8] DISM RestoreHealth"
Write-Host "[9] Comprobar disco CHKDSK"
Write-Host "[10] Optimizar unidades"
Write-Host "[11] Reiniciar Explorador Windows"
Write-Host "[12] Reiniciar Windows Update"
Write-Host "[13] Mostrar espacio discos"
Write-Host "[14] Rendimiento del equipo"
Write-Host "[15] Limpiar cache DNS"
Write-Host "[16] Crear punto restauracion"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){



# ==========================================================
# OPCION 1
# ==========================================================

"1"{

Clear-Host

Start-Process cleanmgr.exe

Esperar

}



# ==========================================================
# OPCION 2
# ==========================================================

"2"{

Clear-Host

try{

Remove-Item "$env:TEMP\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP usuario limpiado correctamente" -ForegroundColor Green


}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# OPCION 3
# ==========================================================

"3"{

Clear-Host


try{


Remove-Item "C:\Windows\Temp\*" `
-Recurse `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "TEMP Windows limpiado correctamente" -ForegroundColor Green


}
catch{

Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# OPCION 4
# ==========================================================

"4"{

Clear-Host


try{


Clear-RecycleBin `
-Force `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "Papelera vaciada correctamente" -ForegroundColor Green


}
catch{

Write-Host ""
Write-Host "No fue posible vaciar papelera" -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# OPCION 5
# ==========================================================

"5"{

Clear-Host

Write-Host ""
Write-Host "Ejecutando SFC..." -ForegroundColor Cyan

sfc /scannow

Esperar

}
