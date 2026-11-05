# Chapter 7: How TARA ISA Executes Instructions

## 7.1 Instruction Fetch
## 7.2 Instruction Decode
## 7.3 Operand Selection
## 7.4 Instruction Execution
## 7.5 Memory Access
## 7.6 Register Writeback
## 7.7 Program Counter Update
## 7.8 Complete Instruction Execution Example
# PART 7: TARA16 INSTRUCTION EXECUTION

## 7.1 Introduction

Instruction execution is the process through which a processor or simulator performs the operations specified by machine instructions.

A program consists of multiple instructions. These instructions are processed in a sequence to perform the required tasks.

In TARA16, assembly instructions are converted into their encoded representation and executed using the TARA CPU simulator.

Understanding instruction execution helps explain how an assembly program changes register values, accesses memory and controls program flow.

## 7.2 Overview of Instruction Execution

A typical instruction-processing model consists of the following activities:

1. Instruction retrieval.
2. Instruction decoding.
3. Operand identification.
4. Operation execution.
5. Memory access, when required.
6. Register or memory update.
7. Program counter update.

These activities describe the general instruction-processing concept. They do not necessarily represent separate hardware pipeline stages in the TARA16 simulator.

## 7.3 Instruction Retrieval

Instruction retrieval is the process of obtaining the next instruction for execution.

The Program Counter (PC) identifies the instruction position.

The execution environment uses the program counter to determine which instruction should be processed.

After an instruction is processed, the program counter is updated according to the instruction's execution behaviour.

For ordinary sequential execution, the next instruction is selected.

For jump and branch instructions, execution may continue from a different location.

## 7.4 Instruction Decoding

Instruction decoding identifies the operation represented by an encoded instruction.

TARA16 uses 16-bit instructions with a 5-bit opcode field.

The opcode identifies the instruction operation.

For example:

| Instruction | Opcode |
| ----------- | ------ |
| NOP         | 00000  |
| HLT         | 00001  |
| ADD         | 01001  |
| SUB         | 01010  |
| MUL         | 01100  |
| JMP         | 10110  |

The execution environment interprets the instruction and determines which operation must be performed.

## 7.5 Operand Identification

Operands are the values or locations required by an instruction.

Depending on the instruction, operands may represent:

* General-purpose registers.
* Immediate constants.
* Memory locations.
* Branch or jump destinations.

For example, an arithmetic instruction requires values on which the operation will be performed.

A memory instruction requires information identifying the relevant memory access.

The number and arrangement of operands depend on the instruction format.

## 7.6 Operation Execution

After decoding and operand identification, the execution environment performs the required operation.

Different instructions perform different tasks.

### Arithmetic Operations

Examples:

* ADD
* SUB
* MUL
* ADDI

These instructions perform mathematical calculations.

### Logical Operations

Examples:

* AND
* OR
* XOR
* NOT

These instructions perform bitwise operations.

### Shift Operations

Examples:

* SHL
* SHR

These instructions shift bits within a value.

### Data Movement

Example:

* MOV

This instruction transfers a value between supported operands.

## 7.7 Memory Access

Some instructions require access to memory.

TARA16 provides four memory instructions:

| Instruction | Function   |
| ----------- | ---------- |
| LDW         | Load Word  |
| STW         | Store Word |
| LDB         | Load Byte  |
| STB         | Store Byte |

### Load Operation

A load operation reads data from memory.

The retrieved value is transferred to the specified destination register.

### Store Operation

A store operation writes data into memory.

The value to be stored is obtained from the specified operand.

Memory access is important for applications that need to preserve and retrieve data during execution.

## 7.8 Register Update

Instructions may modify register values.

For example, an arithmetic instruction can calculate a result and place it in a destination register.

Consider the conceptual operation:

```asm
ADD R1, R2, R3
```

Assuming destination-first operand ordering:

```text
R1 = R2 + R3
```

If:

```text
R2 = 15
R3 = 25
```

Then:

```text
R1 = 40
```

This example demonstrates how an instruction can change the register state.

The exact operand ordering and arithmetic behaviour must follow the TARA16 implementation.

## 7.9 Program Counter Update

The Program Counter determines the next instruction position.

Different instruction categories can affect its value differently.

### Sequential Execution

Normal instructions allow execution to continue to the next instruction.

### Conditional Branching

TARA16 provides:

* BZ – Branch if Zero.
* BN – Branch if Negative.

These instructions can change program flow when their specified conditions are satisfied.

### Unconditional Jump

JMP transfers execution to another program location.

### Subroutine Call

CALL transfers execution to a subroutine.

RET returns from the subroutine.

These operations make it possible to implement loops, conditions and reusable program sections.

