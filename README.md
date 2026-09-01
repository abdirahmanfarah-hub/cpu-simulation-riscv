# CPU Simulation & RISC-V Assembly

Two halves of a computer architecture project: an 8-bit accumulator-based CPU built and extended in Logisim Evolution, and a set of RISC-V assembly programs written for the RARS simulator.

Coursework for **Computer Architecture**, BSc (Hons) Software Engineering, Manchester Metropolitan University.

## CPU simulation

The circuit is an accumulator machine with a program counter, instruction decoder, ALU, data memory and a memory-mapped output device. Instructions are 16-bit, written as raw hex and loaded straight into instruction memory.

Work done on the base circuit:

- **Extended the ALU** with bitwise NAND, bitwise OR, a right shift, and a set-greater-than comparison. The comparator produces a single bit, so it's zero-extended onto the 8-bit data bus — the ALU outputs `0x01` when the comparison holds and `0x00` when it doesn't.
- **Added a conditional branch instruction.** The branch signal from the decoder is ANDed with the accumulator's non-zero flag, and the result selects between PC+1 and the target address at the program counter's input multiplexer.
- **Added a TTY output device** so the CPU can print characters, driven by loading ASCII values into the accumulator and writing them out.

### Instruction format

| Opcode | Meaning |
| --- | --- |
| `1xxx` | Load immediate into accumulator |
| `2xxx` | Load from memory / ALU operation (second nibble selects the operation) |
| `3xxx` | Store accumulator to memory address |
| `4xxx` | Branch to address if accumulator is non-zero |
| `5000` | Write accumulator to output device |
| `f000` | Stop |

### Test programs

The `.dat` files are test programs in Logisim's `v2.0 raw` format, each written to exercise one piece of the design — arithmetic and storage, the bitwise operations, the shift and comparison, character output, and the branch. Expected memory contents were worked out by hand before each run and checked against the simulator afterwards.

## RISC-V assembly

Written for [RARS](https://github.com/TheThirdOne/rars). The programs cover:

- Console I/O through system calls — prompting for input, reading integers, printing labelled results.
- Arithmetic and bitwise operations, including NAND built as an `and` followed by a `not`, since RISC-V has no single NAND instruction.
- A subroutine called with `jal` and returned from with `ret`, used to print a message and a value without repeating the same block for each output.
- Sorting two inputs high to low, implemented twice: once with `slt`/`beq` and once with `sgt`/`bnez`, to compare a native instruction against a pseudo-instruction.

One thing worth noting from testing: a NAND result prints as a negative decimal in RARS because registers are 32-bit two's complement, so the 8-bit pattern `0xE3` becomes `0xFFFFFFE3`. The bit pattern matches the CPU simulation, only the display differs.

## Files

```
.
├── cpu/
│   ├── cpu.circ           # the extended circuit
│   └── programs/          # .dat test programs in v2.0 raw format
└── riscv/
    ├── coursework.asm     # I/O, bitwise operations, subroutine
    ├── sort_slt.asm       # sort two inputs using slt / beq
    └── sort_sgt.asm       # same, using sgt / bnez
```

## Running it

**CPU:** open the `.circ` file in [Logisim Evolution](https://github.com/logisim-evolution/logisim-evolution). Right-click the instruction memory, choose Load Image, and pick one of the `.dat` files. Tick the clock to step through, or enable auto-tick to run it.

**RISC-V:** open a `.asm` file in RARS, assemble, then run. Programs that read input use the Run I/O panel.
