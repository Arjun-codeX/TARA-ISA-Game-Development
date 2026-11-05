# Chapter 6: TARA Assembly Language Programming

## 6.1 Introduction to Assembly Language
## 6.2 Assembly Syntax
## 6.3 Registers and Operands
## 6.4 Immediate Values
## 6.5 Labels
## 6.6 Arithmetic Programming
## 6.7 Logical Programming
## 6.8 Loops and Conditional Statements
## 6.9 Branching and Jumping
## 6.10 Subroutines
## 6.11 Stack Operations
## 6.12 Complete Assembly Programs

# PART 6: TARA16 ASSEMBLY LANGUAGE

## 6.1 Introduction to Assembly Language

Assembly language is a low-level programming language that allows programmers to write instructions using human-readable mnemonics instead of binary machine code.

Each assembly instruction represents an operation supported by an Instruction Set Architecture (ISA).

For example, an addition operation can be represented using the mnemonic `ADD` instead of writing its binary encoding directly.

Assembly language provides greater visibility into how a program performs calculations, accesses memory and controls execution.

## 6.2 Assembly Language and Machine Code

A computer execution environment ultimately works with machine-level instructions.

Assembly language provides a readable representation of those instructions.

The general conversion process is:

```text
Assembly Source Code
         |
         v
      Assembler
         |
         v
   Machine Code
         |
         v
   CPU Simulator
         |
         v
   Program Execution
         |
         v
       Output
```

### Assembly Source Code

The programmer writes instructions using supported mnemonics and operands.

### Assembler

The assembler converts assembly instructions into their encoded machine representation.

### Machine Code

Machine code contains the encoded instructions understood by the execution environment.

### CPU Simulator

The simulator interprets and executes the program according to the TARA16 instruction definitions.

## 6.3 Structure of an Assembly Instruction

An assembly instruction generally contains:

1. An instruction mnemonic.
2. One or more operands, depending on the instruction.
3. Optional comments.

A conceptual example is:

```asm
ADD R1, R2, R3
```

Here:

* `ADD` identifies the operation.
* `R1`, `R2` and `R3` identify register operands.

If the assembler uses destination-first ordering, the operation represents:

```text
R1 = R2 + R3
```

The exact operand order and syntax must follow the TARA assembler.

## 6.4 Instruction Mnemonics

A mnemonic is a short name representing an instruction.

Examples from TARA16 include:

| Mnemonic | Meaning            |
| -------- | ------------------ |
| ADD      | Addition           |
| SUB      | Subtraction        |
| MUL      | Multiplication     |
| AND      | Bitwise AND        |
| OR       | Bitwise OR         |
| XOR      | Bitwise XOR        |
| NOT      | Bitwise NOT        |
| MOV      | Data movement      |
| ADDI     | Add immediate      |
| LDW      | Load word          |
| STW      | Store word         |
| JMP      | Unconditional jump |
| BZ       | Branch if zero     |
| BN       | Branch if negative |
| HLT      | Halt execution     |

Mnemonics make assembly programs easier to read and understand.

## 6.5 Register Operands

TARA16 provides eight general-purpose registers:

```text
R0, R1, R2, R3, R4, R5, R6, R7
```

Registers are used to hold values during program execution.

Common register-related operations include:

* Reading values from registers.
* Performing arithmetic using register operands.
* Moving values between registers.
* Loading data from memory.
* Storing data into memory.

Example using conceptual destination-first syntax:

```asm
ADD R1, R2, R3
MOV R4, R1
```

The first instruction calculates a result, and the second transfers a value.

## 6.6 Immediate Values

An immediate value is a constant represented directly within an instruction.

Immediate operands are useful when a program needs to work with fixed values.

TARA16 includes instructions such as:

* LIL – Load Immediate Low.
* LIH – Load Immediate High.
* ADDI – Add Immediate.

These instructions support immediate-value operations.

The exact constant representation, immediate width and combination rules depend on the TARA16 instruction encoding.

## 6.7 Arithmetic Operations in Assembly

Arithmetic instructions perform mathematical calculations.

TARA16 includes:

| Instruction | Operation                  |
| ----------- | -------------------------- |
| ADD         | Addition                   |
| SUB         | Subtraction                |
| MUL         | Multiplication             |
| ADDI        | Addition with an immediate |
| SLT         | Less-than comparison       |

### Addition

Conceptual example:

```asm
ADD R1, R2, R3
```

### Subtraction

```asm
SUB R1, R2, R3
```

### Multiplication

```asm
MUL R1, R2, R3
```

Arithmetic instructions are useful for calculations in games, clocks and other applications.

## 6.8 Logical Operations in Assembly

Logical instructions operate on individual bits.

TARA16 provides:

* AND
* OR
* XOR
* NOT

These instructions can be used for bit manipulation, masking and logical calculations.

Example:

```text
Input A: 1010
Input B: 1100

AND:     1000
OR:      1110
XOR:     0110
```

## 6.9 Shift Operations

Shift instructions move bits within a value.

TARA16 provides:

| Instruction | Description |
| ----------- | ----------- |
| SHL         | Shift left  |
| SHR         | Shift right |

