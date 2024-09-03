# edk2_build_template
Provide scripts and tools for EDK2 on Windows

- src directory: source code location
- tools: external tools for EDK2 (iasl and nasm)

Directories ignored by git in workspace: 
- Build
- test*
- src/*

## Quick start guide
1. Prepare essential environment of edk2 (Python3 and VS2022)
1. Put edk2 and others package in src dir.
1. Launch a cmd on workspace, or right ckick OpenCmdHere.bat.
1. Excute build_Emulator.bat to start platform compiling(EmulatorPkg).
1. Set AUTO_RUN_WINHOST to 1 if you want run winhost in the end of build command
