@echo off
title Agregar Personaje - JARVIS Characters
cd /d "%~dp0"

echo =======================================================================
echo            AGREGAR NUEVO PERSONAJE AL REPOSITORIO
echo =======================================================================
echo.
echo El .zip debe contener una carpeta con estas 5 imagenes:
echo.
echo   nombre_del_personaje/
echo   +-- idle.png          (quieto, sin parpadear)
echo   +-- idle_blink.png    (quieto, parpadeando)
echo   +-- speaking_1.png    (hablando - boca abierta 1)
echo   +-- speaking_2.png    (hablando - boca abierta 2)
echo   +-- thinking.png      (pensando)
echo.
echo Formatos aceptados: .png, .jpg, .jpeg, .webp
echo.

:: ── Pedir datos ──
set /p ID="ID del personaje (ej: robot1): "
set /p NAME="Nombre visible (ej: Robot X): "
set /p DESC="Descripcion corta: "
echo.

:: ── Pedir el archivo zip ──
set "ZIP_SRC="
set /p ZIP_SRC="Arrastra el archivo .zip aqui o pega la ruta: "
if not defined ZIP_SRC (
    echo [ERROR] No se especifico ningun archivo.
    pause
    exit /b 1
)
:: Quitar comillas si las tiene
set ZIP_SRC=%ZIP_SRC:"=%
if not exist "%ZIP_SRC%" (
    echo [ERROR] El archivo no existe: %ZIP_SRC%
    pause
    exit /b 1
)

:: ── Crear carpeta characters si no existe ──
if not exist "characters" mkdir characters

:: ── Copiar el zip ──
set "DEST=characters\%ID%.zip"
copy /y "%ZIP_SRC%" "%DEST%" >nul
if %errorlevel% neq 0 (
    echo [ERROR] No se pudo copiar el archivo.
    pause
    exit /b 1
)
echo [OK] Zip copiado a %DEST%

:: ── Generar URL ──
set "URL=https://github.com/YongllyPM/Jarvis-characters/raw/main/characters/%ID%.zip"

:: ── Actualizar index.json ──
set "PREVIEW=%ID%/idle.png"
set "INDEX_FILE=index.json"

if not exist "%INDEX_FILE%" (
    echo [INFO] Creando index.json nuevo...
    echo { "characters": [] } > "%INDEX_FILE%"
)

powershell -NoProfile -Command ^
    "$f='%INDEX_FILE%';" ^
    "$id='%ID%';" ^
    "$name='%NAME%';" ^
    "$desc='%DESC%';" ^
    "$url='%URL%';" ^
    "$preview='%PREVIEW%';" ^
    "$j=Get-Content $f -Raw | ConvertFrom-Json;" ^
    "$entry=@{" ^
    "  id=$id;" ^
    "  name=$name;" ^
    "  description=$desc;" ^
    "  preview=$preview;" ^
    "  type='sprite';" ^
    "  download_url=$url" ^
    "};" ^
    "$j.characters += $entry;" ^
    "$j | ConvertTo-Json -Depth 5 | Set-Content $f -Encoding UTF8"

if %errorlevel% equ 0 (
    echo [OK] index.json actualizado correctamente.
) else (
    echo [ERROR] Fallo al actualizar index.json.
    pause
    exit /b 1
)

echo.
echo =======================================================================
echo   PERSONAJE AGREGADO CON EXITO
echo =======================================================================
echo.
echo   ID:         %ID%
echo   Nombre:     %NAME%
echo   Descripcion: %DESC%
echo   Zip:        %DEST%
echo.
echo Subi todo el repositorio a GitHub para que aparezca en la tienda.
echo.
pause
