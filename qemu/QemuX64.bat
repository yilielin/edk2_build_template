@echo off
chcp 65001 > NUL
cd  %~d0%~p0 && %~d0

REM Need run with administer privilege
REM QemuX64.bat
REM 1.unmount vhdx
REM 2.Launch qemu
REM 3.mount vhdx when qemu is terminated

REM QemuX64.bat m
REM mount vhdx

REM QemuX64.bat u
REM unmount vhdx


:: CONFIG
set "VHDX_IMG=%CD%\disk0.vhdx"
set "QEMU_OVMF=%CD%\OVMF.fd"
set "QEMU_X64=qemu-system-x86_64.exe"

:: CHECK qemu and files
%QEMU_X64% --help > NUL || ( echo " Can not invoke qemu-system-x86_64.exe " && goto :PROG_ERROR )
if not exist %QEMU_OVMF% ( echo " OVMF is not found, exit. " && goto :PROG_ERROR )
if not exist %VHDX_IMG% ( echo " VHDX is not found, exit. " && goto :PROG_ERROR ) 

:: start

if /I "%1"=="M" (
    call :MOUNT_VHDX
    goto :END
) else if /I "%1"=="U" (
    call :UNMOUNT_VHDX
    goto :END
)



call :UNMOUNT_VHDX
echo Run QEMU with OVMF
echo.
set "QEMU_EMULATOR= qemu-system-x86_64.exe -device usb-ehci -device usb-tablet -vga std "
set "QEMU_MACHINE= -machine q35 "
set "QEMU_SMP= -smp 2 "
set "QEMU_MEM= -m 1024M "
set "QEMU_BIOS= -bios %QEMU_OVMF%"
set "QEMU_DISK0= -drive format=vhdx,file=%VHDX_IMG%"

:: QEMU without network
set "QEMU_NET= -net none"
:: QEMU with network
REM set "QEMU_NET= -netdev user,id=net0 -device rtl8139,netdev=net0"

:: Print settings
echo %QEMU_EMULATOR%
echo %QEMU_MACHINE%
echo %QEMU_BIOS%
echo %QEMU_NET%
echo %QEMU_DISK0%
echo %QEMU_SMP% 
echo %QEMU_MEM%
:: Launch
set "QEMU_UEFI_CMD=%QEMU_EMULATOR% %QEMU_MACHINE% %QEMU_SMP% %QEMU_MEM% %QEMU_NET% %QEMU_DISK0% %QEMU_BIOS%"
echo Run %QEMU_UEFI_CMD%
%QEMU_UEFI_CMD%
call :MOUNT_VHDX
:END
goto :EOF


:: Error handle
:PROG_ERROR
timeout 3
goto :END


:MOUNT_VHDX
powershell -command "(Get-DiskImage -ImagePath "%VHDX_IMG%").Attached" > testMount.txt
set /p isMount=<testMount.txt
if /I "%isMount%"=="False" (
    echo Mount %VHDX_IMG%
    powershell -command "Mount-DiskImage -ImagePath "%VHDX_IMG%""  > NUL
)
if exist testMount.txt (del /Q testMount.txt)
exit /b 0

:UNMOUNT_VHDX
powershell -command "(Get-DiskImage -ImagePath "%VHDX_IMG%").Attached" > testMount.txt
set /p isMount=<testMount.txt
if /I "%isMount%"=="True" (
    echo Unmount %VHDX_IMG%
    powershell -command "Dismount-DiskImage -ImagePath "%VHDX_IMG%"" > NUL
)
if exist testMount.txt (del /Q testMount.txt)
exit /b 0