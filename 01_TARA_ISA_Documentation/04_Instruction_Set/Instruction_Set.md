# PART 4: TARA16 INSTRUCTION SET

## 4.1 Introduction to the Instruction Set

An Instruction Set Architecture (ISA) defines the instructions that a processor or execution environment can understand and execute.

An instruction tells the execution environment to perform a particular operation, such as:

* Adding two values.
* Subtracting numbers.
* Moving data between registers.
* Reading data from memory.
* Writing data into memory.
* Performing logical operations.
* Changing the program execution sequence.

TARA16 provides instructions organized into eight formats, F0–F7.

These instructions are used to develop assembly-language applications.

## 4.2 Classification of TARA16 Instructions

The TARA16 instruction set can be divided into the following categories:

1. Processor and program control instructions.
2. Arithmetic instructions.
3. Logical instructions.
4. Data movement instructions.
5. Immediate instructions.
6. Shift instructions.
7. Memory instructions.
8. Branch and jump instructions.
9. Stack instructions.

## 4.3 F0 – Processor and Program Control Instructions

F0 contains instructions related to basic program control.

| Instruction | Description              |
| ----------- | ------------------------ |
| NOP         | No Operation             |
| HLT         | Halt program execution   |
| RET         | Return from a subroutine |

### NOP – No Operation

NOP represents an instruction that does not perform a normal data-processing operation.

It can be useful for instruction-level testing and program control.

### HLT – Halt

HLT stops program execution.

It is commonly used when a program reaches its intended endpoint.

### RET – Return

RET is used to return from a subroutine to the calling program.

It is associated with subroutine execution using CALL.

## 4.4 F1 – Arithmetic and Logical Instructions

F1 contains instructions used for arithmetic calculations and bitwise logical operations.

### 4.4.1 Arithmetic Instructions

| Instruction | Operation      | Description                      |
| ----------- | -------------- | -------------------------------- |
| ADD         | Addition       | Adds values                      |
| SUB         | Subtraction    | Subtracts one value from another |
| MUL         | Multiplication | Multiplies values                |
| SLT         | Set Less Than  | Performs a less-than comparison  |

#### ADD – Addition

ADD performs addition using operand values.

Example:

```asm
ADD R1, R2, R3
```

Conceptually, with destination-first syntax:

R1 = R2 + R3

#### SUB – Subtraction

SUB performs subtraction.

Example:

```asm
SUB R1, R2, R3
```

Conceptually:

R1 = R2 - R3

#### MUL – Multiplication

MUL performs multiplication.

Example:

```asm
MUL R1, R2, R3
```

Conceptually:

R1 = R2 × R3

#### SLT – Set Less Than

SLT performs a comparison between two values.

It is used to determine whether one operand is less than another.

The exact result representation, signedness and operand ordering depend on the TARA16 implementation.

### 4.4.2 Logical Instructions

| Instruction | Operation   | Description                        |
| ----------- | ----------- | ---------------------------------- |
| AND         | Bitwise AND | Performs AND on corresponding bits |
| OR          | Bitwise OR  | Performs OR on corresponding bits  |
| XOR         | Bitwise XOR | Performs exclusive OR              |

#### AND

AND produces a 1 only when both corresponding input bits are 1.

Example:

```text
  1010
AND 1100
--------
  1000
```

#### OR

OR produces a 1 when at least one corresponding input bit is 1.

Example:

```text
  1010
OR  1100
--------
  1110
```

#### XOR

XOR produces a 1 when the corresponding input bits are different.

Example:

```text
  1010
XOR 1100
--------
  0110
```

## 4.5 F2 – Data Movement and Logical Instructions

F2 includes MOV and NOT.

| Instruction | Description                |
| ----------- | -------------------------- |
| MOV         | Moves a value              |
| NOT         | Performs bitwise inversion |

### MOV – Move

MOV transfers a value from one register or supported operand to another.

Example:

```asm
MOV R1, R2
```

Conceptually:

R1 = R2

### NOT – Bitwise NOT

NOT inverts the bits of its operand.

Example:

```text
Input:  10101010
Output: 01010101
```

The result width and operand syntax depend on the implementation.

## 4.6 F3 – Immediate and Shift Instructions

F3 contains instructions used for immediate-value operations and bit shifting.

| Instruction | Description         |
| ----------- | ------------------- |
| LIL         | Load Immediate Low  |
| LIH         | Load Immediate High |
| ADDI        | Add Immediate       |
| SHL         | Shift Left          |
| SHR         | Shift Right         |

### LIL – Load Immediate Low

LIL is used to load the lower portion of an immediate value.

### LIH – Load Immediate High

LIH is used to load the upper portion of an immediate value.

LIL and LIH can be useful when constructing larger constants using multiple instructions.

The exact immediate width, placement and combination rules must follow the TARA16 encoding.

### ADDI – Add Immediate

ADDI performs addition using an immediate value.

Conceptually:

```text
Destination = Source + Immediate
```

### SHL – Shift Left

SHL shifts bits towards the left.

Example:

```text
Before: 00000101
After:  00001010
```

For a logical left shift by one bit, the least significant bit is filled with zero.

### SHR – Shift Right

SHR shifts bits towards the right.

Example:

```text
Before: 00001010
After:  00000101
```

The exact shift behaviour, including signed or unsigned treatment, must be confirmed from the simulator.

## 4.7 F4 – Memory Instructions

