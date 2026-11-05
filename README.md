# TARA ISA – Game and Application Development

### Exploring a Custom 16-Bit Instruction Set Architecture Through Practical Applications

## About the Project

This repository presents the study and application of the **TARA16 Instruction Set Architecture (ISA)** through theoretical documentation and practical software development.

The project focuses on understanding how an Instruction Set Architecture works, how assembly instructions are executed, and how different instructions can be combined to develop complete applications.

TARA16 is a custom 16-bit ISA with a recorded instruction set covering arithmetic, logical, memory, and control-flow operations.

To demonstrate its capabilities, four applications are included in this project:

1. Eleven Towers – Strategy-based game.
2. Brick Breaker – Arcade game.
3. Digital Clock – Numerical time-display application.
4. Analog Clock – Graphical clock application.

The repository is organized to help beginners understand the architecture, instruction set, assembly programming, execution process, and application development.

---

## Project Objectives

The main objectives of this project are:

* Understand the fundamentals of Instruction Set Architecture.
* Study the organization of the TARA16 architecture.
* Understand registers and instruction formats.
* Learn TARA16 assembly language.
* Study instruction encoding and execution.
* Understand memory organization and data handling.
* Compare a custom ISA with the RISC-V architecture.
* Explore the development environment and toolchain.
* Develop practical applications using TARA16.
* Understand how processor instructions contribute to real program execution.

---

## TARA16 Architecture – Overview

| Feature                   | Recorded Specification                       |
| ------------------------- | -------------------------------------------- |
| Architecture              | TARA16                                       |
| Instruction width         | 16 bits                                      |
| Opcode width              | 5 bits                                       |
| General-purpose registers | 8                                            |
| Register names            | R0–R7                                        |
| Instruction formats       | F0–F7                                        |
| Memory capacity           | 2 KB (to be verified against implementation) |
| Execution environment     | Python-based environment                     |

**Note:** These specifications reflect the currently documented project information. Exact encoding fields, memory behavior, and execution details should be verified against the original implementation.

---

## Repository Contents

The repository is divided into three major sections.

### 1. TARA16 ISA Documentation

This section explains the architecture and programming concepts from beginner to advanced levels.

| Chapter | Topic                                 | Documentation                                                                                        |
| ------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| 01      | Introduction to TARA16                | [Introduction](01_TARA_ISA_Documentation/01_Introduction/Introduction.md)                            |
| 02      | TARA16 Architecture                   | [Architecture](01_TARA_ISA_Documentation/02_Architecture/Architecture.md)                            |
| 03      | Register Organization                 | [Registers](01_TARA_ISA_Documentation/03_Registers/Registers.md)                                     |
| 04      | Instruction Set                       | [Instruction Set](01_TARA_ISA_Documentation/04_Instruction_Set/Instruction_Set.md)                   |
| 05      | Instruction Formats and Encoding      | [Instruction Formats](01_TARA_ISA_Documentation/05_Instruction_Formats/Instruction_Formats.md)       |
| 06      | TARA Assembly Language                | [Assembly Language](01_TARA_ISA_Documentation/06_Assembly_Language/Assembly_Language.md)             |
| 07      | Instruction Execution                 | [Instruction Execution](01_TARA_ISA_Documentation/07_Instruction_Execution/Instruction_Execution.md) |
| 08      | Memory Organization                   | [Memory](01_TARA_ISA_Documentation/08_Memory_Organization/Memory.md)                                 |
| 09      | TARA16 vs RISC-V                      | [Comparison](01_TARA_ISA_Documentation/09_TARA_vs_RISCV/Comparison.md)                               |
| 10      | Development Environment and Toolchain | [Toolchain](01_TARA_ISA_Documentation/10_Toolchain/Build_and_Execution.md)                           |

### 2. Game Applications

This section contains two games developed as practical applications of the TARA16 instruction set.

#### Eleven Towers

A strategy-based game involving dice combinations, tower progression, player turns, and winning conditions.

* [Project README](02_Games/Eleven_Towers/README.md)
* [Game Documentation](02_Games/Eleven_Towers/Documentation/Documentation.md)
* [Source Code](02_Games/Eleven_Towers/Source/)
* [Screenshots](02_Games/Eleven_Towers/Screenshots/)

#### Brick Breaker

An arcade-style game involving ball movement, paddle control, collision detection, and brick destruction.

* [Project README](02_Games/Brick_Breaker/README.md)
* [Game Documentation](02_Games/Brick_Breaker/Documentation/Documentation.md)
* [Source Code](02_Games/Brick_Breaker/Source/)
* [Screenshots](02_Games/Brick_Breaker/Screenshots/)

### 3. Clock Applications

This section contains two clock applications demonstrating time management and graphical display concepts.

#### Digital Clock

A numerical clock application that represents time using hours, minutes, and seconds.

