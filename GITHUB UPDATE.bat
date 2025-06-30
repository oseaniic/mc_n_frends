:: =============== UPDATE REPOSITORY SECTION ===============
set "repo_url=https://github.com/oseaniic/mc_n_frends"
set "temp_dir=%temp%\mc_n_frends_temp"
set "current_dir=%~dp0"

echo Actualizando repositorio...
echo.

echo Creando directorio temporal...
mkdir "%temp_dir%" >nul 2>&1

echo Clonando repositorio actualizado...
git clone --depth 1 "%repo_url%" "%temp_dir%" 
if errorlevel 1 (
    echo ERROR: No se pudo clonar el repositorio
    echo Posibles causas:
    echo 1. Sin conexión a internet
    echo 2. Problemas con Git
    pause
    exit /b 1
)

echo Copiando archivos actualizados...
robocopy "%temp_dir%" "%current_dir%" /MIR /NFL /NDL /NJH /NJS
if errorlevel 8 (
    echo ERROR: No se pudo copiar los archivos
    pause
    exit /b 1
)

echo Limpiando temporal...
rmdir /s /q "%temp_dir%"
echo Repositorio actualizado correctamente.
echo.
:: =============== END UPDATE SECTION ===============