## 7.10 Instruction Execution Flow

The following diagram illustrates the general instruction-processing process.

```text
        Start Program
              |
              v
       Read Program Counter
              |
              v
       Obtain Instruction
              |
              v
       Decode Instruction
              |
              v
      Identify Operands
              |
              v
       Execute Operation
              |
              v
       Memory Access?
          /       \
        Yes        No
         |          |
         v          |
    Access Memory   |
         |          |
         +----+-----+
              |
              v
       Update CPU State
              |
              v
      Update Program Counter
              |
              v
       Execution Finished?
          /       \
        No         Yes
        |           |
        v           v
   Next Instruction  Stop
```

This is a conceptual execution flow. The actual ordering of operations depends on the simulator implementation.

## 7.11 Example: Arithmetic Instruction Execution

Consider an addition operation:

```asm
ADD R1, R2, R3
```

Assume destination-first operand ordering.

Initial register values:

| Register | Value |
| -------- | ----: |
| R1       |     0 |
| R2       |    10 |
| R3       |    20 |

Execution:

1. Identify the ADD opcode.
2. Read the values from R2 and R3.
3. Perform the addition.
4. Calculate 10 + 20.
5. Store the result in R1.

Final register values:

| Register | Value |
| -------- | ----: |
| R1       |    30 |
| R2       |    10 |
| R3       |    20 |

## 7.12 Example: Memory Instruction Execution

Consider a conceptual load operation:

```asm
LDW R1, address
```

The operation represents reading a word from memory and transferring it into R1.

Suppose a memory location contains the value 100.

After a successful load:

```text
R1 = 100
```

Similarly, a store operation transfers a register value into memory.

The exact address syntax and memory representation depend on the TARA assembler and simulator.

## 7.13 Example: Conditional Branch Execution

Conditional branches allow programs to make decisions.

Consider a BZ instruction.

Its general purpose is to change the program flow when the specified zero condition is satisfied.

A conceptual flow is:

```text
       Evaluate Zero Condition
                 |
          +------+------+
          |             |
        Zero         Non-Zero
          |             |
          v             v
     Take Branch    Continue
```

The exact condition source and branch-target calculation must be obtained from the TARA16 implementation.

## 7.14 Instruction Execution in the Python Simulator

TARA16 uses a Python-based execution environment.

A software simulator implements the behaviour of the instruction set by maintaining and updating program state.

Important state elements include:

* Program Counter.
* General-purpose registers.
* Memory.
* Current instruction information.

The simulator interprets instructions and performs the corresponding operations.

For example:

* Arithmetic instructions update calculation results.
* Logical instructions perform bitwise operations.
* Memory instructions read or write data.
* Branch instructions control execution flow.
* HLT stops execution.

The actual implementation may use software functions and variables rather than separate physical hardware components.

## 7.15 Difference Between ISA and Execution Implementation

An ISA and its simulator are related, but they are not the same thing.

| ISA                                  | Simulator                        |
| ------------------------------------ | -------------------------------- |
| Defines available instructions       | Implements instruction behaviour |
| Defines register-visible behaviour   | Maintains register state         |
| Defines memory operations            | Implements memory access         |
| Defines instruction encoding         | Decodes encoded instructions     |
| Defines program-visible control flow | Updates execution state          |

This distinction is important when studying custom instruction set architectures.

TARA16 defines the instruction-level programming model, while the Python simulator provides an environment for executing programs that follow that model.

## 7.16 Importance in Application Development

Understanding instruction execution is useful when developing applications.

### Eleven Towers

Instruction execution concepts help explain:

* Game initialization.
* Game-state updates.
* Player input processing.
* Tower operations.
* Score calculations.
* Display updates.

### Brick Breaker

They help explain:

* Ball movement.
* Paddle movement.
* Collision calculations.
* Score updates.
* Game-over conditions.

### Digital Clock

They help explain:

* Counter updates.
* Time calculations.
* Conditional checks.
* Display operations.

### Analog Clock

They help explain:

* Coordinate calculations.
* Clock-hand positioning.
* Repeated updates.
* Graphical operations.

The individual application chapters will explain the actual instructions and algorithms used in each project.

## 7.17 Chapter Summary

Instruction execution connects the encoded instruction set with program behaviour.

The execution environment interprets instructions, identifies operands, performs operations and updates the program state.

TARA16 supports arithmetic, logical, memory, branching, jump, subroutine and stack instructions.

Understanding this process is essential for developing, testing and debugging TARA16 assembly applications.

## 7.18 Next Chapter

PART 8: TARA16 Memory Organization

The next chapter explains memory structure, addressing, load and store operations, byte and word access, and memory usage in TARA16 applications.