* [Project README](03_Clock_Applications/Digital_Clock/README.md)
* [Clock Documentation](03_Clock_Applications/Digital_Clock/Documentation/Documentation.md)
* [Source Code](03_Clock_Applications/Digital_Clock/Source/)
* [Screenshots](03_Clock_Applications/Digital_Clock/Screenshots/)

#### Analog Clock

A graphical clock application that represents time using hour, minute, and second hands.

* [Project README](03_Clock_Applications/Analog_Clock/README.md)
* [Clock Documentation](03_Clock_Applications/Analog_Clock/Documentation/Documentation.md)
* [Source Code](03_Clock_Applications/Analog_Clock/Source/)
* [Screenshots](03_Clock_Applications/Analog_Clock/Screenshots/)

---

## Project Directory Structure

```text
TARA-ISA-Game-Development/
│
├── README.md
├── LICENSE
│
├── 01_TARA_ISA_Documentation/
│   ├── 01_Introduction/
│   ├── 02_Architecture/
│   ├── 03_Registers/
│   ├── 04_Instruction_Set/
│   ├── 05_Instruction_Formats/
│   ├── 06_Assembly_Language/
│   ├── 07_Instruction_Execution/
│   ├── 08_Memory_Organization/
│   ├── 09_TARA_vs_RISCV/
│   └── 10_Toolchain/
│
├── 02_Games/
│   ├── Eleven_Towers/
│   │   ├── Source/
│   │   ├── Documentation/
│   │   ├── Screenshots/
│   │   └── README.md
│   │
│   └── Brick_Breaker/
│       ├── Source/
│       ├── Documentation/
│       ├── Screenshots/
│       └── README.md
│
├── 03_Clock_Applications/
│   ├── Digital_Clock/
│   │   ├── Source/
│   │   ├── Documentation/
│   │   ├── Screenshots/
│   │   └── README.md
│   │
│   └── Analog_Clock/
│       ├── Source/
│       ├── Documentation/
│       ├── Screenshots/
│       └── README.md
│
└── Beginner/
    └── 01_Snake_Game/
```

---

## Concepts Covered

The project covers the following technical concepts:

**Computer Architecture**

* Instruction Set Architecture.
* Register organization.
* Instruction encoding.
* Instruction execution.
* Memory organization.
* Program control flow.

**Assembly Programming**

* Arithmetic instructions.
* Logical instructions.
* Memory access.
* Conditional branching.
* Jump instructions.
* Subroutines.

**Application Development**

* Game logic.
* Dice combinations.
* Collision detection.
* Coordinate calculations.
* Time management.
* Graphical display updates.

**Development Tools**

* Linux.
* Python.
* Assembly conversion utilities.
* Git.
* GitHub.

---

## Development Workflow

The general TARA16 application development process is:

```text
       Application Design
               |
               v
       TARA Assembly Code
               |
               v
       Conversion Utility
               |
               v
    Instruction Representation
               |
               v
      Execution Environment
               |
               v
        Program Output
               |
               v
        Testing and Debugging
```

The exact commands and file formats depend on the TARA development tools.

---

## Applications

| Application   | Category              | Main Concepts                                               |
| ------------- | --------------------- | ----------------------------------------------------------- |
| Eleven Towers | Strategy Game         | Dice combinations, branching, game-state management         |
| Brick Breaker | Arcade Game           | Ball movement, collision detection, coordinate calculations |
| Digital Clock | Time Application      | Counters, arithmetic, overflow handling                     |
| Analog Clock  | Graphical Application | Angles, coordinates, hand movement, display refreshing      |

---

## Learning Outcomes

After studying this project, learners should be able to:

1. Explain the basic concepts of an Instruction Set Architecture.
2. Understand the organization of a custom ISA.
3. Identify registers and instruction formats.
4. Understand how assembly instructions represent operations.
5. Explain the general instruction execution process.
6. Understand the relationship between assembly code and instruction representation.
7. Compare a custom ISA with RISC-V.
8. Understand how arithmetic, memory, and control-flow instructions support applications.
9. Explore the development of complete programs using a custom ISA.

---

## Future Scope

Possible future improvements include:

* Completing and verifying all application source-code documentation.
* Adding execution screenshots and demonstrations.
* Improving the TARA development workflow.
* Developing additional applications.
* Adding automated instruction-level testing.
* Exploring a Verilog/SystemVerilog hardware implementation of TARA16.
* Studying FPGA implementation and verification.

Hardware implementation is a separate future development activity and is not implied by the existence of the software execution environment.

---

## License

Refer to the [LICENSE](LICENSE) file for licensing information.

---

## Acknowledgement

This repository is developed as an educational project to explore a custom Instruction Set Architecture and demonstrate its application through practical programs.

The project aims to connect computer architecture concepts with assembly programming and application development.

**TARA16 – Understanding Processor Instructions Through Practical Applications.**
