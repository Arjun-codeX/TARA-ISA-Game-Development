# Chapter 8: Memory Organization

## 8.1 Introduction to Memory
## 8.2 Memory Addressing
## 8.3 Memory Layout
## 8.4 Load Operations
## 8.5 Store Operations
## 8.6 Byte and Word Access
## 8.7 Stack Memory

# PART 8: TARA16 MEMORY ORGANIZATION

## 8.1 Introduction to Memory

Memory is an important part of a computer system. It stores instructions, data and intermediate values required during program execution.

A program uses memory to preserve information that may be needed later.

For example, a game application may need to store player positions, scores, object coordinates and other game-related information.

In assembly programming, memory operations allow programs to read and write stored values.

## 8.2 TARA16 Memory Specifications

The TARA16 implementation discussed in this project has a memory capacity of 2 KB.

| Parameter           | Specification                        |
| ------------------- | ------------------------------------ |
| Architecture        | TARA16                               |
| Memory capacity     | 2 KB                                 |
| Memory instructions | LDW, STW, LDB, STB                   |
| Memory operations   | Read and write                       |
| Addressing          | To be verified against the simulator |

### What Does 2 KB Mean?

KB stands for kilobyte.

Using the conventional binary interpretation:

1 KB = 1024 bytes

Therefore:

2 KB = 2 × 1024 = 2048 bytes

A memory capacity of 2 KB represents 2048 bytes of storage.

The exact usable address range and memory organization must be confirmed from the simulator implementation.

## 8.3 Understanding Memory Addresses

A memory address identifies a particular location in memory.

Programs use addresses to access stored information.

For example, consider a conceptual memory representation:

| Memory Address | Stored Value |
| -------------- | ------------ |
| Address A      | 10           |
| Address B      | 20           |
| Address C      | 30           |
| Address D      | 40           |

If a program needs the value stored at Address B, it performs a memory read operation.

If it needs to update a memory location, it performs a memory write operation.

### Why Are Addresses Important?

Addresses allow programs to:

* Retrieve stored values.
* Save calculation results.
* Access variables.
* Manage application data.
* Read and update memory locations.

## 8.4 Memory and Registers

Registers and memory are both used to store information, but they serve different purposes.

| Feature        | Registers                                 | Memory                              |
| -------------- | ----------------------------------------- | ----------------------------------- |
| Purpose        | Hold values used by instructions          | Store program data and instructions |
| Organization   | Eight general-purpose registers in TARA16 | 2 KB memory capacity                |
| Identification | Register identifiers R0–R7                | Memory addresses                    |
| Access         | Through register operands                 | Through memory operations           |
| Main use       | Temporary values and calculations         | Stored program information          |

Registers provide a small set of named storage locations, while memory provides a larger storage area.

## 8.5 Load and Store Operations

TARA16 provides four memory instructions:

| Instruction | Full Form  | Function                  |
| ----------- | ---------- | ------------------------- |
| LDW         | Load Word  | Reads a word from memory  |
| STW         | Store Word | Writes a word into memory |
| LDB         | Load Byte  | Reads a byte from memory  |
| STB         | Store Byte | Writes a byte into memory |

These instructions allow assembly programs to transfer information between registers and memory.

## 8.6 LDW – Load Word

LDW reads a word from a memory location and transfers it into a register.

### General Operation

```text
Register = Memory[Address]
```

### Conceptual Example

Suppose a memory location contains the value 100.

A load operation retrieves the value and places it into a destination register.

After the operation:

```text
R1 = 100
```

### Applications

LDW can be useful for:

* Retrieving stored variables.
* Reading calculation results.
* Accessing application data.
* Retrieving values required by subsequent instructions.

## 8.7 STW – Store Word

STW writes a word from a register into a memory location.

### General Operation

```text
Memory[Address] = Register
```

### Conceptual Example

Suppose:

```text
R1 = 250
```

A store operation writes the register value into the specified memory location.

After the operation, that memory location contains the stored value.

### Applications

STW can be useful for:

* Saving calculation results.
* Updating stored variables.
* Preserving application data.
* Storing values for later use.

## 8.8 LDB – Load Byte

LDB reads a byte from a memory location.

A byte contains eight bits.

```text
1 Byte = 8 Bits
```

### General Operation

```text
Register = Memory[Address]
```

The retrieved byte is placed into the destination register according to the instruction's defined behaviour.

### Applications

Byte-level memory access can be useful for:

* Character data.
* Small numerical values.
* Byte-oriented data structures.
* Compact data storage.

