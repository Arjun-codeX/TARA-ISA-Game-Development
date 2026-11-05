# Chapter 9: TARA ISA vs RISC-V

## 9.1 Introduction to RISC-V
## 9.2 RISC-V Architecture
## 9.3 RISC-V Instruction Formats
## 9.4 Architecture Comparison
## 9.5 Register Organization Comparison
## 9.6 Instruction Encoding Comparison
## 9.7 Memory Addressing Comparison
## 9.8 Instruction Execution Comparison
## 9.9 Advantages and Limitations
## 9.10 Summary


# Chapter 9: TARA16 ISA vs RISC-V

## 9.1 Introduction

An Instruction Set Architecture (ISA) defines the instructions that a processor understands and executes. It acts as an interface between software and the processor.

Different processors can use different ISAs. Two examples are:

1. **TARA16 ISA** – A custom instruction set architecture developed as part of the TARA project.
2. **RISC-V ISA** – An open and standardized instruction set architecture used in processor research, education, embedded systems, and commercial applications.

Both architectures provide instructions for arithmetic, logical operations, memory access, and program control. However, they differ in their design, instruction encoding, register organization, standardization, and development ecosystem.

This chapter compares the two architectures to understand their features and applications.

## 9.2 What Is TARA16?

TARA16 is a custom 16-bit instruction set architecture.

The currently recorded TARA16 design includes:

* 16-bit instructions.
* A 5-bit opcode field.
* Eight general-purpose registers, R0 to R7.
* Arithmetic and logical instructions.
* Memory access instructions.
* Branch and jump instructions.
* Stack-related instructions.
* A Python-based execution environment.

The instruction set includes operations such as ADD, SUB, MOV, LDW, STW, JMP, CALL, and RET.

TARA16 provides a learning environment for understanding how instructions are represented and executed.

**Note:** The details above reflect the TARA16 specifications currently recorded in this project. Exact instruction field positions, operand encoding, and execution rules should be confirmed against the actual TARA source code.

## 9.3 What Is RISC-V?

RISC-V is an open-standard Instruction Set Architecture based on Reduced Instruction Set Computer (RISC) principles.

It was developed at the University of California, Berkeley. Its instruction set specification is maintained through an open standard.

RISC-V is designed to support different processor implementations, from small embedded controllers to more powerful processors.

Important characteristics include:

* Open and standardized ISA.
* Modular instruction set design.
* Multiple architecture widths.
* General-purpose registers.
* Load-store architecture.
* Standard instruction formats.
* Support for optional extensions.

RISC-V is not a single processor. It is an ISA specification that different organizations and developers can implement in hardware or software.

### 9.3.1 RISC-V Architecture Variants

Some commonly used RISC-V variants are:

| Variant | Description                                                      |
| ------- | ---------------------------------------------------------------- |
| RV32I   | 32-bit base integer instruction set                              |
| RV64I   | 64-bit base integer instruction set                              |
| RV128I  | 128-bit base integer instruction set specification               |
| RV32IM  | RV32I with multiplication and division extension                 |
| RV32IMC | RV32I with multiplication, division, and compressed instructions |

For this chapter, RV32I is used as the primary comparison because it is a common starting point for learning RISC-V processor design.

## 9.4 Basic Architectural Comparison

| Feature                   | TARA16                            | RISC-V RV32I                                                |
| ------------------------- | --------------------------------- | ----------------------------------------------------------- |
| Architecture type         | Custom ISA                        | Open-standard ISA                                           |
| Design approach           | Project-specific                  | Standardized RISC architecture                              |
| Base instruction width    | 16 bits                           | 32 bits                                                     |
| General-purpose registers | 8 registers                       | 32 registers                                                |
| Register names            | R0–R7                             | x0–x31                                                      |
| Opcode width              | 5 bits, as currently recorded     | Varies by instruction format                                |
| Instruction formats       | F0–F7, as currently recorded      | R, I, S, B, U, J                                            |
| Memory model              | Project-specific                  | Load-store architecture                                     |
| Arithmetic operations     | Supported                         | Supported                                                   |
| Logical operations        | Supported                         | Supported                                                   |
| Branch operations         | Supported                         | Supported                                                   |
| Jump operations           | Supported                         | Supported                                                   |
| Stack operations          | PUSH and POP are recorded         | Normally implemented using memory and register instructions |
| Standardization           | Custom project                    | Open standard                                               |
| Typical learning use      | Custom ISA and execution concepts | Standard processor architecture and implementation          |

