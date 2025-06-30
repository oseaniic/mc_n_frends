@echo off
setlocal enabledelayedexpansion

set "target_dir=%appdata%\PollyMC\instances\1.6.4"
set "mods_target=%target_dir%\.minecraft\mods"
set "resourcepacks_target=%target_dir%\.minecraft\resourcepacks"
set "shaderpacks_target=%target_dir%\.minecraft\shaderpacks"

:: Check if launcher exists
if exist "%target_dir%\" (
    echo Launcher PollyMC Encontrado..
) else (
    echo LA CARPETA
    echo %target_dir% 
    echo NO EXISTE, ASEGURATE DE QUE INSTALASTE EL LAUNCHER POLLYMC
    pause
    exit /b 1
)

:: User choice loop
:choice
echo Instalar mods ahora? (ADVERTENCIA: Los mods instalados actualmente seran borrados permanentemente)
echo [1] Si
echo [2] No
set /p choice="Seleccione una opcion [1/2]: "

if "%choice%"=="2" (
    pause
    exit /b 0
) else if "%choice%"=="1" (
    goto install
) else (
    echo Opcion invalida. Por favor seleccione 1 o 2.
    goto choice
)

:install
:: Set source paths relative to script location
set "script_dir=%~dp0"
set "source_base=!script_dir!\versions\1.6.4_mod"
set "mods_source=!source_base!\mods"
set "resourcepacks_source=!source_base!\resourcepacks"
set "shaderpacks_source=!source_base!\shaderpacks"

:: Verify source directories exist
if not exist "!mods_source!\" (
    echo ERROR: Carpeta de mods no encontrada: !mods_source!
    pause
    exit /b 1
)
if not exist "!resourcepacks_source!\" (
    echo ERROR: Carpeta de resourcepacks no encontrada: !resourcepacks_source!
    pause
    exit /b 1
)
if not exist "!shaderpacks_source!\" (
    echo ERROR: Carpeta de shaderpacks no encontrada: !shaderpacks_source!
    pause
    exit /b 1
)

:: Wipe and replace mods
echo Limpiando mods existentes...
if exist "!mods_target!\" (
    rmdir /s /q "!mods_target!"
)
mkdir "!mods_target!"
xcopy /e /y "!mods_source!\*" "!mods_target!\" >nul

:: Copy resourcepacks (overwrite existing)
echo Copiando resourcepacks...
xcopy /e /y "!resourcepacks_source!\*" "!resourcepacks_target!\" >nul

:: Copy shaderpacks (overwrite existing)
echo Copiando shaderpacks...
xcopy /e /y "!shaderpacks_source!\*" "!shaderpacks_target!\" >nul

echo Mods instalados sin errores.
echo ===
pause