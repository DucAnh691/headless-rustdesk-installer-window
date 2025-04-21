# Chạy trên máy điều khiển, cần enable WinRM trên target machines và dùng tài khoản có quyền Admin
$IPs      = Get-Content .\windows_ip_list.txt
$Cred     = Get-Credential      # Nhập user/password Admin domain/local
$LocalDir = Split-Path $MyInvocation.MyCommand.Definition

foreach ($IP in $IPs) {
    Write-Host "→ Deploy lên $IP ..." -ForegroundColor Cyan

    # 1. Copy script cài đặt vào thư mục tạm trên target
    Copy-Item -Path "$LocalDir\install-rustdesk-windows.ps1" `
              -Destination "\\$IP\C$\Temp\install-rustdesk-windows.ps1" `
              -Credential $Cred

    # 2. Chạy script remote
    Invoke-Command -ComputerName $IP -Credential $Cred -ScriptBlock {
        & C:\Temp\install-rustdesk-windows.ps1 -RustDeskVersion "1.2.3" -UnattendedPass "etonit_rustdesk@q7"
    }

    Write-Host "✅ Hoàn tất $IP" -ForegroundColor Green
    Write-Host "---------------------------------" 
}
