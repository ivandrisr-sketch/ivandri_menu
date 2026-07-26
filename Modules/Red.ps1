$Host.UI.RawUI.WindowTitle = "AUTO WINDOWS PRO - RED Y DOMINIO"

function Esperar{
    Read-Host "`nPresione ENTER para continuar"
}

do{

Clear-Host

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "             AUTO WINDOWS PRO - RED Y DOMINIO" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host " [1] Mostrar configuración IP"
Write-Host " [2] Probar conexión a Internet"
Write-Host " [3] Ping personalizado"
Write-Host " [4] Trazar Ruta (Tracert)"
Write-Host " [5] Limpiar Caché DNS"
Write-Host " [6] Liberar Dirección IP"
Write-Host " [7] Renovar Dirección IP"
Write-Host " [8] Restablecer Winsock"
Write-Host " [9] Restablecer TCP/IP"
Write-Host "[10] Mostrar Adaptadores"
Write-Host "[11] Ver Redes WiFi Guardadas"
Write-Host "[12] Actualizar Directivas (gpupdate)"
Write-Host "[13] Resultado de Directivas"
Write-Host "[14] Estado del Dominio"
Write-Host "[15] Controlador de Dominio"
Write-Host "[16] Sincronizar Hora"
Write-Host "[17] Verificar Canal Seguro"
Write-Host "[18] Reiniciar Adaptadores"
Write-Host "[19] Puertos Abiertos"
Write-Host "[20] Conexiones Activas"
Write-Host ""
Write-Host " [0] Volver"
Write-Host ""

$op = Read-Host "Seleccione una opción"

switch($op){

"1"{
    Clear-Host
    ipconfig /all
    Esperar
}

"2"{
    Clear-Host
    Test-NetConnection google.com
    Esperar
}

"3"{
    Clear-Host
    $hostPing = Read-Host "Ingrese IP o nombre del equipo"
    ping $hostPing
    Esperar
}

"4"{
    Clear-Host
    $hostTrace = Read-Host "Ingrese IP o nombre del equipo"
    tracert $hostTrace
    Esperar
}

"5"{
    Clear-Host
    ipconfig /flushdns
    Esperar
}

"6"{
    Clear-Host
    ipconfig /release
    Esperar
}

"7"{
    Clear-Host
    ipconfig /renew
    Esperar
}

"8"{
    Clear-Host
    netsh winsock reset
    Esperar
}

"9"{
    Clear-Host
    netsh int ip reset
    Esperar
}

"10"{
    Clear-Host
    Get-NetAdapter | Format-Table Name,Status,LinkSpeed,MacAddress -Auto
    Esperar
}

"11"{
    Clear-Host
    netsh wlan show profiles
    Esperar
}

"12"{
    Clear-Host
    gpupdate /force
    Esperar
}

"13"{
    Clear-Host
    gpresult /r
    Esperar
}

"14"{
    Clear-Host
    $eq = Get-CimInstance Win32_ComputerSystem

    Write-Host ""
    Write-Host "Equipo              : $($eq.Name)"
    Write-Host "Dominio             : $($eq.Domain)"
    Write-Host "Pertenece a dominio : $($eq.PartOfDomain)"
    Write-Host ""

    Esperar
}

"15"{
    Clear-Host
    Write-Host "Controlador de Dominio:"
    Write-Host ""
    echo $env:LOGONSERVER
    Esperar
}

"16"{
    Clear-Host
    w32tm /resync
    Esperar
}

"17"{
    Clear-Host
    Test-ComputerSecureChannel
    Esperar
}

"18"{
    Clear-Host

    Get-NetAdapter | Where Status -eq "Up" | Disable-NetAdapter -Confirm:$false

    Start-Sleep 3

    Get-NetAdapter | Enable-NetAdapter -Confirm:$false

    Esperar
}

"19"{
    Clear-Host
    netstat -an
    Esperar
}

"20"{
    Clear-Host
    netstat -ano
    Esperar
}

"0"{
    return
}

default{
    Write-Host "Opción inválida" -ForegroundColor Red
    Start-Sleep 2
}

}

}while($true)
