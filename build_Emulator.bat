@echo off
call base_env_setup.bat
:: Project settings
set "EDK_TOOLS_PATH=%WORKSPACE%\src\edk2\BaseTools"
set "PACKAGES_PATH=%WORKSPACE%\src\edk2"
set "ACTIVE_PLATFORM=EmulatorPkg\EmulatorPkg.dsc"
set "TARGET=RELEASE"
set "TARGET_ARCH=X64"
set "TOOL_CHAIN_TAG=VS2022"

:: auto run winhost, set to 1 to enable
set "AUTO_RUN_WINHOST="

call "src\edk2\edksetup.bat"

call build -a %TARGET_ARCH% -t %TOOL_CHAIN_TAG% -b %TARGET% -p %ACTIVE_PLATFORM%

if "%AUTO_RUN_WINHOST%"=="1" goto :WIN_HOST
:PROG_END
goto :EOF

:WIN_HOST
:: Launch WinHost if it exist
set "PATH_WINHOST=%WORKSPACE%\Build\Emulator%TARGET_ARCH%\%TARGET%_%TOOL_CHAIN_TAG%\%TARGET_ARCH%"
if exist "%PATH_WINHOST%\WinHost.exe" (
    pushd %PATH_WINHOST%
    cmd /c WinHost.exe
    popd
)
goto :PROG_END
