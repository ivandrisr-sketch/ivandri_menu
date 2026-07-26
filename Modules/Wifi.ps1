# ==========================================================
# AUTO WINDOWS PRO
# MODULO: WIFI v3.2
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - WIFI"


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


function Admin {

    $id=[Security.Principal.WindowsIdentity]::GetCurrent()

    $p=New-Object Security.Principal.WindowsPrincipal($id)

    return $p.IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)

}



if(!(Admin)){

    Write-Host ""
    Write-Host "Ejecute como Administrador" -ForegroundColor Red

    Esperar

    return

}



do{


Titulo


Write-Host "[1] Mostrar adaptador WiFi"
Write-Host "[2] Redes WiFi disponibles"
Write-Host "[3] Perfiles WiFi guardados"
Write-Host "[4] Mostrar contraseña WiFi"
Write-Host "[5] Exportar perfiles WiFi"
Write-Host "[6] Eliminar perfil WiFi"
Write-Host "[7] Conectar WiFi"
Write-Host "[8] Desconectar WiFi"
Write-Host "[9] Reiniciar adaptador WiFi"
Write-Host "[10] Reporte WLAN Windows"
Write-Host "[11] Estado señal WiFi"
Write-Host "[12] Mostrar IP WiFi"
Write-Host "[13] Renovar IP"
Write-Host "[14] Limpiar perfil WiFi"
Write-Host "[15] Crear reporte TXT"

Write-Host ""
Write-Host "[0] Volver"
Write-Host ""


$opcion=Read-Host "Seleccione una opcion"



switch($opcion){


"1"{

Clear-Host

try{

Get-NetAdapter |
Where-Object {
$_.Name -match "Wi-Fi|WLAN|Wireless"
} |
Format-Table Name,Status,LinkSpeed,MacAddress -Auto

}
catch{

Write-Host "No se encontro adaptador WiFi"

}

Esperar

}



"2"{

Clear-Host

netsh wlan show networks mode=bssid

Esperar

}



"3"{

Clear-Host

netsh wlan show profiles

Esperar

}



"4"{

Clear-Host

$perfil=Read-Host "Nombre del perfil WiFi"

netsh wlan show profile name="$perfil" key=clear

Esperar

}



"5"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\WiFi_Backup"


New-Item `
-Path $ruta `
-ItemType Directory `
-Force | Out-Null


netsh wlan export profile folder="$ruta" key=clear


Write-Host ""

Write-Host "Exportacion realizada:" -ForegroundColor Green

Write-Host $ruta


Esperar

}



"6"{

Clear-Host


$perfil=Read-Host "Perfil a eliminar"


netsh wlan delete profile name="$perfil"


Esperar

}



"7"{

Clear-Host


$perfil=Read-Host "Perfil WiFi"


netsh wlan connect name="$perfil"


Esperar

}



"8"{

Clear-Host


netsh wlan disconnect


Esperar

}



"9"{

Clear-Host


try{


$wifi=Get-NetAdapter |
Where-Object {
$_.Name -match "Wi-Fi|WLAN|Wireless"
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

Write-Host "Error reiniciando WiFi"

}


Esperar

}



"10"{

Clear-Host


netsh wlan show wlanreport


Write-Host ""

Write-Host "Reporte WLAN generado por Windows"


Esperar

}



"11"{

Clear-Host


netsh wlan show interfaces


Esperar

}



"12"{

Clear-Host


Get-NetIPConfiguration |
Where-Object {
$_.InterfaceAlias -match "Wi-Fi"
}


Esperar

}



"13"{

Clear-Host


ipconfig /release

Start-Sleep 2

ipconfig /renew


Esperar

}



"14"{

Clear-Host


$perfil=Read-Host "Perfil WiFi a eliminar"


netsh wlan delete profile name="$perfil"


Esperar

}



"15"{

Clear-Host


$archivo="$env:USERPROFILE\Desktop\Reporte_WIFI.txt"


"==============================" | Out-File $archivo

"AUTO WINDOWS PRO - WIFI" | Out-File $archivo -Append

"Fecha: $(Get-Date)" | Out-File $archivo -Append

"" | Out-File $archivo -Append


netsh wlan show interfaces |
Out-File $archivo -Append


"" | Out-File $archivo -Append


netsh wlan show profiles |
Out-File $archivo -Append



Write-Host ""

Write-Host "Reporte creado correctamente" -ForegroundColor Green

Write-Host $archivo


Esperar

}



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
