# ==========================================================
# AUTO WINDOWS PRO
# MODULO: WINDOWS
# Desarrollado por: Ivan Salcedo
# ==========================================================


$Host.UI.RawUI.WindowTitle="AUTO WINDOWS PRO - WINDOWS"



function Esperar{

Read-Host "`nPresione ENTER para continuar"

}



function Titulo{


Clear-Host


Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "             AUTO WINDOWS PRO - WINDOWS" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

}



function ClaveModulo{


$clave=Read-Host "Ingrese clave del modulo"


if($clave -eq "888888"){

return $true

}
else{

Write-Host "Clave incorrecta" -ForegroundColor Red

Start-Sleep 2

return $false

}

}



if(!(ClaveModulo)){

return

}



do{


Titulo


Write-Host "[1] Informacion Windows"
Write-Host "[2] Version y compilacion"
Write-Host "[3] Estado de activacion"
Write-Host "[4] Licencia digital"
Write-Host "[5] Reparar archivos Windows SFC"
Write-Host "[6] Reparar imagen Windows DISM"
Write-Host "[7] Buscar actualizaciones"
Write-Host "[8] Reiniciar Windows Update"
Write-Host "[9] Crear reporte Windows"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion=Read-Host "Seleccione una opcion"



switch($opcion){


"1"{

Clear-Host


Get-ComputerInfo |
Select-Object `
WindowsProductName,
WindowsVersion,
OsArchitecture,
CsName


Esperar

}



"2"{

Clear-Host


winver


Esperar

}



"3"{

Clear-Host


cscript.exe `
C:\Windows\System32\slmgr.vbs /xpr


Esperar

}



"4"{

Clear-Host


cscript.exe `
C:\Windows\System32\slmgr.vbs /dlv


Esperar

}



"5"{

Clear-Host


sfc /scannow


Esperar

}



"6"{

Clear-Host


DISM /Online /Cleanup-Image /RestoreHealth


Esperar

}



"7"{

Clear-Host


Start-Process `
"ms-settings:windowsupdate"


Esperar

}



"8"{

Clear-Host


Restart-Service wuauserv `
-ErrorAction SilentlyContinue


Restart-Service bits `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "Servicios Windows Update reiniciados" -ForegroundColor Green


Esperar

}



"9"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Reporte_Windows.txt"


"AUTO WINDOWS PRO WINDOWS" | Out-File $ruta

"Fecha: $(Get-Date)" | Out-File $ruta -Append


Get-ComputerInfo |
Out-File $ruta -Append


Write-Host ""
Write-Host "Reporte creado:"
Write-Host $ruta


Esperar

}



"0"{

return

}



default{

Write-Host "Opcion invalida" -ForegroundColor Red

Start-Sleep 2

}



}


}while($true)
