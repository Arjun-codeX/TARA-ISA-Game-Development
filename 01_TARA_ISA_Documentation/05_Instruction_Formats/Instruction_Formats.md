# Chapter 5: Instruction Formats and Binary Encoding

## 5.1 Instruction Format Overview
## 5.2 F0 Format
## 5.3 F1 Format
## 5.4 F2 Format
## 5.5 F3 Format
## 5.6 F4 Format
## 5.7 F5 Format
## 5.8 F6 Format
## 5.9 F7 Format
## 5.10 Opcode Encoding
## 5.11 Operand Encoding
## 5.12 Binary-to-Assembly Conversion

# PART 5: TARA16 INSTRUCTION FORMATS AND BINARY ENCODING

## 5.1 Introduction

A processor understands machine instructions represented in binary form.

Assembly language provides a human-readable representation of these instructions. The assembler converts assembly instructions into their corresponding machine-code representation.

TARA16 uses a fixed-width instruction representation of 16 bits.

Each instruction contains an opcode that identifies the operation to be performed. The instruction set is organized into eight formats, F0–F7.

Understanding instruction formats is important because they explain how instructions represent operations and operands.

## 5.2 TARA16 Instruction Specifications

| Parameter                 | Specification |
| ------------------------- | ------------- |
| Architecture              | TARA16        |
| Instruction width         | 16 bits       |
| Opcode width              | 5 bits        |
| General-purpose registers | 8             |
| Register names            | R0–R7         |
| Register identifier width | 3 bits        |
| Instruction formats       | F0–F7         |
| Opcode representation     | Binary        |

### Instruction Width

TARA16 uses 16-bit instructions.

Therefore, each encoded instruction contains 16 binary digits.

For example:

```text
00000 00000000000
```

This is an illustrative 16-bit layout, not a confirmed complete instruction encoding.

### Opcode Width

The opcode occupies 5 bits.

A 5-bit field can represent:

2⁵ = 32 different values.

Therefore, the opcode field can represent values from:

```text
00000 to 11111
```

The opcode identifies the instruction operation.

## 5.3 Register Encoding

TARA16 provides eight general-purpose registers:

R0, R1, R2, R3, R4, R5, R6 and R7.

Three bits are sufficient to identify eight registers.

| Register | Binary Encoding |
| -------- | --------------- |
| R0       | 000             |
| R1       | 001             |
| R2       | 010             |
| R3       | 011             |
| R4       | 100             |
| R5       | 101             |
| R6       | 110             |
| R7       | 111             |

For example:

```text
R0 = 000
R1 = 001
R2 = 010
R3 = 011
```

These are the binary register identifiers. Their positions within individual instruction formats depend on the encoding definition.

## 5.4 Complete TARA16 Opcode Table

The following table contains the opcode assignments used by the TARA16 instruction implementation.

| Decimal Opcode | Binary Opcode | Instruction |
| -------------: | ------------- | ----------- |
|              0 | 00000         | NOP         |
|              1 | 00001         | HLT         |
|              2 | 00010         | MOV         |
|              3 | 00011         | LIL         |
|              4 | 00100         | LIH         |
|              5 | 00101         | LDW         |
|              6 | 00110         | STW         |
|              7 | 00111         | LDB         |
|              8 | 01000         | STB         |
|              9 | 01001         | ADD         |
|             10 | 01010         | SUB         |
|             11 | 01011         | ADDI        |
|             12 | 01100         | MUL         |
|             13 | 01101         | AND         |
|             14 | 01110         | OR          |
|             15 | 01111         | XOR         |
|             16 | 10000         | NOT         |
|             17 | 10001         | SHL         |
|             18 | 10010         | SHR         |
|             19 | 10011         | SLT         |
|             20 | 10100         | BZ          |
|             21 | 10101         | BN          |
|             22 | 10110         | JMP         |
|             23 | 10111         | CALL        |
|             24 | 11000         | RET         |
|             25 | 11001         | PUSH        |
|             26 | 11010         | POP         |

There are 27 assigned instruction opcodes in this table.

The remaining 5-bit opcode values are not assigned in this instruction mapping.

## 5.5 Instruction Format Organization

TARA16 organizes its instructions into eight formats.

| Format | Instructions                     | Functional Category           |
| ------ | -------------------------------- | ----------------------------- |
| F0     | NOP, HLT, RET                    | Processor and program control |
| F1     | ADD, SUB, MUL, AND, OR, XOR, SLT | Arithmetic and logical        |
| F2     | MOV, NOT                         | Data movement and logical     |
| F3     | LIL, LIH, ADDI, SHL, SHR         | Immediate and shift           |
| F4     | LDW, STW, LDB, STB               | Memory access                 |
| F5     | BZ, BN                           | Conditional branching         |
| F6     | JMP, CALL                        | Jump and subroutine control   |
| F7     | PUSH, POP                        | Stack operations              |

Each format groups instructions according to their operand and operation requirements.

## 5.6 F0 – Control Instruction Format

F0 contains basic program-control instructions.

| Instruction | Binary Opcode |
| ----------- | ------------- |
| NOP         | 00000         |
| HLT         | 00001         |
| RET         | 11000         |

### NOP

NOP represents a no-operation instruction.

### HLT

