:: Update script
set "repo_path=%~dp0"  %= Path to current directory =%
cd /d "%repo_path%"

echo Actualizando repositorio...
git fetch origin
if errorlevel 1 (
    echo Error: No se pudo obtener los cambios del repositorio remoto
    pause
    exit /b 1
)

git reset --hard origin/main
if errorlevel 1 (
    echo Error: No se pudo restablecer los cambios locales
    pause
    exit /b 1
)

git clean -fd -q
echo Repositorio actualizado correctamente.
echo.