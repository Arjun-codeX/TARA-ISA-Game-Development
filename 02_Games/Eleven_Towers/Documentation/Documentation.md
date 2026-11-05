# Chapter 11: TARA16 Eleven Towers Game

## 11.1 Introduction

Eleven Towers is a two-player, dice-based strategy game implemented using TARA16 assembly language.

The game contains eleven towers numbered from 2 to 12. Players use four dice to generate values and select towers on which to make climbing progress.

The application demonstrates how a custom instruction set can be used to develop an interactive game involving arithmetic operations, memory management, conditional branching, loops, and keyboard input.

The implementation uses a 64 × 64 monochrome display and a memory-based framebuffer to display the game board.

## 11.2 Project Objectives

The main objectives of this project are:

* Implement a game using TARA16 assembly language.
* Understand the execution of assembly instructions.
* Implement four-dice value generation.
* Calculate tower numbers using arithmetic operations.
* Implement tower selection and climbing operations.
* Handle keyboard inputs for game interaction.
* Display game information using framebuffer operations.
* Understand memory organization and program control flow.

## 11.3 Game Components

The current implementation contains the following components:

| Component         | Description                         |
| ----------------- | ----------------------------------- |
| Players           | Two-player interface                |
| Dice              | Four six-sided dice                 |
| Towers            | Eleven towers                       |
| Tower numbers     | 2 to 12                             |
| Display           | 64 × 64 monochrome framebuffer      |
| Keyboard          | Input-based game control            |
| Climbing progress | Tracks progress on selected towers  |
| Player switching  | Changes the active player           |
| Game loop         | Continuously processes game actions |

## 11.4 Tower Organization

The game contains eleven towers numbered from 2 to 12.

Each tower has a different maximum climbing height.

The implemented height calculation follows these rules:

* For tower numbers 2 to 7, height = tower number + 1.
* For tower numbers 8 to 12, height = 15 − tower number.

The resulting tower heights are:

| Tower Number | Implemented Height |
| ------------ | -----------------: |
| 2            |                  3 |
| 3            |                  4 |
| 4            |                  5 |
| 5            |                  6 |
| 6            |                  7 |
| 7            |                  8 |
| 8            |                  7 |
| 9            |                  6 |
| 10           |                  5 |
| 11           |                  4 |
| 12           |                  3 |

Tower 7 has the greatest height in the current implementation.

## 11.5 Four-Dice Implementation

The game uses four six-sided dice.

Each die has a value that is used in the tower-selection process.

The program contains a dedicated `ROLL_DICE` routine that updates the four dice values.

The current implementation uses deterministic dice generation. The values advance and wrap around rather than being generated using a random-number generator.

This makes the dice behaviour predictable during program execution.

## 11.6 Dice Pairing Algorithm

The program uses two pair sums to determine possible tower numbers.

For four dice values A, B, C, and D, the implemented pairing calculations use:

```text
Pairing 1:
A + B
C + D

Pairing 2:
A + C
B + D
```

Each sum represents a possible tower number.

For example, if the dice values are:

```text
A = 2
B = 3
C = 4
D = 5
```

The calculations are:

```text
A + B = 5
C + D = 9

A + C = 6
B + D = 8
```

Therefore, the two pairings produce:

* Pairing 1: Towers 5 and 9.
* Pairing 2: Towers 6 and 8.

The current implementation does not calculate all three possible pairings of four dice.

## 11.7 Player Controls

The game uses keyboard input to interact with the application.

The implemented controls are:

| Key | Function                    |
| --- | --------------------------- |
| W   | Roll or advance the dice    |
| A   | Select the left-side tower  |
| D   | Select the right-side tower |
| S   | Switch the active player    |
| Q   | Quit the game               |

These controls allow the user to interact with the displayed game.

## 11.8 Tower Selection

Tower selection determines which tower receives climbing progress.

The player can use the selection controls to choose between available tower positions.

The program maintains information about the selected tower and uses the corresponding tower number during the climbing operation.

The selection logic is part of the interactive game loop.

## 11.9 Climbing Algorithm

The `CLIMB_ONE` routine performs the tower-climbing operation.

It updates the progress associated with a selected tower.

The climbing calculation uses the tower number and its corresponding height.

The program also contains the `CLIMB_FROM_DICE` routine, which connects the dice calculations with the climbing operation.

This separates dice processing from the actual progress-update operation.

## 11.10 Player Switching

The game supports two players.

The `SWITCH_PLAYER` routine changes the active player.

The active-player information is used by the game to control player selection and interaction.

However, the current implementation uses a shared progress array rather than maintaining completely separate climbing-progress arrays for both players.

Therefore, the current player-switching mechanism should not be interpreted as a complete independent two-player game-state system.

## 11.11 Display and Framebuffer Organization

The game uses a 64 × 64 monochrome display.

The framebuffer occupies the following memory region:

```text
Start Address: 0x0600
End Address:   0x07FF
```

Each row requires eight bytes because one byte represents eight horizontal pixels.

The framebuffer allows the program to draw the game board and update the displayed information.

Pixel operations are performed using memory addressing and bitwise operations.

## 11.12 Game-State Management

The program maintains information required for game execution.