Example of a one-bit logical left shift:

```text
Before: 00000101
After:  00001010
```

Example of a one-bit logical right shift:

```text
Before: 00001010
After:  00000101
```

Shift operations are useful in bit manipulation and certain arithmetic operations.

## 6.10 Memory Operations in Assembly

Memory instructions allow a program to read and write data.

TARA16 provides:

| Instruction | Purpose      |
| ----------- | ------------ |
| LDW         | Load a word  |
| STW         | Store a word |
| LDB         | Load a byte  |
| STB         | Store a byte |

### Load Operation

A load operation transfers data from memory into a register.

### Store Operation

A store operation transfers data from a register into memory.

Memory instructions are important when applications need to preserve and retrieve values.

The exact addressing syntax must be taken from the TARA assembler.

## 6.11 Branching and Decision Making

Branch instructions allow a program to change its normal execution sequence.

TARA16 provides:

* BZ – Branch if Zero.
* BN – Branch if Negative.

These instructions are useful for implementing decisions and loops.

A conceptual decision-making process is:

```text
       Check Condition
              |
        +-----+-----+
        |           |
      True        False
        |           |
        v           v
   Branch to     Continue
   Target        Execution
```

The branch condition and target-address syntax depend on the TARA instruction definition.

## 6.12 Jump Instructions

JMP performs an unconditional jump to another program location.

It is useful for:

* Repeating instructions.
* Implementing loops.
* Skipping program sections.
* Transferring control to another location.

A program can use jumps to organize its execution flow.

## 6.13 Subroutines

A subroutine is a reusable section of a program that performs a particular task.

TARA16 provides:

* CALL – Call a subroutine.
* RET – Return from a subroutine.

A conceptual subroutine flow is:

```text
       Main Program
            |
            v
       CALL Function
            |
            v
      Execute Function
            |
            v
       RET Instruction
            |
            v
      Continue Main Program
```

Subroutines help divide large programs into smaller, manageable sections.

## 6.14 Stack Operations

TARA16 includes two stack-related instructions:

* PUSH – Push a value onto the stack.
* POP – Retrieve a value from the stack.

Stack operations are useful for temporary data storage and subroutine support.

The stack pointer, stack direction and exact memory behaviour depend on the implementation.

## 6.15 Program Control Instructions

TARA16 provides the following basic control instructions:

| Instruction | Function                 |
| ----------- | ------------------------ |
| NOP         | No operation             |
| HLT         | Stop program execution   |
| RET         | Return from a subroutine |

These instructions help control program execution.

## 6.16 Assembly Programming Workflow

Developing a TARA16 assembly application involves several stages.

### Step 1: Understand the Problem

Identify the functionality required by the application.

For example, a game may require player movement, object positioning and collision detection.

### Step 2: Develop the Algorithm

Break the application into smaller operations.

### Step 3: Write Assembly Instructions

Select the required TARA16 instructions to implement the algorithm.

### Step 4: Assemble the Program

Convert the assembly source into the machine-code representation required by the simulator.

### Step 5: Execute the Program

Load and execute the generated program using the TARA16 execution environment.

### Step 6: Test and Debug

Observe program behaviour, identify errors and correct the assembly implementation.

## 6.17 Assembly Language in TARA Applications

TARA16 assembly instructions can be combined to create practical applications.

### Eleven Towers

Assembly programming concepts can be applied to:

* Game initialization.
* Player input.
* Tower operations.
* Game-state management.
* Score calculation.
* Display updates.

### Brick Breaker

Assembly instructions can support:

* Ball movement.
* Paddle movement.
* Collision detection.
* Score updates.
* Game-over conditions.

### Digital Clock

Assembly programming can implement:

* Time counters.
* Counter updates.
* Time calculations.
* Display updates.

### Analog Clock

Assembly instructions can support:

* Clock-hand position calculations.
* Coordinate calculations.
* Repeated display updates.
* Clock-hand movement.

The actual algorithms and instruction sequences will be explained in the individual project chapters.

## 6.18 Common Assembly Programming Errors

Some common errors encountered during assembly development include:

### Invalid Instruction

Using an instruction that is not supported by the ISA.

### Invalid Register

Using a register name or register identifier that is not supported.

### Incorrect Operand Count

Providing too many or too few operands for an instruction.

### Incorrect Immediate Value

Providing a constant outside the supported range.

### Invalid Branch Target

Using an incorrect branch or jump destination.

### Incorrect Memory Address

Accessing an invalid or unsupported memory location.

### Incorrect Instruction Encoding

Generating machine code that does not match the instruction format.

Understanding these errors helps developers write reliable assembly programs.

## 6.19 Chapter Summary

TARA16 assembly language provides a readable way to write programs using the supported instruction set.

It uses instruction mnemonics, registers, immediate values and control-flow operations to implement application logic.

Assembly programs are converted into machine code and executed using the TARA16 execution environment.

Understanding assembly language is essential for developing and debugging applications using TARA16.

## 6.20 Next Chapter

PART 7: TARA16 Instruction Execution

The next chapter explains how instructions are interpreted and executed, including instruction fetching, decoding, operand handling, operation execution and CPU-state updates.
