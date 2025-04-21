# headless-rustdesk-installer-window

## Chuẩn bị
- Mở PowerShell (Administrator) trên máy điều khiển.
- Đảm bảo WinRM (PS Remoting) đã bật trên tất cả Windows target (Enable-PSRemoting).
- Copy 3 file vào cùng một thư mục.

## Chạy deploy
cd path\to\your\folder
.\deploy-windows.ps1
- Nhập credentials Admin khi được hỏi.
- Script sẽ tự động copy, cài, cấu hình password unattended và in ra RustDesk ID.

## Kiểm tra
- Trên mỗi máy target, bạn có thể mở:
Get-Content "C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk.toml"
- để xác nhận password đã được ghi đúng. 

## Kiểm tra dịch vụ rustdesk đang chạy:
Get-Service rustdesk