The important categories include:

* Dice values.
* Active player.
* Selected tower.
* Tower-climbing progress.
* Display information.
* Keyboard input.
* Game execution state.

The current implementation provides basic player switching and shared climbing-progress management.

Separate permanent claims, independent player progress, and complete winner information are not implemented.

## 11.13 Game Execution Flow

The main program continuously executes the game loop.

The general execution flow is:

```text
             START
               |
               v
       Initialize Game
               |
               v
        Draw Game Board
               |
               v
       Read Keyboard Input
               |
        +------+------+
        |             |
        v             v
     W Press       A / D Press
        |             |
        v             v
     Roll Dice    Select Tower
        |             |
        +------+------+
               |
               v
       Calculate Pair Sums
               |
               v
       Update Climbing
          Progress
               |
               v
       Check Keyboard Input
               |
        +------+------+
        |             |
        v             v
     S Press       Q Press
        |             |
        v             v
   Switch Player    Quit
        |
        v
     Continue
```

This flow represents the main interaction structure. It does not imply that unimplemented game rules such as bust detection and tower claiming are present.

## 11.14 Important Assembly Routines

The source code contains several important routines.

| Routine           | Purpose                                        |
| ----------------- | ---------------------------------------------- |
| `ROLL_DICE`       | Updates the four dice values                   |
| `CLIMB_ONE`       | Updates climbing progress                      |
| `CLIMB_FROM_DICE` | Connects dice results with climbing operations |
| `SWITCH_PLAYER`   | Changes the active player                      |
| Main game loop    | Handles keyboard input and game execution      |

These routines divide the program into smaller functional sections and make the assembly code easier to understand.

## 11.15 TARA16 Instructions Used

The application uses TARA16 assembly instructions to perform arithmetic, memory access, logical operations, and program control.

Important instruction categories include:

| Instruction Category    | Application                             |
| ----------------------- | --------------------------------------- |
| Data movement           | Transfer values between registers       |
| Immediate loading       | Initialize constants and values         |
| Arithmetic              | Calculate dice sums and progress        |
| Logical operations      | Perform bit manipulation                |
| Shift operations        | Calculate pixel positions and addresses |
| Memory operations       | Read and update game information        |
| Conditional branching   | Control program decisions               |
| Jump instructions       | Transfer execution between routines     |
| Subroutine instructions | Organize game operations                |

The exact instruction usage can be examined in the source file:

`Source/eleven_towers_full.tara`

## 11.16 Programming Concepts Demonstrated

### Arithmetic Operations

Addition is used to calculate dice pair sums and determine tower numbers.

### Conditional Branching

Conditional branches allow the program to select different execution paths based on input and calculated values.

### Loops

The main game loop continuously checks keyboard input and processes game operations.

### Memory Management

Memory locations are used to maintain dice values, climbing progress, player information, and framebuffer data.

### Subroutines

Separate routines perform dice generation, climbing operations, and player switching.

### Input Handling

Keyboard input allows the user to interact with the game.

### Framebuffer Graphics

Bitwise operations and memory addressing are used to update the monochrome display.

## 11.17 Testing and Verification

The source file contains 1,233 lines of TARA16 assembly code.

The implementation should be tested using the TARA16 assembler and CPU simulator.

The following tests are useful:

| Test Case           | Verification Objective            |
| ------------------- | --------------------------------- |
| Initialize the game | Check initial game state          |
| Roll dice           | Verify four dice values           |
| Advance dice        | Check deterministic value updates |
| Calculate pair sums | Verify both implemented pairings  |
| Select a tower      | Check selection behaviour         |
| Climb a tower       | Verify progress updates           |
| Switch player       | Verify active-player changes      |
| Press Q             | Verify quit behaviour             |
| Update display      | Check framebuffer changes         |

Assembly success alone does not establish that every gameplay feature works correctly. Each operation should be tested separately.

## 11.18 Current Implementation Limitations

The current version demonstrates the basic game structure and interaction mechanisms, but it does not implement every rule of a complete Eleven Towers strategy game.

The following features remain future improvements:

1. Random dice generation.
2. Calculation of the third possible dice pairing.
3. Independent climbing progress for each player.
4. Permanent tower claiming.
5. Bust detection.
6. Removal of opponent progress after a tower is claimed.
7. Complete winning-condition detection.
8. Full turn-management logic.

These features can be added in future versions to make the game more complete.

## 11.19 Future Improvements

Possible improvements include:

* Implementing a random-number generator for dice.
* Supporting all three dice pairings.
* Maintaining separate game-state information for both players.
* Implementing permanent tower claims.
* Adding bust detection and turn-ending rules.
* Implementing the complete winning condition.
* Improving the game-board display.
* Adding more detailed simulation and verification tests.

## 11.20 Conclusion

The TARA16 Eleven Towers project demonstrates how assembly language can be used to implement an interactive, dice-based game.

The current implementation includes four-dice processing, tower selection, climbing operations, player switching, keyboard input, and framebuffer-based display operations.

The project provides practical experience with arithmetic instructions, memory management, conditional branching, subroutines, and program control flow.

It also provides a foundation for implementing more advanced game logic and completing the remaining strategy-game features.