The table provides a high-level comparison. The exact TARA16 implementation details must be checked against its source.

## 9.5 Register Organization

Registers are small storage locations used by a processor to hold temporary data, addresses, and calculation results.

### 9.5.1 TARA16 Registers

TARA16 currently uses eight general-purpose registers:

* R0
* R1
* R2
* R3
* R4
* R5
* R6
* R7

Each register is identified using a 3-bit register ID.

| Register | Binary ID |
| -------- | --------- |
| R0       | 000       |
| R1       | 001       |
| R2       | 010       |
| R3       | 011       |
| R4       | 100       |
| R5       | 101       |
| R6       | 110       |
| R7       | 111       |

These registers are used to store operands and calculation results.

### 9.5.2 RISC-V Registers

RV32I contains 32 integer registers:

* x0
* x1
* x2
* ...
* x31

Each register is 32 bits wide.

| Register | Common ABI name | Purpose                              |
| -------- | --------------- | ------------------------------------ |
| x0       | zero            | Always contains zero                 |
| x1       | ra              | Return address                       |
| x2       | sp              | Stack pointer                        |
| x3       | gp              | Global pointer                       |
| x4       | tp              | Thread pointer                       |
| x5–x7    | t0–t2           | Temporary registers                  |
| x8       | s0/fp           | Saved register/frame pointer         |
| x9       | s1              | Saved register                       |
| x10–x11  | a0–a1           | Function arguments and return values |
| x12–x17  | a2–a7           | Function arguments                   |
| x18–x27  | s2–s11          | Saved registers                      |
| x28–x31  | t3–t6           | Temporary registers                  |

The RISC-V register x0 is hardwired to zero. Any attempt to write a different value to x0 does not change its value.

### 9.5.3 Register Comparison

| Feature                     | TARA16                              | RISC-V RV32I                 |
| --------------------------- | ----------------------------------- | ---------------------------- |
| Number of integer registers | 8                                   | 32                           |
| Register width              | To be confirmed from implementation | 32 bits                      |
| Register naming             | R0–R7                               | x0–x31                       |
| Register ID width           | 3 bits                              | 5 bits                       |
| Fixed zero register         | Not assumed                         | x0                           |
| ABI register conventions    | Project-specific                    | Standardized ABI conventions |

RISC-V provides more general-purpose registers than the currently recorded TARA16 design.

## 9.6 Instruction Width and Encoding

Instruction encoding determines how an instruction is represented in binary form.

### 9.6.1 TARA16 Instruction Encoding

TARA16 uses a 16-bit instruction according to the currently recorded specification.

A 5-bit opcode identifies the operation.

For example, an instruction may represent an arithmetic operation, a memory operation, or a control-flow operation.

The remaining instruction bits are used for other information according to the applicable TARA instruction format.

TARA16 currently records eight instruction formats, named F0 through F7.

The exact positions and widths of individual operand fields must be verified using the assembler or instruction encoding implementation.

### 9.6.2 RISC-V Instruction Encoding

RV32I uses fixed-length 32-bit base instructions.

The standard base instruction formats are:

| Format | General purpose                 |
| ------ | ------------------------------- |
| R-type | Register-to-register operations |
| I-type | Immediate operations and loads  |
| S-type | Store operations                |
| B-type | Conditional branches            |
| U-type | Upper immediate operations      |
| J-type | Jump operations                 |

