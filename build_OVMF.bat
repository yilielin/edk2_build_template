@echo off
call base_env.bat

:: Project settings

set "PACKAGES_PATH=%WORKSPACE%\src\edk2"
set "ACTIVE_PLATFORM=OvmfPkg\OvmfPkgX64.dsc"
set "TARGET=RELEASE"
set "TARGET_ARCH=X64"
set "TOOL_CHAIN_TAG=VS2022"

call "edk2\edksetup.bat"

build -a %TARGET_ARCH% -t %TOOL_CHAIN_TAG% -b %TARGET% -p %ACTIVE_PLATFORM% 


