# Chapter 2: TARA ISA Architecture

## 2.1 Processor Architecture
## what is the processor Architecture ?

Processor architecture describes how a processor is organized and how it executes instructions.

It defines the relationship between the instruction set, registers, memory, data processing operations and program execution.

An Instruction Set Architecture (ISA) specifies the operations available to software. The processor implementation or simulator defines how those operations are carried out.

### TARA16 Architecture

TARA16 is the custom ISA explored in this project. Its instruction set is used to develop assembly-language applications, including games and clock programs.

The architecture documentation focuses on:

- Instruction representation and decoding.
- Register organization.
- Arithmetic and logical operations.
- Memory access.
- Branching and program control.
- Instruction execution.

The distinction between the ISA and its Python-based simulator is important: an ISA describes the software-visible instruction behaviour, while the simulator implements that behaviour.
## 2.2 CPU Organization
## 2.2 CPU Organization

CPU organization explains the main elements involved in instruction execution.

In the TARA16 software execution environment, the important state elements to study include:

- **Program Counter (PC):** Tracks the position of program execution.
- **Registers:** Hold values used by instructions.
- **Memory:** Stores program instructions and/or data, according to the implementation.
- **Instruction Decoder:** Identifies the operation represented by an instruction.
- **Execution Logic:** Performs the operation requested by the instruction.

The exact internal organization and interaction of these elements will be described using the TARA16 simulator implementation.
## 2.3 Datapath Architecture
### What is a Datapath?

A datapath is the part of a processor or execution system responsible for handling data during instruction execution.

It describes how data is selected, transferred, processed and stored.

In a typical processor, the datapath may involve:

1. Registers – Store operands and intermediate results.
2. ALU – Performs arithmetic and logical operations.
3. Data paths – Transfer values between components.
4. Memory interface – Supports data access.
5. Result selection – Determines where operation results are written.

### Datapath Operations in TARA16

TARA16 assembly programs use instructions to perform different data-processing operations.

For example:

- ADD performs addition.
- SUB performs subtraction.
- AND performs a bitwise AND operation.
- OR performs a bitwise OR operation.
- XOR performs a bitwise XOR operation.
- MOV transfers data.

These instructions demonstrate how values are processed and manipulated during program execution.

The exact datapath implementation will be described using the simulator source code.
## 2.4 Control Unit
   ### What is a Control Unit?

The control unit coordinates instruction execution.

Its main responsibility is to determine which operation must be performed based on the instruction being executed.

In a processor, control logic typically performs the following tasks:

1. Identifies the instruction.
2. Determines the operation.
3. Selects the required operands.
4. Coordinates the execution operation.
5. Controls updates to registers and memory.
6. Determines the next program execution address.

### Instruction Decoding in TARA16

TARA16 instructions are organized into different instruction formats.

The opcode identifies the operation represented by an instruction.

The execution environment interprets the instruction and performs the corresponding operation.

For example:

- ADD requests an addition operation.
- LDW requests a word-loading operation.
- JMP changes the program execution sequence.
- HLT stops program execution.

The actual decoding mechanism and control logic will be examined from the TARA simulator implementation.
## 2.5 Arithmetic Logic Unit (ALU)
### What is an ALU?

The Arithmetic Logic Unit (ALU) is a component commonly used in processor datapaths to perform arithmetic and logical operations.

Arithmetic operations include:
- Addition
- Subtraction
- Multiplication

Logical operations include:
- AND
- OR
- XOR
- NOT

### ALU Operations in TARA16

The TARA16 instruction set includes several arithmetic and logical instructions.

| Instruction | Operation |
|---|---|
| ADD | Addition |
| SUB | Subtraction |
| MUL | Multiplication |
| AND | Bitwise AND |
| OR | Bitwise OR |
| XOR | Bitwise XOR |
| NOT | Bitwise NOT |
| SLT | Set Less Than |
| SHL | Shift Left |
| SHR | Shift Right |

### Example

Consider the following conceptual assembly operations:

```asm
ADD R1, R2, R3
SUB R4, R5, R6
AND R1, R2, R3
## 2.6 Program Counter
### What is a Program Counter?

The Program Counter (PC) is a special register or state variable that identifies the current instruction position in a program.

It helps maintain the sequence of instruction execution.

### Functions of the Program Counter

1. Identifies the current instruction location.
2. Advances execution to the next instruction.
3. Supports changes in program flow.
4. Supports conditional and unconditional branching.
5. Helps control subroutine execution.

### Program Counter in TARA16

The TARA16 execution environment uses a program counter to track program execution.

Instructions such as JMP and CALL can change the normal execution sequence.

Conditional branch instructions such as BZ and BN can also affect program flow depending on their conditions.

The exact PC increment and address calculation rules depend on the simulator implementation.
## 2.7 Instruction Register
  ### What is an Instruction Register?

In a conventional processor, an Instruction Register (IR) temporarily holds the instruction currently being decoded or executed.

It allows the processor's control logic to interpret the instruction and determine the required operation.

### Role in Instruction Processing

A typical instruction-processing sequence is:

1. Obtain an instruction from program memory.
2. Make the instruction available to the decoding logic.
3. Identify its opcode and operands.
4. Perform the requested operation.

### Instruction Handling in TARA16

TARA16 uses encoded instructions that are interpreted by its execution environment.

The instruction decoder identifies the operation and its operands.

Whether the simulator uses a separate instruction-register variable is an implementation detail that must be verified from its source code.
## 2.8 Memory Interface
### What is a Memory Interface?

A memory interface provides a way for a processor or execution environment to access stored instructions and data.

Memory operations allow programs to read values from memory and write values into memory.

### Memory Operations in TARA16

TARA16 includes the following memory instructions:

| Instruction | Description |
|---|---|
| LDW | Load a word from memory |
| STW | Store a word in memory |
| LDB | Load a byte from memory |
| STB | Store a byte in memory |

### Load Operation

A load instruction reads data from a memory location and transfers it into a register.

Conceptual example:

```asm
LDW R1, address
## 2.9 Processor Execution Cycle
### What is an Instruction Execution Cycle?

An instruction execution cycle describes the steps involved in processing an instruction.

A conventional processor is commonly explained using the following stages:

1. Fetch
2. Decode
3. Execute
4. Memory Access
5. Write Back

### 1. Fetch

The execution environment obtains the instruction associated with the current program counter.

### 2. Decode

The instruction is interpreted to identify its operation and operands.

### 3. Execute

The required operation is performed.

For example:
- ADD performs addition.
- SUB performs subtraction.
- AND performs a logical operation.
- JMP changes program flow.

### 4. Memory Access

For instructions that access memory, the required data is read or written.

### 5. Write Back

When an instruction produces a register result, the result is written to the destination register.

### TARA16 Instruction Execution

The TARA16 Python simulator executes encoded instructions and updates the program state.

The five stages above provide a conceptual explanation of instruction processing. They should not be interpreted as five separate hardware pipeline stages in TARA16.

The actual execution sequence will be documented using the simulator source code.

### Example: Addition

Consider a conceptual addition operation:

```asm
ADD R1, R2, R3
