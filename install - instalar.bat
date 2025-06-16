@echo off
cd /d "%~dp0"

:: Executar o instalador da pasta resources
resources\install-interception.exe /install

:: Verificar privilégios administrativos e solicitar elevação se necessário
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorLevel% neq 0 (
    echo Solicitando privilegios administrativos...
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

:: Copiar DLL para System32
copy /Y "resources\interception.dll" "%SystemRoot%\System32"

cls