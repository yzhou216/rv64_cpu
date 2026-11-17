<!--
SPDX-FileCopyrightText: 2026 Yiyu Zhou <yiyu@yiyuzhou.io>

SPDX-License-Identifier: GPL-3.0-or-later
-->

# rv64_cpu

Single-cycle and pipelined 64-bit RISC-V processor in Digital

`src/rv64_cpu.dig` executes the subset of RV64IM that the test programs
in RISC-V assembly need, one instruction per clock cycle.  Matchers that
recognize each instruction address a ROM of control words, which drive
the datapath, and the instruction memory holds a ROM for every program.
The `unimp` at the end of a program raises DONE, which stops the clock.

`src/pipeline.dig` runs the same programs on a five-stage pipeline built
from the same parts: instruction fetch (IF), decode and register read
(DR), execute (EX), memory access (MEM), and write-back (WB), with a
pipeline register between each pair of stages.  Its hazard unit forwards
results from MEM and WB to EX, holds DR for a cycle when it needs the
result of a load in EX, and drops the two instructions fetched after a
taken branch or jump.  EX picks the value to write back, the ALU result
or PC+4, so MEM forwards that value as it is and WB only chooses between
it and the loaded value.  The register file writes in the middle of the
cycle, so that DR reads what WB writes, and DONE rises once the `unimp`
reaches WB.

## Running

Open `src/rv64_cpu.dig` or `src/pipeline.dig` in
[Digital](https://github.com/hneemann/Digital), set PROG to the number in
the name of a program in `progs`, clear the processor with CLR, then set
EN and run the clock until DONE rises.  A0, A1, and A2 show the argument
registers, and probes show the others.

## Building

On a RISC-V machine, `make` assembles the programs into the ROM images
that `progs/hex` keeps, and turns the table of control words in
`decode/rom.csv` into the image of the decoder ROM:

    make -C progs
    make -C decode

Elsewhere, point `AS` and `OBJDUMP` at a RISC-V toolchain:

    make -C progs AS=riscv64-linux-gnu-as OBJDUMP=riscv64-linux-gnu-objdump

Digital stores what a ROM holds in the circuit, so a new image only
takes effect once it is loaded into its ROM.

With Nix, `nix run` opens the processor in Digital, `nix run .#pipeline`
opens the pipeline, and `nix develop` opens a shell with Digital and the
RISC-V binutils of Nixpkgs, in which plain `make` builds the images.
`nix flake check` runs every program on both processors and checks that
the images and the ROMs match their sources:

    nix run
    nix flake check

## License

rv64_cpu is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation, either version 3 of the License, or any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
