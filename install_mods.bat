@echo off
setlocal enabledelayedexpansion

set "target_dir=%appdata%\PollyMC\instances\1.6.4"
set "mods_target=%target_dir%\.minecraft\mods"
set "resourcepacks_target=%target_dir%\.minecraft\resourcepacks"
set "shaderpacks_target=%target_dir%\.minecraft\shaderpacks"

:: Set source paths relative to script location
set "script_dir=%~dp0"
set "source_base=!script_dir!\versions\1.6.4_mod"
set "mods_source=!source_base!\mods"
set "resourcepacks_source=!source_base!\resourcepacks"
set "shaderpacks_source=!source_base!\shaderpacks"

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
cls
echo ===============================================
echo ADVERTENCIA: Se realizaran los siguientes cambios
echo ===============================================
echo.
echo 1. Se borraran TODOS los mods actuales en:
echo    "%mods_target%"
echo.
echo 2. Se instalaran los siguientes archivos:
echo.

echo === Mods a instalar ===
if exist "!mods_source!\" (
    for /f "delims=" %%f in ('dir /b "!mods_source!"') do (
        echo   - %%f
    )
) else (
    echo   [ERROR: Carpeta de mods no encontrada]
)
echo.

echo === Resourcepacks a instalar ===
if exist "!resourcepacks_source!\" (
    for /f "delims=" %%f in ('dir /b "!resourcepacks_source!"') do (
        echo   - %%f
    )
) else (
    echo   [ERROR: Carpeta de resourcepacks no encontrada]
)
echo.

echo === Shaderpacks a instalar ===
if exist "!shaderpacks_source!\" (
    for /f "delims=" %%f in ('dir /b "!shaderpacks_source!"') do (
        echo   - %%f
    )
) else (
    echo   [ERROR: Carpeta de shaderpacks no encontrada]
)
echo.

echo ===============================================
echo Instalar mods ahora? (ADVERTENCIA: Los mods instalados actualmente seran borrados permanentemente)
echo [1] Si
echo [2] No
echo ===============================================
set /p choice="Seleccione una opcion [1/2]: "

if "!choice!"=="2" (
    pause
    exit /b 0
) else if "!choice!"=="1" (
    goto install
) else (
    echo.
    echo Opcion invalida. Por favor seleccione 1 o 2.
    timeout /t 2 >nul
    goto choice
)

cls

:install
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
echo.
echo Limpiando mods existentes...
if exist "!mods_target!\" (
    rmdir /s /q "!mods_target!"
)
mkdir "!mods_target!"
echo Copiando nuevos mods...
for /f "delims=" %%f in ('dir /b "!mods_source!"') do (
    echo   - Copiando %%f
    copy /y "!mods_source!\%%f" "!mods_target!\" >nul
)

:: Copy resourcepacks (overwrite existing)
echo.
echo Copiando resourcepacks...
for /f "delims=" %%f in ('dir /b "!resourcepacks_source!"') do (
    echo   - Copiando %%f
    copy /y "!resourcepacks_source!\%%f" "!resourcepacks_target!\" >nul
)

:: Copy shaderpacks (overwrite existing)
echo.
echo Copiando shaderpacks...
for /f "delims=" %%f in ('dir /b "!shaderpacks_source!"') do (
    echo   - Copiando %%f
    copy /y "!shaderpacks_source!\%%f" "!shaderpacks_target!\" >nul
)

echo.
echo ===============================================
echo Mods instalados sin errores.
echo ===============================================
pause