The instruction format determines where the opcode, register identifiers, function fields, and immediate values are located.

For example, an R-type instruction contains:

* Opcode
* Destination register (rd)
* Source register 1 (rs1)
* Source register 2 (rs2)
* funct3
* funct7

### 9.6.3 Instruction Format Comparison

| Feature                    | TARA16              | RISC-V RV32I                                |
| -------------------------- | ------------------- | ------------------------------------------- |
| Instruction width          | 16 bits             | 32 bits                                     |
| Number of recorded formats | 8                   | 6 base formats                              |
| Format names               | F0–F7               | R, I, S, B, U, J                            |
| Opcode                     | 5 bits, as recorded | 7-bit opcode field in standard base formats |
| Register identifiers       | 3 bits              | 5 bits                                      |
| Immediate encoding         | Project-specific    | Defined by each instruction format          |

RISC-V also supports the optional compressed instruction extension (C), which provides 16-bit instruction encodings for selected operations. This is separate from the standard 32-bit RV32I base instruction encoding.

## 9.7 Arithmetic Instructions

Arithmetic instructions perform mathematical operations such as addition, subtraction, and multiplication.

### TARA16

The currently recorded TARA16 arithmetic instructions include:

| Instruction | Operation                  |
| ----------- | -------------------------- |
| ADD         | Addition                   |
| SUB         | Subtraction                |
| ADDI        | Addition with an immediate |
| MUL         | Multiplication             |

Illustrative operation:

```asm
ADD R1, R2, R3
```

Conceptually, this represents adding the values in R2 and R3 and storing the result in R1.

The exact operand order should be confirmed against the TARA assembler syntax.

### RISC-V

RV32I supports addition and subtraction through instructions such as:

```asm
add x5, x6, x7
sub x5, x6, x7
addi x5, x6, 10
```

Multiplication is not part of the RV32I base integer instruction set. It is provided by the M extension.

Example:

```asm
mul x5, x6, x7
```

This instruction is available when the M extension is implemented.

## 9.8 Logical Instructions

Logical instructions operate on individual bits.

They are useful for masking, setting, clearing, and modifying bits.

### TARA16

The currently recorded logical instructions include:

| Instruction | Operation          |
| ----------- | ------------------ |
| AND         | Bitwise AND        |
| OR          | Bitwise OR         |
| XOR         | Bitwise XOR        |
| NOT         | Bitwise complement |

### RISC-V

RV32I provides logical instructions such as:

| Instruction | Operation          |
| ----------- | ------------------ |
| AND         | Bitwise AND        |
| OR          | Bitwise OR         |
| XOR         | Bitwise XOR        |
| ANDI        | AND with immediate |
| ORI         | OR with immediate  |
| XORI        | XOR with immediate |

RISC-V also provides shift operations such as SLL, SRL, and SRA.

## 9.9 Memory Access Instructions

Memory is used to store instructions and data.

A processor generally uses registers for immediate calculations and memory instructions to transfer data between registers and memory.

### 9.9.1 TARA16 Memory Instructions

The currently recorded TARA16 memory instructions include:

| Instruction | Operation  |
| ----------- | ---------- |
| LDW         | Load word  |
| STW         | Store word |
| LDB         | Load byte  |
| STB         | Store byte |

These instructions provide word-level and byte-level memory access.

The exact word size, address alignment, byte ordering, and signedness rules must be confirmed from the TARA implementation.

### 9.9.2 RISC-V Memory Instructions

RV32I uses a load-store architecture.

Arithmetic and logical operations generally work on register values. Data is transferred between memory and registers using load and store instructions.

Common instructions include:

| Instruction | Operation                         |
| ----------- | --------------------------------- |
| LB          | Load byte with sign extension     |
| LBU         | Load byte with zero extension     |
| LH          | Load halfword with sign extension |
| LHU         | Load halfword with zero extension |
| LW          | Load word                         |
| SB          | Store byte                        |
| SH          | Store halfword                    |
| SW          | Store word                        |

