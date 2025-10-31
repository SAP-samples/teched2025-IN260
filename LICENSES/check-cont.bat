setlocal enabledelayedexpansion

echo Diagnostic Mode - Searching for "User" patterns in your files...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path . -Recurse -File | ForEach-Object { try { $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8); if ($content -match 'User\d{2}|UserXX') { Write-Host \"File: $($_.Name)\" -ForegroundColor Yellow; $matches = [regex]::Matches($content, 'User\d{2}|UserXX'); $matches | Select-Object -First 5 | ForEach-Object { Write-Host \"  Found: $($_.Value)\" -ForegroundColor Green }; Write-Host \"\"; } } catch { } };"

echo.
pause