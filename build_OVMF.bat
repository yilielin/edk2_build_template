@echo off
cd  %~d0%~p0 && %~d0
call base_env_setup.bat
:: Project settings
set "EDK_TOOLS_PATH=%WORKSPACE%\src\edk2\BaseTools"
set "PACKAGES_PATH=%WORKSPACE%\src\edk2"
set "ACTIVE_PLATFORM=OvmfPkg\OvmfPkgX64.dsc"
set "TARGET=RELEASE"
set "TARGET_ARCH=X64"
set "TOOL_CHAIN_TAG=VS2022"


call "src\edk2\edksetup.bat"

call build -a %TARGET_ARCH% -t %TOOL_CHAIN_TAG% -b %TARGET% -p %ACTIVE_PLATFORM%


:PROG_END
goto :EOF


