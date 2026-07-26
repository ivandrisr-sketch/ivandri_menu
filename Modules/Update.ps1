# ==========================================================
# AUTO WINDOWS PRO
# MODULO: UPDATE
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle="AUTO WINDOWS PRO - UPDATE"


function Esperar {

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo {

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "              AUTO WINDOWS PRO - UPDATE" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}



do{


Titulo


Write-Host "[1] Buscar actualizaciones Windows"
Write-Host "[2] Abrir Windows Update"
Write-Host "[3] Historial de actualizaciones"
Write-Host "[4] Ver actualizaciones instaladas KB"
Write-Host "[5] Reiniciar servicios Windows Update"
Write-Host "[6] Limpiar cache Windows Update"
Write-Host "[7] Reparar componentes Update"
Write-Host "[8] Actualizar Microsoft Store"
Write-Host "[9] Buscar drivers Windows Update"
Write-Host "[10] Generar reporte Update"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion=Read-Host "Seleccione una opcion"



switch($opcion){



"1"{

Clear-Host

Write-Host "Buscando actualizaciones..."

UsoClient StartScan


Esperar

}



"2"{

Clear-Host


Start-Process `
"ms-settings:windowsupdate"


Esperar

}



"3"{

Clear-Host


Write-Host "HISTORIAL DE ACTUALIZACIONES"

Write-Host ""


Get-HotFix |
Sort InstalledOn -Descending |
Format-Table -AutoSize


Esperar

}



"4"{

Clear-Host


Write-Host "ACTUALIZACIONES KB INSTALADAS"

Write-Host ""


Get-HotFix |
Select HotFixID,Description,InstalledOn |
Format-Table -AutoSize


Esperar

}



"5"{

Clear-Host


Write-Host "Reiniciando servicios..."


Stop-Service wuauserv -Force `
-ErrorAction SilentlyContinue


Stop-Service bits -Force `
-ErrorAction SilentlyContinue


Stop-Service cryptsvc -Force `
-ErrorAction SilentlyContinue



Start-Service cryptsvc

Start-Service bits

Start-Service wuauserv



Write-Host ""

Write-Host "Servicios reiniciados correctamente" -ForegroundColor Green


Esperar

}



"6"{

Clear-Host


Write-Host "Limpiando cache Windows Update..."



Stop-Service wuauserv -Force `
-ErrorAction SilentlyContinue


Stop-Service bits -Force `
-ErrorAction SilentlyContinue



Rename-Item `
"C:\Windows\SoftwareDistribution" `
"SoftwareDistribution.old" `
-ErrorAction SilentlyContinue



Start-Service wuauserv

Start-Service bits



Write-Host ""

Write-Host "Cache limpiada" -ForegroundColor Green


Esperar

}



"7"{

Clear-Host


Write-Host "Reparando componentes Windows Update..."



DISM /Online /Cleanup-Image /RestoreHealth


sfc /scannow



Esperar

}



"8"{

Clear-Host


Write-Host "Actualizando aplicaciones Microsoft Store..."



Get-AppxPackage -AllUsers |
ForEach {

Add-AppxPackage `
-DisableDevelopmentMode `
-Register "$($_.InstallLocation)\AppXManifest.xml" `
-ErrorAction SilentlyContinue

}



Write-Host ""

Write-Host "Aplicaciones Store actualizadas" -ForegroundColor Green


Esperar

}



"9"{

Clear-Host


Write-Host "Buscando drivers disponibles..."



Start-Process `
"ms-settings:windowsupdate-options"



Esperar

}



"10"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Reporte_Update.txt"



"AUTO WINDOWS PRO - REPORTE UPDATE" |
Out-File $ruta


"Fecha: $(Get-Date)" |
Out-File $ruta -Append



"===== SISTEMA =====" |
Out-File $ruta -Append


Get-ComputerInfo |
Select WindowsProductName,WindowsVersion |
Out-File $ruta -Append



"===== ACTUALIZACIONES =====" |
Out-File $ruta -Append



Get-HotFix |
Out-File $ruta -Append



Write-Host ""

Write-Host "Reporte generado:" -ForegroundColor Green

Write-Host $ruta



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


}
while($true)
