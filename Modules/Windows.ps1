"3"{

Clear-Host

Write-Host "============================================="
Write-Host "       ACTIVACION WINDOWS"
Write-Host "============================================="
Write-Host ""

Write-Host "[1] Abrir configuración de activación Windows"
Write-Host "[2] Ver estado de licencia"
Write-Host "[3] Ingresar clave válida"
Write-Host "[0] Volver"

$act = Read-Host "Seleccione"

switch($act){

"1"{

Start-Process "ms-settings:activation"

}


"2"{

cscript.exe C:\Windows\System32\slmgr.vbs /xpr

cscript.exe C:\Windows\System32\slmgr.vbs /dlv

}


"3"{

$clave = Read-Host "Ingrese clave Windows válida"

slmgr.vbs /ipk $clave

slmgr.vbs /ato

}


"0"{

return

}

}

Esperar

}
