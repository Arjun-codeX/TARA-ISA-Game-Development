# PART 3: TARA16 REGISTER ORGANIZATION

## 3.1 Introduction to Registers

A register is a small storage location used by a processor or its execution environment to hold data during program execution.

Registers are important because instructions frequently need to access values, perform calculations and store intermediate results.

For example, when a program performs addition, it reads two operand values, calculates their sum and stores the result.

### Why Are Registers Important?

Registers are used for:

* Storing input values.
* Holding operands for arithmetic operations.
* Storing intermediate calculation results.
* Supporting logical operations.
* Holding values used in memory operations.
* Supporting program execution.

## 3.2 TARA16 General-Purpose Registers

TARA16 provides eight general-purpose registers.

| Register | Register Number | Binary Identifier |
| -------- | --------------: | ----------------- |
| R0       |               0 | 000               |
| R1       |               1 | 001               |
| R2       |               2 | 010               |
| R3       |               3 | 011               |
| R4       |               4 | 100               |
| R5       |               5 | 101               |
| R6       |               6 | 110               |
| R7       |               7 | 111               |

Eight registers require three bits for register identification because:

2³ = 8

Therefore, a three-bit identifier can represent all eight registers.

The actual bit positions used to encode register operands depend on the instruction format.

## 3.3 General-Purpose Register Usage

General-purpose registers hold values required by different instructions.

Their possible uses include:

### 1. Operand Storage

Registers hold values that are used as inputs to arithmetic and logical operations.

### 2. Result Storage

An instruction can store its calculated result in a destination register.

### 3. Temporary Data Storage

Registers can hold intermediate values while a program performs multiple operations.

### 4. Memory Operations

Registers can provide data for store instructions or receive data from load instructions.

### 5. Program Logic

Registers can hold values used in comparisons, loops and conditional operations.

**Important:** Unless the TARA16 implementation explicitly defines fixed register roles, R0–R7 should be treated as general-purpose registers rather than assigning special functions to individual registers.

## 3.4 Register-to-Register Operations

Register-to-register operations use values stored in registers.

For example, consider the conceptual operation:

```text
ADD R1, R2, R3
```

Assuming the assembler uses destination-first operand ordering, the operation means:

```text
R1 = R2 + R3
```

Suppose:

```text
R2 = 10
R3 = 20
```

After the addition:

```text
R1 = 30
```

This demonstrates how registers provide operands and store calculation results.

The exact assembly syntax must follow the TARA assembler implementation.

## 3.5 Register Operations

TARA16 provides instructions that operate on register values.

Some important instruction categories are:

| Category             | Example Instructions | Purpose                    |
| -------------------- | -------------------- | -------------------------- |
| Arithmetic           | ADD, SUB, MUL        | Perform calculations       |
| Logical              | AND, OR, XOR, NOT    | Perform bitwise operations |
| Data movement        | MOV                  | Transfer values            |
| Immediate operations | ADDI, LIL, LIH       | Work with immediate values |
| Shift operations     | SHL, SHR             | Shift bits                 |
| Memory operations    | LDW, LDB             | Load data into registers   |

These instructions demonstrate how registers participate in program execution.

## 3.6 Register Values During Execution

Register values can change as instructions execute.

Consider the following example:

| Step    | Operation           |  R1 | R2 | R3 |
| ------- | ------------------- | --: | -: | -: |
| Initial | Initial values      |   0 | 10 | 20 |
| 1       | Addition            |  30 | 10 | 20 |
| 2       | Subtraction into R1 | -10 | 10 | 20 |

The table illustrates how different instructions can update a destination register.

The actual numerical representation, arithmetic width and overflow behaviour depend on the TARA16 implementation.

## 3.7 Registers and Memory

Registers and memory serve different purposes.

| Feature    | Registers                             | Memory                                   |
| ---------- | ------------------------------------- | ---------------------------------------- |
| Purpose    | Hold values used by instructions      | Store program data and instructions      |
| Access     | Through register operands             | Through memory instructions              |
| Capacity   | Eight general-purpose registers       | 2 KB in the current TARA16 specification |
| Operations | Arithmetic, logical and data movement | Load and store                           |

TARA16 includes the following memory instructions:

* LDW – Load Word
* STW – Store Word
* LDB – Load Byte
* STB – Store Byte

Load instructions transfer values from memory into registers, while store instructions transfer register values into memory.

The exact word width, byte ordering and addressing rules are explained in Part 8.

## 3.8 Program Counter and Registers

The Program Counter (PC) is an important part of program execution.

Unlike general-purpose registers, the PC tracks the instruction execution position.

Its responsibilities include:

* Tracking the current instruction address.
* Supporting sequential program execution.
* Supporting jumps and branches.
* Supporting subroutine control.

TARA16 includes instructions such as JMP and CALL that affect program flow.

The PC is discussed separately because its function differs from ordinary data registers.

## 3.9 Register Usage in Assembly Programs

Registers are essential when developing applications using assembly language.

Consider a simple calculation:

```text
Load or prepare first operand
Load or prepare second operand
Add the operands
Store the result
```

The registers hold the operands and the result during these operations.

In a game application, registers can also be used to hold:

* Player coordinates.
* Object positions.
* Movement values.
* Counters.
* Collision-related values.
* Temporary calculations.

In clock applications, registers can hold:

* Time values.
* Counter values.
* Display positions.
* Calculated coordinates.
* Values used for updating clock hands.

These are application-level examples. The actual register assignments depend on each program.

## 3.10 Register Organization Summary

The TARA16 architecture provides eight general-purpose registers, R0–R7.

Each register can be identified using three bits.

Registers support arithmetic, logical, data movement and memory-related instructions.

The Program Counter maintains program execution position and is conceptually different from the general-purpose registers.

Understanding register organization is important for reading assembly programs and understanding how instructions manipulate data.

## 3.11 What Comes Next?

The next chapter covers the complete TARA16 instruction set, including:

* Arithmetic instructions.
* Logical instructions.
* Data movement instructions.
* Immediate instructions.
* Shift instructions.
* Memory instructions.
* Conditional branches.
* Jump and subroutine instructions.
* Stack operations.
* Processor control instructions.
