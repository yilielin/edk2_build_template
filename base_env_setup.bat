
:: Use UTF-8 Code Page
@ chcp 65001 > NUL

:: Set the path of this file as workspace path 
@ set "BUILD_WORKSPACE=%~d0%~p0"

:: Make sure there is no backslash at the end of WORKSPACE
@ if "%BUILD_WORKSPACE:~-1%" EQU "\" (
@   set "WORKSPACE=%BUILD_WORKSPACE:~0,-1%"
) else (
@   set "WORKSPACE=%BUILD_WORKSPACE%"
)

:: Setup NASM and IASL
@ set "NASM_PREFIX=%WORKSPACE%\tools\nasm-2.16.03\"
@ set "IASL_PREFIX=%WORKSPACE%\tools\iasl-win-20240827\"


@ exit /b 0