F4 contains instructions used to transfer data between registers and memory.

| Instruction | Description |
| ----------- | ----------- |
| LDW         | Load Word   |
| STW         | Store Word  |
| LDB         | Load Byte   |
| STB         | Store Byte  |

### LDW – Load Word

LDW reads a word from a memory location and loads it into a register.

Conceptually:

```text
Register = Memory[Address]
```

### STW – Store Word

STW writes a word from a register into a memory location.

Conceptually:

```text
Memory[Address] = Register
```

### LDB – Load Byte

LDB reads a byte from memory.

### STB – Store Byte

STB writes a byte into memory.

### Importance of Memory Instructions

Memory instructions are useful for:

* Storing application data.
* Retrieving previously stored values.
* Managing variables.
* Accessing arrays and data structures.
* Supporting game and clock applications.

## 4.8 F5 – Conditional Branch Instructions

F5 contains conditional branch instructions.

| Instruction | Description        |
| ----------- | ------------------ |
| BZ          | Branch if Zero     |
| BN          | Branch if Negative |

### BZ – Branch if Zero

BZ changes the program execution sequence when its specified zero condition is satisfied.

It is useful in:

* Conditional statements.
* Loop termination.
* Zero-value checking.
* Decision-making logic.

### BN – Branch if Negative

BN performs conditional branching based on a negative condition.

It can be useful when implementing comparisons and decision-making operations.

The exact condition source, offset calculation and branch target encoding are defined by the instruction implementation.

## 4.9 F6 – Jump and Subroutine Instructions

F6 contains instructions used for changing the program execution sequence and calling subroutines.

| Instruction | Description        |
| ----------- | ------------------ |
| JMP         | Unconditional Jump |
| CALL        | Call Subroutine    |

### JMP – Unconditional Jump

JMP transfers program execution to another location.

It is useful for:

* Implementing loops.
* Repeating operations.
* Skipping sections of code.
* Transferring control to another program location.

### CALL – Call Subroutine

CALL transfers execution to a subroutine.

It is useful for dividing a large program into smaller reusable sections.

A subroutine can perform a particular task and return control to its caller using RET.

## 4.10 F7 – Stack Instructions

F7 contains instructions used for stack-related operations.

| Instruction | Description                   |
| ----------- | ----------------------------- |
| PUSH        | Push a value onto the stack   |
| POP         | Remove a value from the stack |

### PUSH

PUSH places a value onto the stack.

It can be used to preserve temporary values during program execution.

### POP

POP retrieves a value from the stack.

It is commonly used to restore previously saved values.

### Stack Applications

Stack operations are useful for:

* Saving temporary data.
* Subroutine support.
* Preserving values.
* Managing nested operations.

The exact stack pointer, stack direction and memory behaviour must be confirmed from the simulator implementation.

## 4.11 Complete TARA16 Instruction Summary

| Format | Instruction | Category           |
| ------ | ----------- | ------------------ |
| F0     | NOP         | Program control    |
| F0     | HLT         | Program control    |
| F0     | RET         | Subroutine control |
| F1     | ADD         | Arithmetic         |
| F1     | SUB         | Arithmetic         |
| F1     | MUL         | Arithmetic         |
| F1     | AND         | Logical            |
| F1     | OR          | Logical            |
| F1     | XOR         | Logical            |
| F1     | SLT         | Comparison         |
| F2     | MOV         | Data movement      |
| F2     | NOT         | Logical            |
| F3     | LIL         | Immediate          |
| F3     | LIH         | Immediate          |
| F3     | ADDI        | Arithmetic         |
| F3     | SHL         | Shift              |
| F3     | SHR         | Shift              |
| F4     | LDW         | Memory             |
| F4     | STW         | Memory             |
| F4     | LDB         | Memory             |
| F4     | STB         | Memory             |
| F5     | BZ          | Conditional branch |
| F5     | BN          | Conditional branch |
| F6     | JMP         | Jump               |
| F6     | CALL        | Subroutine control |
| F7     | PUSH        | Stack              |
| F7     | POP         | Stack              |

## 4.12 Importance of the Instruction Set in Application Development

The TARA16 instruction set provides the basic operations needed to construct assembly-language programs.

### Game Development

Instructions can be combined to implement:

* Player movement.
* Position calculations.
* Collision detection.
* Score calculations.
* Conditional decisions.
* Game loops.
* Display updates.

### Digital Clock

Instructions can be used for:

* Counting time values.
* Updating counters.
* Performing arithmetic.
* Checking time conditions.
* Updating display information.

### Analog Clock

Instructions can support:

* Coordinate calculations.
* Clock-hand positioning.
* Repeated display updates.
* Arithmetic operations.
* Program control.

These applications demonstrate how individual instructions can be combined to build larger programs.

## 4.13 Chapter Summary

TARA16 provides instructions for arithmetic, logical operations, data movement, immediate values, memory access, conditional branching, jumps, subroutines and stack operations.

Its instructions are organized into eight formats, F0–F7.

Understanding the instruction set is essential before studying instruction encoding and writing assembly-language programs.

## 4.14 Next Chapter

**PART 5: TARA16 Instruction Formats and Binary Encoding**

The next chapter will explain:

* The 16-bit instruction structure.
* Opcode representation.
* F0–F7 instruction formats.
* Operand fields.
* Register encoding.
* Immediate values.
* Binary-to-assembly conversion.
* Assembly-to-machine-code conversion.
