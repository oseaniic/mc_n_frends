@echo off
set "instance_path=%appdata%\PollyMC\instances\1.6.4"

if exist "%instance_path%" (
    echo it exists good joob
) else (
    echo error
    exit /b 1
)

echo working very hard
pause