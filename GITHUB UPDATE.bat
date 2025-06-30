@echo off
setlocal enabledelayedexpansion

:: =============== UPDATE REPOSITORY SECTION ===============
echo Creando script de actualizacion...
set "update_script=%temp%\mc_n_frends_update.bat"
set "current_dir=%~dp0"

(
  echo @echo off
  echo cd /d "!current_dir!.."
  echo rmdir /s /q mc_n_frends
  echo git clone "https://github.com/oseaniic/mc_n_frends"
) > "%update_script%"

echo Ejecutando actualizacion...
start "" /wait cmd /c "%update_script%"
cd /d "%current_dir%"
echo Repositorio actualizado correctamente.
echo.