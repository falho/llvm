// RUN: not llvm-mc -arch=amdgcn %s 2>&1 | FileCheck -check-prefix=GCN %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=tahiti %s 2>&1 | FileCheck -check-prefix=GCN -check-prefix=SI %s
// RUN: not llvm-mc -arch=amdgcn -mcpu=tonga %s 2>&1 | FileCheck -check-prefix=GCN -check-prefix=VI %s

s_setreg_b32  0x1f803, s2
// GCN: error: invalid immediate: only 16-bit values are legal

s_setreg_b32  hwreg(0x40), s2
// GCN: error: invalid code of hardware register: only 6-bit values are legal

s_setreg_b32  hwreg(3,32,32), s2
// GCN: error: invalid bit offset: only 5-bit values are legal

s_setreg_b32  hwreg(3,0,33), s2
// GCN: error: invalid bitfield width: only values from 1 to 32 are legal

s_setreg_imm32_b32  0x1f803, 0xff
// GCN: error: invalid immediate: only 16-bit values are legal

s_setreg_imm32_b32  hwreg(3,0,33), 0xff
// GCN: error: invalid bitfield width: only values from 1 to 32 are legal

s_getreg_b32  s2, hwreg(3,32,32)
// GCN: error: invalid bit offset: only 5-bit values are legal
