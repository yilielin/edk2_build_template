# edk2_build_template
Provide scripts and tools for EDK2 on Windows

- src directory: source code location
- tools: external tools for EDK2 (iasl and nasm)

Directories are ignored by git in workspace: 
- Output dirs: Build
- Items with test prefix: test*
- Source code: src/*

## Quick start guide
1. Prepare essential environment of edk2 (Python3 and VS2022)
1. Put edk2 and other packages in src dir.
1. Launch a cmd on workspace, use VS code is better or double right-click OpenCmdHere.bat.
1. Excute build_Emulator.bat to start platform compiling of EmulatorPkg.
1. Set RUN_WINHOST to 1 if you want to run winhost once the compiling is finished.
