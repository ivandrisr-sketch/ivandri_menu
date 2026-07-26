# ==========================================================
# AUTO WINDOWS PRO
# MODULO: MICROSOFT OFFICE
# Desarrollado por: Ivan Salcedo
# ==========================================================

$Host.UI.RawUI.WindowTitle="AUTO WINDOWS PRO - OFFICE"


function Esperar{

    Write-Host ""
    Read-Host "Presione ENTER para continuar"

}


function Titulo{

    Clear-Host

    Write-Host ""
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host "          AUTO WINDOWS PRO - MICROSOFT OFFICE" -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host ""

}


function ClaveModulo{


    $clave=Read-Host "Ingrese clave del modulo"


    if($clave -eq "888888"){

        return $true

    }
    else{

        Write-Host ""
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


Write-Host "[1] Detectar Office instalado"
Write-Host "[2] Ver estado licencia Office"
Write-Host "[3] Reparacion rapida Office"
Write-Host "[4] Reparacion completa Office"
Write-Host "[5] Actualizar Office"
Write-Host "[6] Reiniciar servicio Office"
Write-Host "[7] Abrir cuenta Microsoft"
Write-Host "[8] Crear reporte Office"

Write-Host ""

Write-Host "[0] Volver"

Write-Host ""


$opcion=Read-Host "Seleccione una opcion"



switch($opcion){


"1"{

Clear-Host


Write-Host "Buscando Microsoft Office..."


$office=Get-ChildItem `
"C:\Program Files" `
-Recurse `
-Filter WINWORD.EXE `
-ErrorAction SilentlyContinue



if($office){

Write-Host ""
Write-Host "Office encontrado:" -ForegroundColor Green

$office.FullName

}
else{

Write-Host ""
Write-Host "No se encontro Office instalado" -ForegroundColor Yellow

}


Esperar

}



"2"{

Clear-Host


$licencia=Get-ChildItem `
"C:\Program Files" `
-Recurse `
-Filter ospp.vbs `
-ErrorAction SilentlyContinue



if($licencia){


cscript.exe $licencia.FullName /dstatus


}
else{


Write-Host "No se encontro herramienta de licencia Office"


}



Esperar

}



"3"{

Clear-Host


Write-Host "Abra:"
Write-Host "Configuracion"
Write-Host "Aplicaciones"
Write-Host "Microsoft Office"
Write-Host "Modificar"
Write-Host "Reparacion rapida"


Esperar

}



"4"{

Clear-Host


Write-Host "Ejecute Reparacion en linea desde Office"


Start-Process "ms-settings:appsfeatures"


Esperar

}



"5"{

Clear-Host


Start-Process `
"https://config.office.com"


Esperar

}



"6"{

Clear-Host


Restart-Service ClickToRunSvc `
-ErrorAction SilentlyContinue


Write-Host ""
Write-Host "Servicio Office reiniciado" -ForegroundColor Green


Esperar

}



"7"{

Clear-Host


Start-Process `
"https://account.microsoft.com/services/"


Esperar

}



"8"{

Clear-Host


$ruta="$env:USERPROFILE\Desktop\Reporte_Office.txt"


"=============================" | Out-File $ruta

"AUTO WINDOWS PRO OFFICE" | Out-File $ruta -Append

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