Example:

```asm
lw x5, 0(x6)
sw x5, 4(x6)
```

The first instruction loads a 32-bit word from memory into x5. The second stores the value in x5 to the memory address calculated using x6 plus 4.

## 9.10 Branch and Jump Instructions

Branch and jump instructions change the normal sequence of program execution.

They are important for loops, conditions, and function calls.

### 9.10.1 TARA16

The currently recorded TARA16 control-flow instructions include:

| Instruction | Operation            |
| ----------- | -------------------- |
| BZ          | Branch if zero       |
| BN          | Branch if negative   |
| JMP         | Unconditional jump   |
| CALL        | Function call        |
| RET         | Return from function |

These instructions allow programs to implement conditional execution, loops, and subroutines.

### 9.10.2 RISC-V

RV32I provides conditional branch instructions such as:

| Instruction | Operation                                 |
| ----------- | ----------------------------------------- |
| BEQ         | Branch if equal                           |
| BNE         | Branch if not equal                       |
| BLT         | Branch if less than, signed               |
| BGE         | Branch if greater than or equal, signed   |
| BLTU        | Branch if less than, unsigned             |
| BGEU        | Branch if greater than or equal, unsigned |

For jumps, RISC-V provides:

* JAL – Jump and link.
* JALR – Jump and link register.

Example:

```asm
beq x5, x6, target
jal x1, function
```

The first instruction branches when x5 and x6 are equal. The second instruction jumps to a function and stores the return address in x1.

## 9.11 Stack Operations and Function Calls

A stack is a memory structure used to store temporary information, return addresses, and saved register values.

### TARA16

The currently recorded instruction set includes:

* PUSH
* POP
* CALL
* RET

These instructions provide stack-related and subroutine operations.

The exact stack pointer organization and direction of stack growth should be verified from the implementation.

### RISC-V

RV32I does not define dedicated PUSH and POP instructions in its base integer instruction set.

Instead, software uses normal load and store instructions with the stack pointer.

For example:

```asm
addi sp, sp, -4
sw ra, 0(sp)
```

These instructions reserve stack space and store the return address.

To restore the value:

```asm
lw ra, 0(sp)
addi sp, sp, 4
```

The RISC-V calling convention defines how registers and the stack are used when functions call other functions.

## 9.12 Development Tools and Execution Environment

An ISA can be studied and implemented using different software tools.

### 9.12.1 TARA16 Development Environment

The TARA project uses its own development and execution workflow.

The currently recorded environment includes:

* TARA assembly source files.
* A TARA assembler or conversion utility.
* A Python-based execution environment.
* TARA application programs.
* Debugging and execution output.

A typical conceptual workflow is:

```text
TARA Assembly Program
         |
         v
Assembler / Conversion Tool
         |
         v
Instruction Representation
         |
         v
TARA Execution Environment
         |
         v
Program Output
```

The exact file formats and conversion steps depend on the TARA project tools.

### 9.12.2 RISC-V Development Environment

RISC-V has a broad ecosystem of development and simulation tools.

Common tools include:

| Tool          | Purpose                         |
| ------------- | ------------------------------- |
| RISC-V GCC    | Compile C programs              |
| GNU Assembler | Assemble RISC-V assembly        |
| GNU Linker    | Link object files               |
| GNU Objdump   | Inspect machine instructions    |
| Spike         | RISC-V ISA simulator            |
| Verilator     | RTL simulation and verification |
| Yosys         | RTL synthesis                   |
| GTKWave       | Waveform viewing                |

A typical software development flow is:

```text
C Program
    |
    v
RISC-V Compiler
    |
    v
Assembly / Object Code
    |
    v
Linker
    |
    v
Executable Program
    |
    v
RISC-V Simulator or Processor
    |
    v
Program Execution
```

For hardware development, an RTL description can be simulated and synthesized using appropriate EDA tools.

