# edk2_build_template
Provide scripts and tools for EDK2 on Windows

- src directory: source code location
- tools: external tools for EDK2 (iasl and nasm)

Directories in workspace are ignored by git: 
- Output dir: Build
- Items with test prefix: test*
- Source code: src\\*

## Quick start guide
1. Prepare essential environment of edk2 (Python3 and MSVC)
1. Put edk2 and other packages into src dir.
1. Launch a cmd on workspace or double right-click OpenCmdHere.bat.
1. Excute build_Emulator.bat to start platform compiling of EmulatorPkg.
1. Set RUN_WINHOST to 1 if you want to run winhost once the compiling is finished.

## Note
Make sure BaseTools in edk2 is usable, you can re-build BaseTools.
- Run rebuild_basetools.bat script
- Manually re-build
```
cd edk2\BaseTools\
nmake cleanall
nmake
```
