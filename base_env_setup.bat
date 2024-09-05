@REM @echo off

:: Use UTF-8 Code Page
chcp 65001 > NUL

:: Set the path of this file as workspace path 
set "WORKSPACE=%~d0%~p0"
:: Remove \ at the last of WORKSPACE variable
set "WORKSPACE=%WORKSPACE:~0,-1%"

:: Setup NASM and IASL
set "NASM_PREFIX=%WORKSPACE%\tools\nasm-2.16.03\"
set "IASL_PREFIX=%WORKSPACE%\tools\iasl-win-20240827\"


exit /b 0

