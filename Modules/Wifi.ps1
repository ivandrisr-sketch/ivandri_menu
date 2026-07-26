# ==========================================================
# AUTO WINDOWS PRO
# MODULO: WIFI v3.1
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
Write-Host "[11] Informacion señal WiFi"
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
Where-Object {
$_.InterfaceDescription -match "Wi-Fi|Wireless|WLAN"
} |
Format-Table Name,Status,LinkSpeed,MacAddress -Auto


}
catch{


Write-Host ""
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


$perfil = Read-Host "Ingrese nombre del WiFi"


netsh wlan show profile name="$perfil" key=clear


Esperar

}



# ==================================================
# 5 EXPORTAR PERFILES
# ==================================================

"5"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\WiFi_Backup"



try{


New-Item `
-ItemType Directory `
-Path $ruta `
-Force | Out-Null



netsh wlan export profile `
folder="$ruta" `
key=clear



Write-Host ""
Write-Host "Perfiles exportados correctamente" -ForegroundColor Green
Write-Host $ruta


}
catch{


Write-Host ""
Write-Host $_.Exception.Message -ForegroundColor Yellow


}


Esperar

}



# ==================================================
# 6 ELIMINAR PERFIL
# ==================================================

"6"{

Clear-Host


$perfil=Read-Host "Nombre del perfil WiFi"


netsh wlan delete profile name="$perfil"



Esperar

}



# ==================================================
# 7 CONECTAR WIFI
# ==================================================

"7"{

Clear-Host


$perfil=Read-Host "Nombre del perfil WiFi"


netsh wlan connect name="$perfil"


Esperar

}



# ==================================================
# 8 DESCONECTAR WIFI
# ==================================================

"8"{

Clear-Host


netsh wlan disconnect


Esperar

}



# ==================================================
# 9 REINICIAR ADAPTADOR WIFI
# ==================================================

"9"{

Clear-Host


try{


$wifi=Get-NetAdapter |
Where-Object {
$_.InterfaceDescription -match "Wi-Fi|Wireless|WLAN"
}



Disable-NetAdapter `
-Name $wifi.Name `
-Confirm:$false



Start-Sleep 3



Enable-NetAdapter `
-Name $wifi.Name `
-Confirm:$false



Write-Host ""
Write-Host "Adaptador reiniciado" -ForegroundColor Green


}
catch{


Write-Host ""
Write-Host "No fue posible reiniciar WiFi" -ForegroundColor Yellow


}


Esperar

}



# ==================================================
# 10 DIAGNOSTICO WIFI
# ==================================================

"10"{

Clear-Host


netsh wlan show wlanreport


Write-Host ""

Write-Host "Reporte generado por Windows" -ForegroundColor Green


Esperar

}



# ==================================================
# 11 SEÑAL WIFI
# ==================================================

"11"{

Clear-Host


netsh wlan show interfaces


Esperar

}



# ==================================================
# 12 IP WIFI
# ==================================================

"12"{

Clear-Host


Get-NetIPConfiguration |
Where-Object {
$_.InterfaceAlias -match "Wi-Fi|Wireless"
}



Esperar

}



# ==================================================
# 13 RENOVAR IP
# ==================================================

"13"{

Clear-Host


ipconfig /release

Start-Sleep 2

ipconfig /renew


Esperar

}



# ==================================================
# 14 LIMPIAR PERFILES
# ==================================================

"14"{

Clear-Host


Write-Host "Perfiles WiFi almacenados:" -ForegroundColor Cyan

netsh wlan show profiles


Write-Host ""

$perfil=Read-Host "Perfil a eliminar"


netsh wlan delete profile name="$perfil"


Esperar

}



# ==================================================
# 15 REPORTE WIFI
# ==================================================

"15"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Reporte_WIFI.txt"



try{


"==============================" | Out-File $ruta

"AUTO WINDOWS PRO - REPORTE WIFI" | Out-File $ruta -Append

"Fecha: $(Get-Date)" | Out-File $ruta -Append

"" | Out-File $ruta -Append


netsh wlan show interfaces |
Out-File $ruta -Append


"" | Out-File $ruta -Append


netsh wlan show profiles |
Out-File $ruta -Append



Write-Host ""

Write-Host "Reporte creado:" -ForegroundColor Green

Write-Host $ruta



}
catch{


Write-Host $_.Exception.Message -ForegroundColor Yellow


}


Esperar

}



# ==================================================
# SALIR
# ==================================================

"0"{

return

}



default{


Write-Host ""
Write-Host "Opcion invalida" -ForegroundColor Red

Start-Sleep 2


}



}


}while($true)
