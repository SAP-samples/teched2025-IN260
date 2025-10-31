@echo off
setlocal enabledelayedexpansion

:input
set /p number="Enter a two-digit number (00-99): "

:: Validate input is exactly 2 digits
echo %number%| findstr /r "^[0-9][0-9]$" >nul
if errorlevel 1 (
    echo Invalid input! Please enter exactly two digits.
    goto input
)

set "oldString=UserXX"
set "newString=User%number%"

echo.
echo This will replace all occurrences of "%oldString%" with "%newString%"
echo in all files within this directory and subdirectories.
echo.
set /p confirm="Do you want to continue? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo Operation cancelled.
    exit /b
)

echo.
echo Processing files...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "$oldString = '%oldString%'; $newString = '%newString%'; $count = 0; $scanned = 0; Write-Host \"Searching for: $oldString\" -ForegroundColor Cyan; Write-Host \"Replacing with: $newString\" -ForegroundColor Cyan; Write-Host \"\"; Get-ChildItem -Path . -Recurse -File | ForEach-Object { $scanned++; if ($_.Name -notmatch '\.(bat|ps1)$') { try { $content = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8); if ($content -match [regex]::Escape($oldString)) { Write-Host \"Found match in: $($_.FullName)\"; $newContent = $content -replace [regex]::Escape($oldString), $newString; [System.IO.File]::WriteAllText($_.FullName, $newContent, [System.Text.Encoding]::UTF8); Write-Host \"  -- Replaced successfully\" -ForegroundColor Green; $count++; } } catch { } } }; Write-Host \"\"; Write-Host \"====================================\"; Write-Host \"Scanned $scanned file(s)\"; Write-Host \"Modified $count file(s)\"; Write-Host \"====================================\";"

echo.
pause