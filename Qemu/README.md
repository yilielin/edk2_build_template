# Qemu

## Quick start guide
1. Add the path of qemu install folder(typically is C:\Program Files\qemu) into system variable PATH.
1. Put files(e.g *.efi) in folder disk0.
1. Obtain OVMF.fd from edk2/OvmfPkg and put it in this qemu directory.
1. Excute QemuX64 which will mount disk0 as FS0.
1. You can modify QEMU_MOUNT_TYPE to make QemuX64 starts with VHDX as FS0.