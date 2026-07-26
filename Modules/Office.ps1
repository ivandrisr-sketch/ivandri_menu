"2"{

Clear-Host

Write-Host "Estado de licencia Office"

$office = Get-ChildItem `
"C:\Program Files\Microsoft Office" `
-Recurse `
-Filter ospp.vbs `
-ErrorAction SilentlyContinue


if($office){

cscript.exe $office.FullName /dstatus

}
else{

Write-Host "No se encontró herramienta Office"

}

Esperar

}
