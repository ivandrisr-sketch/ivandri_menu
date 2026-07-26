# ==========================================================
# AUTO WINDOWS PRO
# MODULO: WIFI v3.0
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - WIFI"



# ================= FUNCIONES =================


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}



function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "              AUTO WINDOWS PRO - WIFI" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



function EsAdministrador {

    $usuario = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($usuario)

    return $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator
    )

}



# ================= VALIDAR ADMIN =================


if(!(EsAdministrador)){

    Write-Host ""
    Write-Host "Ejecute AUTO WINDOWS PRO como Administrador" -ForegroundColor Red

    Esperar

    return

}




# ================= MENU =================


do{


Titulo


Write-Host "[1] Mostrar adaptador WiFi"
Write-Host "[2] Mostrar redes WiFi disponibles"
Write-Host "[3] Ver perfiles WiFi guardados"
Write-Host "[4] Mostrar contraseña WiFi guardada"
Write-Host "[5] Exportar perfiles WiFi"
Write-Host "[6] Eliminar perfil WiFi"
Write-Host "[7] Conectar a red WiFi"
Write-Host "[8] Desconectar WiFi"
Write-Host "[9] Reiniciar adaptador WiFi"
Write-Host "[10] Diagnostico WiFi Windows"
Write-Host "[11] Informacion de señal"
Write-Host "[12] Ver IP WiFi"
Write-Host "[13] Renovar IP WiFi"
Write-Host "[14] Limpiar perfiles antiguos"
Write-Host "[15] Reporte WiFi"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion = Read-Host "Seleccione una opcion"



switch($opcion){



# ==================================================
# 1 ADAPTADOR WIFI
# ==================================================

"1"{

Clear-Host

try{


Get-NetAdapter |
Where-Object {$_.InterfaceDescription -match "Wi-Fi|Wireless|WLAN"} |
Format-Table Name,Status,LinkSpeed,MacAddress -Auto


}
catch{

Write-Host "No se encontro adaptador WiFi" -ForegroundColor Yellow

}


Esperar

}



# ==================================================
# 2 REDES DISPONIBLES
# ==================================================

"2"{

Clear-Host

netsh wlan show networks mode=bssid

Esperar

}



# ==================================================
# 3 PERFILES GUARDADOS
# ==================================================

"3"{

Clear-Host

netsh wlan show profiles

Esperar

}



# ==================================================
# 4 CONTRASEÑA WIFI
# ==================================================

"4"{

Clear-Host


$perfil = Read-Host "Nombre del WiFi"


netsh wlan show profile name="$perfil" key=clear


Esperar

}



# ==================================================
# 5 EXPORTAR PERFILES
# ==================================================

"5"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\WiFi_Backup"


New-Item `
-ItemType Directory `
-Path $ruta `
-Force | Out-Null



netsh wlan export profile `
folder="$ruta" `
key=clear



Write-Host ""

Write-Host "Perfiles exportados en:" -ForegroundColor Green

Write-Host $ruta


Esperar

}



# CONTINUA PARTE 2/3