The exact extension behaviour, such as zero extension or sign extension, must be checked in the TARA16 implementation.

## 8.9 STB – Store Byte

STB writes a byte-sized value into a memory location.

### General Operation

```text
Memory[Address] = Register Value
```

Only the byte-sized portion defined by the instruction is stored.

### Applications

STB can be useful for:

* Storing character values.
* Updating individual byte locations.
* Managing byte-oriented data.
* Working with compact data structures.

The exact byte-selection and register-width rules depend on the implementation.

## 8.10 Difference Between Byte and Word Operations

Byte and word operations access data at different sizes.

| Feature     | Byte Operation    | Word Operation                    |
| ----------- | ----------------- | --------------------------------- |
| Instruction | LDB / STB         | LDW / STW                         |
| Data size   | 8 bits            | Implementation-defined word width |
| Purpose     | Byte-level access | Word-level access                 |
| Example use | Character data    | Larger numerical values           |

The exact word width must be verified from the TARA16 implementation rather than assumed from the architecture name.

## 8.11 Memory Read and Write Process

Memory operations can be understood using the following conceptual diagrams.

### Memory Read

```text
       Memory Address
              |
              v
         Read Request
              |
              v
         Memory Location
              |
              v
         Retrieve Data
              |
              v
        Destination Register
```

### Memory Write

```text
        Source Register
              |
              v
          Data Value
              |
              v
         Write Request
              |
              v
         Memory Address
              |
              v
        Update Memory
```

These diagrams represent the general behaviour of memory instructions.

## 8.12 Memory Organization in Assembly Programs

Memory is useful when a program needs to preserve information beyond temporary register operations.

For example, an application may need to:

1. Calculate a value.
2. Store the result in memory.
3. Perform other operations.
4. Retrieve the stored result.
5. Continue execution.

This allows programs to manage data throughout their execution.

## 8.13 Memory Usage in Game Development

Memory operations are useful when developing games using TARA16.

### Eleven Towers

Potential application data includes:

* Game state.
* Tower-related values.
* Player input information.
* Score values.
* Temporary calculations.

### Brick Breaker

Potential application data includes:

* Ball coordinates.
* Paddle position.
* Score.
* Remaining lives.
* Game-state information.

The actual storage locations and register assignments depend on the program implementation.

## 8.14 Memory Usage in Clock Applications

### Digital Clock

A digital clock may require values representing:

* Hours.
* Minutes.
* Seconds.
* Counter states.
* Display information.

### Analog Clock

An analog clock may require values representing:

* Clock-hand positions.
* Angles.
* Coordinates.
* Display update information.

Memory can be used to preserve application values when required.

## 8.15 Memory-Related Programming Errors

Some common memory-related errors include:

### Invalid Memory Address

Accessing a location outside the supported memory range.

### Incorrect Data Size

Using a byte operation when a word operation is required, or vice versa.

### Incorrect Load Operation

Reading from an unintended memory location.

### Incorrect Store Operation

Writing data to the wrong address.

### Data Overwriting

Replacing previously stored information unintentionally.

### Address Calculation Errors

Calculating an incorrect memory address.

Testing memory operations is important for reliable assembly programming.

## 8.16 Memory and the TARA16 Simulator

The TARA16 Python simulator provides the software execution environment for memory-related instructions.

It interprets load and store instructions and performs the corresponding memory operations.

To understand its exact memory implementation, the following details should be examined in the simulator:

* Memory initialization.
* Memory capacity.
* Address representation.
* Byte and word access.
* Memory read behaviour.
* Memory write behaviour.
* Address validation.
* Data-width handling.

These details distinguish the actual TARA16 implementation from a general memory model.

## 8.17 Chapter Summary

Memory provides storage for instructions and data required during program execution.

The TARA16 implementation discussed in this project has a memory capacity of 2 KB and provides four memory instructions:

* LDW – Load Word.
* STW – Store Word.
* LDB – Load Byte.
* STB – Store Byte.

Load instructions retrieve information from memory, while store instructions write information into memory.

Understanding memory organization is essential for developing assembly applications and managing program data.

## 8.18 Next Chapter

**PART 9: TARA16 vs RISC-V**

The next chapter compares TARA16 and RISC-V, covering:

* ISA concepts.
* Instruction width.
* Register organization.
* Instruction formats.
* Opcode encoding.
* Arithmetic and logical operations.
* Memory instructions.
* Branching and control flow.
* Assembly programming.
* Development tools.
* Architectural differences and similarities.
