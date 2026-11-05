# TARA16 Eleven Towers Game

## 1. Project Introduction

Eleven Towers is a two-player, dice-based game implemented using TARA16 assembly language.

The game contains eleven towers numbered from 2 to 12. Players use four dice to calculate tower numbers, select towers, and perform climbing operations.

The project demonstrates how a custom Instruction Set Architecture (ISA) can be used to develop an interactive application using assembly language.

## 2. Project Objectives

* Understand TARA16 assembly language programming.
* Implement dice generation and arithmetic operations.
* Develop tower selection and climbing algorithms.
* Implement keyboard-based game interaction.
* Understand framebuffer-based graphics.
* Practice memory management, branching, loops, and subroutines.

## 3. Implemented Features

* Two-player interface.
* Four six-sided dice.
* Eleven towers numbered 2–12.
* Deterministic dice value generation.
* Two dice-pair calculations.
* Tower selection and climbing operations.
* Player switching.
* Keyboard-based controls.
* 64 × 64 monochrome display.
* Framebuffer-based graphics.

**Note:** This is a partial implementation of the Eleven Towers game. Permanent tower claiming, bust detection, independent player progress, and complete winning-condition logic are not yet implemented.

## 4. Tower Organization

The game contains eleven towers with different heights.

| Tower | Height |
| ----- | -----: |
| 2     |      3 |
| 3     |      4 |
| 4     |      5 |
| 5     |      6 |
| 6     |      7 |
| 7     |      8 |
| 8     |      7 |
| 9     |      6 |
| 10    |      5 |
| 11    |      4 |
| 12    |      3 |

Tower 7 has the maximum height in the current implementation.

## 5. Game Controls

| Key | Function                |
| --- | ----------------------- |
| W   | Roll or advance dice    |
| A   | Select left-side tower  |
| D   | Select right-side tower |
| S   | Switch active player    |
| Q   | Quit the game           |

## 6. Game Architecture

The program is organized into different routines to handle game operations.

| Routine         | Function                                  |
| --------------- | ----------------------------------------- |
| ROLL_DICE       | Updates four dice values                  |
| CLIMB_ONE       | Updates tower-climbing progress           |
| CLIMB_FROM_DICE | Processes dice results for climbing       |
| SWITCH_PLAYER   | Changes the active player                 |
| Main game loop  | Handles keyboard input and game execution |

## 7. Dice Pairing Algorithm

The implementation uses two pairings:

```text
Pairing 1:
A + B
C + D

Pairing 2:
A + C
B + D
```

For example, with dice values 2, 3, 4, and 5:

* Pairing 1 produces 5 and 9.
* Pairing 2 produces 6 and 8.

The dice generation is deterministic rather than random.

## 8. Graphics Implementation

The game uses a 64 × 64 monochrome framebuffer.

Framebuffer memory:

* Start address: `0x0600`
* End address: `0x07FF`

Each display row uses eight bytes.

The program uses memory addressing and bitwise operations to update individual pixels.

## 9. Source Code

Main source file:

`Source/eleven_towers_full.tara`

The source contains approximately 1,233 lines of TARA16 assembly code.

It includes the game initialization, dice operations, tower-climbing routines, player switching, keyboard handling, and display operations.

## 10. TARA16 Assembly Concepts

The project demonstrates:

* Arithmetic operations.
* Immediate value loading.
* Register-based data processing.
* Memory read and write operations.
* Conditional branching.
* Loops and jump instructions.
* Subroutine calls and returns.
* Bitwise operations.
* Framebuffer addressing.

## 11. How to Build

The source must be assembled using the TARA16 assembler.

The assembler converts the assembly instructions into machine instruction words.

The resulting program can be loaded into the TARA16 CPU simulator.

## 12. How to Run

Run the assembled program using the TARA16 CPU simulator.

The simulator executes the game instructions and processes keyboard input and framebuffer updates.

Refer to the technical documentation for implementation details.

## 13. Project Structure

```text
Eleven_Towers/
│
├── README.md
│
├── Source/
│   ├── eleven_towers_full.tara
│   ├── eleven_towers.tara
│   ├── eleven_towers.tlv
│   ├── eleven_towers.sv
│   ├── eleven_towers_gen.sv
│   ├── convert.py
│   └── tara_test.tara
│
├── Documentation/
│   └── Documentation.md
│
└── Screenshots/
```

## 14. Current Limitations

The following features are planned for future development:

* Random dice generation.
* Third dice pairing.
* Separate progress tracking for both players.
* Permanent tower claiming.
* Bust detection.
* Complete turn-management rules.
* Winning-condition detection.

## 15. Conclusion

The TARA16 Eleven Towers project demonstrates the implementation of an interactive game using a custom instruction set.

It provides practical experience with assembly programming, arithmetic operations, memory organization, keyboard input, framebuffer graphics, and program control flow.

The current implementation provides a foundation for developing a more complete two-player strategy game.
