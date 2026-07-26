# ==========================================================
# AUTO WINDOWS PRO
# MODULO: SEGURIDAD v3.0
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - SEGURIDAD"



# ================= FUNCIONES =================


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}



function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "              AUTO WINDOWS PRO - SEGURIDAD" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



function Admin {

    $usuario = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($usuario)

    return $principal.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)

}



# ================= VALIDAR ADMIN =================


if(!(Admin)){

    Write-Host ""
    Write-Host "Ejecute AUTO WINDOWS PRO como Administrador" -ForegroundColor Red

    Esperar

    return

}



# ================= MENU =================


do{


Titulo


Write-Host "[1] Estado Antivirus Windows Defender"
Write-Host "[2] Actualizar firmas Defender"
Write-Host "[3] Analisis rapido Defender"
Write-Host "[4] Analisis completo Defender"
Write-Host "[5] Ver amenazas detectadas"
Write-Host "[6] Historial de seguridad"
Write-Host "[7] Activar Firewall Windows"
Write-Host "[8] Estado Firewall"
Write-Host "[9] Reglas Firewall activas"
Write-Host "[10] Usuarios locales"
Write-Host "[11] Administradores locales"
Write-Host "[12] Sesiones de inicio"
Write-Host "[13] Programas inicio Windows"
Write-Host "[14] Servicios activos"
Write-Host "[15] Procesos activos"
Write-Host "[16] Conexiones de red"
Write-Host "[17] Bloquear IP Firewall"
Write-Host "[18] Eliminar bloqueo Firewall"
Write-Host "[19] Actualizaciones instaladas"
Write-Host "[20] Reporte seguridad"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$op = Read-Host "Seleccione una opcion"



switch($op){



# ==========================================================
# 1 ESTADO DEFENDER
# ==========================================================


"1"{

Clear-Host


try{


$def = Get-MpComputerStatus


Write-Host ""
Write-Host "========== WINDOWS DEFENDER ==========" -ForegroundColor Cyan
Write-Host ""


Write-Host "Antivirus activo      : $($def.AntivirusEnabled)"

Write-Host "Proteccion tiempo real: $($def.RealTimeProtectionEnabled)"

Write-Host "Motor actualizado     : $($def.AMServiceEnabled)"

Write-Host "Version motor         : $($def.AMProductVersion)"

Write-Host "Version firmas        : $($def.AntivirusSignatureVersion)"

Write-Host "Ultima actualizacion  : $($def.AntivirusSignatureLastUpdated)"


}

catch{


Write-Host ""
Write-Host "Windows Defender no disponible" -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# 2 ACTUALIZAR DEFENDER
# ==========================================================


"2"{

Clear-Host


try{


Write-Host ""
Write-Host "Actualizando firmas Defender..." -ForegroundColor Cyan


Update-MpSignature


Write-Host ""

Write-Host "Actualizacion terminada" -ForegroundColor Green


}

catch{


Write-Host ""
Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# 3 ANALISIS RAPIDO
# ==========================================================


"3"{

Clear-Host


try{


Write-Host ""
Write-Host "Ejecutando analisis rapido..." -ForegroundColor Cyan


Start-MpScan -ScanType QuickScan


Write-Host ""

Write-Host "Analisis finalizado" -ForegroundColor Green


}

catch{


Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# 4 ANALISIS COMPLETO
# ==========================================================


"4"{

Clear-Host


try{


Write-Host ""
Write-Host "Ejecutando analisis completo..." -ForegroundColor Cyan


Start-MpScan -ScanType FullScan


}

catch{


Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# ==========================================================
# 5 AMENAZAS DETECTADAS
# ==========================================================


"5"{

Clear-Host


try{


Get-MpThreat |
Format-Table -Auto


}

catch{


Write-Host "No se encontraron amenazas" -ForegroundColor Green

}


Esperar

}



# ==========================================================
# 6 HISTORIAL SEGURIDAD
# ==========================================================


"6"{

Clear-Host


try{


Get-MpThreatDetection |
Format-Table -Auto


}

catch{


Write-Host "Sin registros disponibles"

}


Esperar

}



# ==========================================================
# 7 ACTIVAR FIREWALL
# ==========================================================


"7"{

Clear-Host


try{


Set-NetFirewallProfile `
-Profile Domain,Private,Public `
-Enabled True


Write-Host ""
Write-Host "Firewall activado correctamente" -ForegroundColor Green


}

catch{


Write-Host $_.Exception.Message -ForegroundColor Yellow

}


Esperar

}



# CONTINUAMOS EN PARTE 2

default{

if($op -ne "0"){

Write-Host ""
Write-Host "Opcion pendiente en siguiente bloque" -ForegroundColor Yellow

Start-Sleep 2

}

}



}


}while($op -ne "0")