HLT stops program execution.

### RET

RET returns from a subroutine.

These instructions have different execution behaviours even though they belong to the same instruction category.

## 5.7 F1 – Arithmetic and Logical Format

F1 contains arithmetic and logical operations.

| Instruction | Binary Opcode |
| ----------- | ------------- |
| ADD         | 01001         |
| SUB         | 01010         |
| MUL         | 01100         |
| AND         | 01101         |
| OR          | 01110         |
| XOR         | 01111         |
| SLT         | 10011         |

### Example: ADD

Conceptually:

```text
ADD R1, R2, R3
```

Assuming destination-first operand ordering:

```text
R1 = R2 + R3
```

### Example: AND

```text
AND R1, R2, R3
```

Conceptually:

```text
R1 = R2 AND R3
```

The complete 16-bit encoding depends on the positions assigned to the register operands.

## 5.8 F2 – Data Movement and Logical Format

F2 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| MOV         | 00010         |
| NOT         | 10000         |

MOV transfers a value between supported operands.

NOT performs bitwise inversion.

## 5.9 F3 – Immediate and Shift Format

F3 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| LIL         | 00011         |
| LIH         | 00100         |
| ADDI        | 01011         |
| SHL         | 10001         |
| SHR         | 10010         |

### Immediate Values

An immediate value is a constant represented directly within an instruction.

For example, an immediate arithmetic operation uses a constant instead of obtaining every operand from a register.

### Shift Operations

SHL shifts bits towards the left.

SHR shifts bits towards the right.

The exact immediate field width and shift-amount encoding must be taken from the TARA16 encoder.

## 5.10 F4 – Memory Instruction Format

F4 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| LDW         | 00101         |
| STW         | 00110         |
| LDB         | 00111         |
| STB         | 01000         |

These instructions provide memory access operations.

* LDW reads a word.
* STW writes a word.
* LDB reads a byte.
* STB writes a byte.

The complete instruction encoding must represent the required register and memory-address information.

## 5.11 F5 – Conditional Branch Format

F5 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| BZ          | 10100         |
| BN          | 10101         |

BZ performs branching based on a zero condition.

BN performs branching based on a negative condition.

Branch instructions allow programs to make decisions and implement loops.

The exact branch condition source, displacement width and target-address calculation depend on the instruction implementation.

## 5.12 F6 – Jump and Subroutine Format

F6 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| JMP         | 10110         |
| CALL        | 10111         |

JMP changes the normal program execution sequence.

CALL transfers control to a subroutine.

A subroutine can return using RET.

These instructions are useful for implementing loops, functions and reusable program sections.

## 5.13 F7 – Stack Instruction Format

F7 contains:

| Instruction | Binary Opcode |
| ----------- | ------------- |
| PUSH        | 11001         |
| POP         | 11010         |

PUSH stores a value on the stack.

POP retrieves a value from the stack.

Stack instructions are useful for preserving temporary values and supporting subroutine execution.

## 5.14 Understanding Binary Opcode Conversion

Each instruction has a decimal opcode value and its corresponding 5-bit binary representation.

For example:

ADD has decimal opcode 9.

Converting decimal 9 into binary:

```text
9 = 01001
```

Therefore:

```text
ADD → 01001
```

Similarly:

```text
SUB → 01010
MUL → 01100
AND → 01101
OR  → 01110
XOR → 01111
```

The opcode is only one part of a complete instruction. The remaining bits represent other information according to the instruction format.

## 5.15 Assembly Language and Machine Code

Assembly language uses readable instruction names.

Machine code represents instructions in binary form.

The conversion process is:

```text
Assembly Program
       |
       v
Instruction Identification
       |
       v
Opcode Selection
       |
       v
Operand Identification
       |
       v
Instruction Encoding
       |
       v
16-bit Machine Instruction
```

For example, an assembly instruction containing ADD is identified using its opcode.

The encoder then combines the opcode with the appropriate operand fields to produce the final instruction.

## 5.16 Unused Opcode Values

The 5-bit opcode field provides 32 possible binary values.

The current instruction mapping assigns 27 values.

Therefore, five values remain unassigned:

```text
11011
11100
11101
11110
11111
```

These values should not be assumed to represent valid instructions unless the TARA16 implementation defines them.

## 5.17 Importance of Instruction Encoding

Instruction encoding connects assembly language with machine-level execution.

Understanding encoding helps developers:

* Read machine instructions.
* Understand opcode selection.
* Identify register operands.
* Understand immediate values.
* Debug assembler output.
* Verify instruction decoding.
* Understand the relationship between assembly and binary code.

## 5.18 Chapter Summary

TARA16 uses fixed-width 16-bit instructions with a 5-bit opcode field.

It provides eight general-purpose registers, each identified using three bits.

The instruction set contains 27 assigned opcode values and is organized into eight formats, F0–F7.

The opcode identifies the operation, while the remaining instruction bits are used according to the relevant format.

The exact operand-field layouts, immediate widths and complete binary encodings must be documented from the TARA16 encoder and decoder implementation.

## 5.19 Next Chapter

PART 6: TARA16 Assembly Language

The next chapter explains assembly-language syntax, instruction structure, labels, constants, registers, branching, loops, subroutines and practical programming examples.
