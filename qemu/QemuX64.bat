@echo off
chcp 65001 > NUL
set "SELF_PATH=%~d0%~p0"

:: ==== CONFIG ====
set "QEMU_OVMF_PATH=%SELF_PATH%\OVMF.fd"
set "QEMU_EMULATOR=qemu-system-x86_64.exe"
set "QEMU_MACHINE=q35"
set "QEMU_SMP_CPUS=2"
set "QEMU_MEM=512M"
set "QEMU_NET=none"
@REM set "QEMU_NET=rtl8139"

:: QEMU_MOUNT_TYPE: NONE, VHDX or DIR
set "QEMU_MOUNT_TYPE=DIR"
set "QEMU_VHDX_PATH=%SELF_PATH%\disk0.vhdx"
set "QEMU_DISK0_PATH=%SELF_PATH%\disk0"


:: ==== CHECK qemu and files ====
%QEMU_EMULATOR% --help > NUL || ( echo " %QEMU_EMULATOR% " && goto :PROG_ERROR )
if not exist %QEMU_OVMF_PATH% ( echo " OVMF is not found, exit. " && goto :PROG_ERROR )
if not exist %QEMU_VHDX_PATH% ( echo " VHDX is not found. " ) 
if not exist %QEMU_DISK0_PATH% ( echo " DISK DIR is not found. " ) 

:: start
if /I "%1"=="M" (
    call :MOUNT_QEMU_VHDX
    goto :END
) else if /I "%1"=="U" (
    call :UNMOUNT_QEMU_VHDX
    goto :END
)

if "%QEMU_MOUNT_TYPE%"=="VHDX" (
  set "QEMU_DISK0_CMD= -drive format=vhdx,file=%QEMU_VHDX_PATH% "
  :: Test and unmount VHDX before QEMU starting up
  call :UNMOUNT_QEMU_VHDX
) else if "%QEMU_MOUNT_TYPE%"=="DIR" (
  set "QEMU_DISK0_CMD= -drive file=fat:rw:%QEMU_DISK0_PATH%,format=raw,media=disk "
) else (
  set "QEMU_DISK0_CMD= "
)


:: Configure commands
set "QEMU_EMULATOR_CMD= %QEMU_EMULATOR% -device usb-ehci -device usb-tablet -vga std "
set "QEMU_MACHINE_CMD= -machine %QEMU_MACHINE% "
set "QEMU_SMP_CMD= -smp %QEMU_SMP_CPUS% "
set "QEMU_MEM_CMD= -m %QEMU_MEM% "
set "QEMU_BIOS_CMD= -bios %QEMU_OVMF_PATH%"
if "%QEMU_NET%"=="rtl8139" (
  set "QEMU_NET_CMD= -netdev user,id=net0 -device rtl8139,netdev=net0 "
) else (
  set "QEMU_NET_CMD= -net none "
)

:: Print settings
echo %QEMU_EMULATOR_CMD%
echo %QEMU_MACHINE_CMD%
echo %QEMU_BIOS_CMD%
echo %QEMU_NET_CMD%
echo %QEMU_DISK0_CMD%
echo %QEMU_SMP_CMD% 
echo %QEMU_MEM_CMD%
:: Start to launch QEMU
set "QEMU_UEFI_CMD=%QEMU_EMULATOR_CMD% %QEMU_MACHINE_CMD% %QEMU_SMP_CMD% %QEMU_MEM_CMD% %QEMU_NET_CMD% %QEMU_DISK0_CMD% %QEMU_BIOS_CMD%"
%QEMU_UEFI_CMD%

:END
goto :EOF

:: Error handle
:PROG_ERROR
timeout 3
goto :END



:MOUNT_QEMU_VHDX
REM Mount VHDX need administer privilege
powershell -command "(Get-DiskImage -ImagePath "%QEMU_VHDX_PATH%").Attached" > testMount.txt
set /p isMount=<testMount.txt
if /I "%isMount%"=="False" (
    echo Mount %QEMU_VHDX_PATH%
    powershell -command "Mount-DiskImage -ImagePath "%QEMU_VHDX_PATH%""  > NUL
)
if exist testMount.txt ( del /Q testMount.txt )
exit /b 0

:UNMOUNT_QEMU_VHDX
REM Un-mount VHDX need administer privilege
powershell -command "(Get-DiskImage -ImagePath "%QEMU_VHDX_PATH%").Attached" > testMount.txt
set /p isMount=<testMount.txt
if /I "%isMount%"=="True" (
    echo Unmount %QEMU_VHDX_PATH%
    powershell -command "Dismount-DiskImage -ImagePath "%QEMU_VHDX_PATH%"" > NUL
)
if exist testMount.txt ( del /Q testMount.txt )
exit /b 0