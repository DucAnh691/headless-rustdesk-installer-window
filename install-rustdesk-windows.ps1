# Chạy với quyền Administrator trên target machine
param(
  [string]$RustDeskVersion = "1.2.3",
  [string]$UnattendedPass  = "etonit_rustdesk@q7"
)

# 1. Tải về installer
$Url       = "https://github.com/rustdesk/rustdesk/releases/download/$RustDeskVersion/rustdesk-$RustDeskVersion.exe"
$OutFile   = "C:\Temp\rustdesk-$RustDeskVersion.exe"
New-Item -ItemType Directory -Force -Path (Split-Path $OutFile)
Invoke-WebRequest -Uri $Url -OutFile $OutFile

# 2. Cài silent NSIS installer
Start-Process -FilePath $OutFile -ArgumentList '/S' -Wait
Remove-Item $OutFile

# 3. Thiết lập mật khẩu unattended
#    File config theo quy ước Windows service profile :contentReference[oaicite:0]{index=0}
$CfgDir = "C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config"
New-Item -ItemType Directory -Force -Path $CfgDir
$Cfg = @"
[unattended]
enabled = true
password = "$UnattendedPass"
"@
Set-Content -Path "$CfgDir\RustDesk.toml" -Value $Cfg -Encoding UTF8

# 4. Khởi động lại RustDesk service
Restart-Service -Name rustdesk -Force

# 5. Chờ & lấy RustDesk ID
Start-Sleep -Seconds 5
$Exe = "C:\Program Files\RustDesk\rustdesk.exe"
$ID  = & $Exe --get-id 2>$null
Write-Host "RustDesk ID: $ID"
