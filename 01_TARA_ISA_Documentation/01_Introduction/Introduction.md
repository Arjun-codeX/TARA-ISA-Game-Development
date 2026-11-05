# PART 1: INTRODUCTION TO TARA ISA

## 1.1 What is an Instruction Set Architecture?

An Instruction Set Architecture (ISA) is the interface between software and a processor.

It defines the instructions that a processor understands and explains how software communicates with the hardware or execution environment.

An ISA specifies important aspects such as:

- Supported instructions
- Register organization
- Data types and sizes
- Memory access operations
- Addressing modes
- Instruction formats
- Control-flow operations

For example, an assembly instruction can request the processor to add two values, access memory, or change the program execution sequence.

## 1.2 What is TARA ISA?

TARA ISA is the instruction set architecture used in this project to develop and execute applications such as games and clock programs.

This repository explores TARA ISA from its fundamental concepts to practical application development.

The objective is to understand how assembly instructions are used to implement application logic and how those instructions are processed by the TARA execution environment.

## 1.3 Why Learn TARA ISA?

Learning an ISA helps us understand the relationship between software and computer architecture.

Through TARA ISA, this project aims to explore:

- How instructions represent program operations.
- How registers are used to store and manipulate data.
- How arithmetic and logical operations are performed.
- How branches and jumps control program execution.
- How memory operations are used.
- How assembly programs are developed.
- How instructions are used to create practical applications.

## 1.4 Software-to-Execution Flow

A typical assembly development workflow follows these stages:

1. Write the program using assembly language.
2. Convert the assembly source into the format required by the TARA toolchain.
3. Load the generated program into the execution environment.
4. Execute the instructions.
5. Observe the output and debug errors.

The exact tools and conversion stages used in this project will be documented in the development environment chapter.

## 1.5 Applications Developed Using TARA ISA

This repository contains four application projects:

### 1. Eleven Towers
A game developed using TARA assembly instructions. Its documentation will explain the game logic, input handling, graphics operations, and program execution.

### 2. Brick Breaker
A game project demonstrating application logic, movement, collision handling, and display operations.

### 3. Digital Clock
A digital clock application demonstrating time representation, counting, and display updates.

### 4. Analog Clock
An analog clock application demonstrating clock-hand positioning, angle calculations, and graphical display operations.

## 1.6 Learning Objectives

After studying this documentation and projects, readers should be able to:

- Understand the purpose of an ISA.
- Explain the TARA ISA architecture.
- Understand its registers and instruction formats.
- Read and write TARA assembly programs.
- Understand instruction encoding and execution.
- Develop applications using TARA ISA.
- Compare TARA ISA concepts with RISC-V.

## 1.7 Documentation Roadmap

The documentation is organized into the following parts:

1. Introduction to TARA ISA
2. TARA ISA Architecture
3. Register Organization
4. Instruction Set
5. Instruction Formats and Encoding
6. Assembly Language
7. Instruction Execution
8. Memory Organization
9. TARA ISA vs RISC-V
10. Development Environment and Toolchain
11. Eleven Towers Game
12. Brick Breaker Game
13. Digital Clock
14. Analog Clock

---

**Note:** The exact architectural specifications, register definitions, instruction encodings, and execution details will be documented from the actual TARA implementation and source code.
