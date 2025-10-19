Install-WindowsFeature Web-Server -IncludeManagementTools
Install-WindowsFeature Web-Asp-Net45, Web-Net-Ext45, Web-ISAPI-Ext, Web-ISAPI-Filter, Web-Static-Content
Remove-IISSite -Name "Default Web Site" -Confirm:$false
Invoke-WebRequest 'https://github.com/highexpert-tecnologia/imersao-arquitetoazure/raw/refs/heads/main/LabFiles/HighExpertStore_v1.zip' -OutFile C:\inetpub\wwwroot\HighExpertStore_v1.zip
Expand-Archive C:\inetpub\wwwroot\HighExpertStore_v1.zip C:\inetpub\wwwroot\
& $env:SystemRoot\System32\inetsrv\appcmd.exe add apppool /name:HighExpertStorePool /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated
& $env:SystemRoot\System32\inetsrv\appcmd.exe set apppool "HighExpertStorePool" /enable32BitAppOnWin64:false
& $env:SystemRoot\System32\inetsrv\appcmd.exe add site /name:"HighExpertStore" /bindings:"http/*:80:" /physicalPath:"C:\inetpub\wwwroot\HighExpertStore"
& $env:SystemRoot\System32\inetsrv\appcmd.exe set app "HighExpertStore/" /applicationPool:"HighExpertStorePool"