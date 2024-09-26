@echo off
cd  %~d0%~p0 && %~d0
call base_env_setup.bat
:: Assume edk2 is in src directory.
set "EDK_PATH=%WORKSPACE%\src\edk2\"
set "EDK_TOOLS_PATH=%EDK_PATH%\BaseTools"
set "TOOL_CHAIN_TAG=VS2022"

if exist "%EDK_TOOLS_PATH%" (
  if exist "%EDK_PATH%\edksetup.bat" (
    call "%EDK_PATH%\edksetup.bat" %TOOL_CHAIN_TAG%
    pushd %EDK_TOOLS_PATH% && nmake cleanall && nmake
    popd
  ) else (
    echo src\edk2\edksetup.bat is not found.
  )
) else (
  echo EDK_TOOLS_PATH is not found.
)
goto :EOF