## 9.13 Applications of Both Architectures

### TARA16 Applications

The TARA16 project includes applications that demonstrate how a custom ISA can execute different types of programs.

The applications developed in this repository are:

1. Eleven Towers Game
2. Brick Breaker Game
3. Digital Clock
4. Analog Clock

These applications demonstrate the use of arithmetic, logical, memory, and control-flow instructions.

### RISC-V Applications

RISC-V is used in several areas, including:

* Embedded systems.
* Microcontrollers.
* Computer architecture research.
* Educational processor design.
* Operating system development.
* Custom processor implementations.
* High-performance computing research.

Its open standard allows developers to design processors for different requirements.

## 9.14 Advantages and Limitations

### TARA16

**Advantages**

1. A smaller instruction set can make instruction-level learning easier.
2. Its custom design allows students to understand ISA development.
3. The 16-bit instruction structure provides a compact representation.
4. Its applications demonstrate how instructions can be used in complete programs.
5. It provides an opportunity to study assemblers and execution environments.

**Limitations**

1. It is a project-specific architecture rather than a widely adopted standard.
2. Its software ecosystem is smaller than that of RISC-V.
3. Compatibility with existing processor tools and software is limited.
4. Its implementation and instruction details depend on the project design.

### RISC-V

**Advantages**

1. It is based on an open standard.
2. It supports multiple architecture widths and extensions.
3. It has a large development and research ecosystem.
4. It supports hardware and software implementations.
5. It is suitable for education, research, and commercial processor development.

**Limitations**

1. Understanding the complete instruction set can take time.
2. Optional extensions can make implementations more complex.
3. Processor designers must carefully implement the required specification.
4. Hardware implementation requires knowledge of datapaths, control logic, verification, and timing.

## 9.15 Example: Adding Two Numbers

The following examples show the conceptual similarity between the two instruction sets.

### TARA16

Illustrative assembly:

```asm
LIL R1, 10
LIL R2, 20
ADD R3, R1, R2
```

Conceptually:

1. Load the value 10 into R1.
2. Load the value 20 into R2.
3. Add R1 and R2.
4. Store the result in R3.

The expected mathematical result is 30.

The exact immediate-loading syntax and operand order must match the TARA assembler implementation.

### RISC-V

```asm
addi x5, x0, 10
addi x6, x0, 20
add  x7, x5, x6
```

Explanation:

1. `addi x5, x0, 10` places 10 in x5.
2. `addi x6, x0, 20` places 20 in x6.
3. `add x7, x5, x6` adds the two values.
4. The result 30 is stored in x7.

Here, x0 always contains zero, so it can be used as the source register for loading an immediate value.

## 9.16 Important Differences to Remember

The main differences between TARA16 and RISC-V are:

1. TARA16 is a custom ISA, while RISC-V is an open standard.
2. TARA16 currently uses a recorded 16-bit instruction format, while RV32I uses 32-bit base instructions.
3. TARA16 currently records eight general-purpose registers, while RV32I provides 32 integer registers.
4. TARA16 uses project-specific instruction formats, while RISC-V defines standard instruction formats.
5. TARA16 records dedicated PUSH and POP instructions, while RV32I normally uses load and store instructions for stack operations.
6. RISC-V has a much larger software and hardware development ecosystem.
7. Both architectures support arithmetic, logical, memory, and control-flow operations.

## 9.17 Conclusion

TARA16 and RISC-V demonstrate two different approaches to instruction set architecture design.

TARA16 provides a project-specific environment for understanding instruction encoding, registers, assembly programming, and program execution.

RISC-V provides an open-standard architecture that supports a wide range of processor implementations and has an extensive development ecosystem.

Studying both architectures helps students understand the basic principles of processor design and the differences between developing a custom ISA and working with an established architecture.

The TARA16 project also demonstrates how a custom instruction set can be used to execute complete applications such as games and clock programs.
