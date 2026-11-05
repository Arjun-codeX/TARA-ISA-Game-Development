# Brick Breaker Game Using TARA16 ISA

## 1. Introduction

Brick Breaker is a classic arcade game in which the player controls a paddle to keep a moving ball inside the playing area. The ball moves around the screen, bounces off boundaries, and destroys targets when it makes contact with them.

This project implements a compact version of Brick Breaker using the TARA16 instruction set architecture.

The complete game is written in TARA16 assembly language. The program directly manages the display framebuffer, keyboard input, game variables, ball movement, collision detection, and scoring.

The implementation uses a 64 × 64 monochrome display with one bit per pixel.

### 1.1 Project Objectives

The main objectives are:

* Understand how a game can be implemented using assembly language.
* Apply TARA16 instructions to control program execution.
* Understand memory-mapped input and framebuffer-based output.
* Implement paddle movement using keyboard input.
* Implement ball movement using coordinate updates.
* Detect collisions with screen boundaries and the paddle.
* Detect target collisions and update the score.
* Use subroutines for repeated operations.
* Understand how low-level instructions implement game logic.

### 1.2 Project Specifications

| Parameter               | Implementation       |
| ----------------------- | -------------------- |
| Project                 | Brick Breaker        |
| Processor architecture  | TARA16               |
| Programming language    | TARA16 Assembly      |
| Display resolution      | 64 × 64 pixels       |
| Display type            | Monochrome           |
| Pixel depth             | 1 bit per pixel      |
| Framebuffer start       | 0x0600               |
| Framebuffer end         | 0x07FF               |
| Keyboard input address  | 0x05FF               |
| Number of targets       | 200                  |
| Target arrangement      | 20 columns × 10 rows |
| Initial score           | 0                    |
| Initial lives           | 3                    |
| Initial ball position   | (32, 18)             |
| Initial paddle position | X = 26, Y = 4        |
| Ball initial direction  | DX = 1, DY = 1       |
| Points per target       | 10                   |

---

## 2. Game Overview

The playing area contains three main elements:

1. Paddle
2. Ball
3. Targets

The paddle is located near the lower-coordinate boundary of the screen. The player moves it horizontally using the left and right keyboard controls.

The ball moves automatically. Its position changes according to its horizontal and vertical direction values.

When the ball reaches a boundary, its direction may be reversed.

When the ball touches a target pixel, that target is removed, the score increases by 10, and the vertical direction changes.

The program initializes 200 targets arranged in 20 columns and 10 rows.

### 2.1 Keyboard Controls

| Key   | Function          | Keyboard bit |
| ----- | ----------------- | ------------ |
| LEFT  | Move paddle left  | Bit 2        |
| RIGHT | Move paddle right | Bit 3        |
| QUIT  | Stop the game     | Bit 4        |

The keyboard input is read from memory address 0x05FF.

The program checks the keyboard state during every main-loop iteration.

If both LEFT and RIGHT are active simultaneously, LEFT is checked first and receives priority.

---

## 3. System Architecture

The program can be divided into the following functional blocks:

1. Initialization
2. Framebuffer management
3. Target generation
4. Paddle initialization
5. Ball initialization
6. Keyboard input processing
7. Paddle movement
8. Ball movement
9. Wall collision detection
10. Paddle collision detection
11. Target collision detection
12. Score management
13. Game termination
14. Pixel manipulation routines

### 3.1 Overall Program Flow

```text
              START
                |
                v
       Initialize Registers
                |
                v
       Clear Framebuffer
                |
                v
       Initialize Pixel Mask
                |
                v
       Initialize Game Variables
                |
                v
       Draw 200 Targets
                |
                v
       Draw Paddle and Ball
                |
                v
          MAIN LOOP
                |
                v
        Read Keyboard Input
                |
         +------+------+
         |             |
       QUIT?          NO
         |             |
        YES            v
         |       Move Paddle
         v             |
      GAME OVER        v
        HLT       Calculate Ball
                     Position
                        |
                        v
                Check Wall Collision
                        |
                        v
                Check Paddle Collision
                        |
                        v
                Check Target Collision
                        |
                        v
                  Update Score
                        |
                        v
                 Update Ball Pixel
                        |
                        v
                   Frame Delay
                        |
                        v
                   MAIN LOOP
```

---

## 4. Display and Framebuffer Organization

The game uses a 64 × 64 monochrome display.

Each pixel requires only one bit:

* 1 represents a lit pixel.
* 0 represents an unlit pixel.

The framebuffer occupies the memory range:

```text
Start address : 0x0600
End address   : 0x07FF
Total size    : 512 bytes
```

### 4.1 Why Does the Framebuffer Require 512 Bytes?

The display contains:

64 × 64 = 4096 pixels.

Since each pixel requires one bit:

4096 / 8 = 512 bytes.

Therefore, the complete display requires 512 bytes.

Each row contains 64 pixels.

Since one byte stores eight pixels:

64 / 8 = 8 bytes per row.

### 4.2 Pixel Address Calculation

The program calculates the framebuffer address using:

```text
Address = 0x0600 + (Y × 8) + (X / 8)
```

The pixel position inside the selected byte is determined by:

```text
Bit position = X AND 7
```

The program uses a pixel mask table to select the required bit.

### 4.3 Pixel Mask Table

The mask table starts at address 0x0420.

| Pixel offset | Mask |
| ------------ | ---- |
| 0            | 0x80 |
| 1            | 0x40 |
| 2            | 0x20 |
| 3            | 0x10 |
| 4            | 0x08 |
| 5            | 0x04 |
| 6            | 0x02 |
| 7            | 0x01 |

The masks allow the program to modify an individual pixel without changing the other pixels stored in the same byte.

---

## 5. Memory Organization

The program uses R7 as a base register for storing game variables.

The base address is initialized to:

```text
R7 = 0x0410
```

Variables are accessed using positive and negative offsets relative to R7.

### 5.1 Game Variable Map

| Variable             | Offset from R7 | Address |
| -------------------- | -------------: | ------: |
| Ball X               |            -16 |  0x0400 |
| Ball Y               |            -14 |  0x0402 |
| Ball DX              |            -12 |  0x0404 |
| Ball DY              |            -10 |  0x0406 |
| Paddle left position |             -8 |  0x0408 |
| Score                |             -6 |  0x040A |
| Lives                |             -4 |  0x040C |
| Targets remaining    |             -2 |  0x040E |
| New ball X           |              0 |  0x0410 |
| New ball Y           |             +2 |  0x0412 |
| Temporary variable   |             +4 |  0x0414 |
| Target Y             |             +6 |  0x0416 |
| Target X             |             +8 |  0x0418 |

The game variables are stored as 16-bit values using word load and store instructions.

### 5.2 Other Important Memory Locations

| Memory address | Purpose             |
| -------------- | ------------------- |
| 0x0420–0x0427  | Pixel mask table    |
| 0x05FF         | Keyboard input      |
| 0x0600–0x07FF  | Display framebuffer |

The framebuffer and keyboard input are accessed through memory addresses.

---

## 6. Initialization

Before starting the game, the program prepares the display and initializes all required game variables.

### 6.1 Register Initialization

The program initializes:

```asm
LIL R7, 0x10
LIH R7, 0x04
```

This creates the base address:

```text
R7 = 0x0410
```

### 6.2 Framebuffer Clearing

The program clears the complete framebuffer.

It starts at 0x0600 and writes zero to 512 consecutive bytes.

The process uses:

* STB to write a byte.
* ADDI to increment the address.
* ADDI to decrement the remaining byte count.
* BZ to detect completion.
* JMP to repeat the loop.

This ensures that no previous display information remains.

### 6.3 Pixel Mask Initialization

The program stores eight bit masks beginning at 0x0420.

These masks are used by the pixel manipulation routines.

### 6.4 Initial Game Variables

The initial game state is:

| Variable          | Initial value |
| ----------------- | ------------: |
| Ball X            |            32 |
| Ball Y            |            18 |
| Ball DX           |             1 |
| Ball DY           |             1 |
| Paddle left X     |            26 |
| Score             |             0 |
| Lives             |             3 |
| Targets remaining |           200 |

---

## 7. Target Generation

The game creates 200 targets using nested loops.

The arrangement contains:

* 20 columns
* 10 rows
* One pixel per target

### 7.1 Target Coordinates

Horizontal positions:

```text
3, 6, 9, 12, ... , 60
```

Vertical positions:

```text
36, 38, 40, 42, ... , 54
```

The horizontal coordinate increases by 3 pixels.

The vertical coordinate increases by 2 pixels.

### 7.2 Nested Loop Operation

The outer loop controls the target rows.

The inner loop controls the target columns.

For every target:

1. Load the X coordinate.
2. Load the Y coordinate.
3. Call the set_px routine.
4. Increase X by 3.
5. Check whether the row is complete.
6. Move to the next row.
7. Increase Y by 2.
8. Repeat until all rows are drawn.

### 7.3 Total Number of Targets

20 × 10 = 200 targets.

Each target is represented by one lit pixel.

This compact representation reduces framebuffer usage and simplifies collision detection.

---

## 8. Paddle Implementation

The paddle is represented by six horizontal pixels.

Its initial position is:

```text
X = 26
Y = 4
```

The initial paddle occupies:

```text
(26,4)
(27,4)
(28,4)
(29,4)
(30,4)
(31,4)
```

### 8.1 Paddle Movement

The program reads the keyboard input and checks the LEFT and RIGHT bits.

For LEFT:

1. Read the current paddle position.
2. Check whether the position is greater than 2.
3. Decrease the position by one.
4. Save the updated position.

For RIGHT:

1. Read the current paddle position.
2. Check whether the position is less than 56.
3. Increase the position by one.
4. Save the updated position.

The limits ensure that the six-pixel paddle stays within the display.

### 8.2 Paddle Redrawing

When the paddle moves, the program:

1. Erases its previous six pixels.
2. Calculates its new position.
3. Draws six pixels at the new position.

If the paddle position has not changed, the program skips the erase-and-redraw operation.

This reduces unnecessary framebuffer writes and helps prevent visible flickering.

---

## 9. Ball Movement

The ball is represented by one pixel.

Its initial position is:

```text
Ball X = 32
Ball Y = 18
```

Its initial direction is:

```text
DX = 1
DY = 1
```

The next position is calculated using:

```text
New X = Current X + DX
New Y = Current Y + DY
```

The calculated coordinates are temporarily stored at:

```text
0x0410 = New X
0x0412 = New Y
```

The program then checks collisions before updating the ball's current position.

### 9.1 Horizontal Movement

The horizontal direction is stored in the ball DX variable.

A positive value moves the ball toward increasing X coordinates.

A negative value moves it toward decreasing X coordinates.

### 9.2 Vertical Movement

The vertical direction is stored in the ball DY variable.

A positive value moves the ball toward increasing Y coordinates.

A negative value moves it toward decreasing Y coordinates.

---

## 10. Wall Collision Detection

The program checks the ball's predicted position against the screen boundaries.

### 10.1 Left and Right Boundaries

The horizontal movement range is:

```text
X = 2 to 61
```

If the next X coordinate is below 2 or above 61, the horizontal direction is reversed.

The program performs two's-complement negation using:

```asm
NOT R3, R3
ADDI R3, 1
```

This produces:

```text
New DX = -DX
```

The ball's new X coordinate is recalculated using the updated direction.

### 10.2 Top Boundary

The top-boundary check prevents the next Y coordinate from exceeding 62.

When the limit is crossed, the vertical direction is reversed:

```text
New DY = -DY
```

The new Y coordinate is recalculated.

---

## 11. Paddle Collision Detection

The paddle is located at Y = 4.

The program checks for a paddle collision when:

```text
New Y = 5
```

It then checks whether the ball's X coordinate is inside the paddle's horizontal range:

```text
Paddle left X <= Ball X <= Paddle left X + 5
```

If both conditions are satisfied:

1. The vertical direction is reversed.
2. The ball's new Y coordinate is set to 6.
3. The program continues with target collision checking.

This allows the ball to bounce away from the paddle.

---

## 12. Target Collision Detection

Every target is represented by a lit framebuffer pixel.

The program uses the test_px subroutine to determine whether the ball's predicted position contains a lit pixel.

The target collision check is restricted to:

```text
Y >= 36
```

If a target is detected:

1. The target pixel is removed using clr_px.
2. The score increases by 10.
3. The remaining target count decreases by one.
4. The vertical ball direction is reversed.
5. The program checks whether all targets have been destroyed.

### 12.1 Score Calculation

Each destroyed target adds 10 points.

For example:

| Targets destroyed | Score |
| ----------------: | ----: |
|                 1 |    10 |
|                 5 |    50 |
|                10 |   100 |
|                20 |   200 |
|                50 |   500 |
|               100 |  1000 |
|               200 |  2000 |

### 12.2 Remaining Target Counter

The program initializes the target counter to 200.

Each successful target collision decreases it by one.

When the counter becomes zero, the program jumps to win_game.

---

## 13. Ball and Framebuffer Updating

After collision checking, the program updates the ball's position.

The update sequence is:

1. Load the previous ball coordinates.
2. Erase the previous ball pixel.
3. Load the new X coordinate.
4. Store it as the current X coordinate.
5. Load the new Y coordinate.
6. Store it as the current Y coordinate.
7. Draw the ball at its new position.
8. Execute the frame delay.
9. Return to the main loop.

This process creates the appearance of continuous ball movement.

---

## 14. Game Ending Conditions

The program contains two main termination paths.

### 14.1 Winning Condition

When the remaining target count becomes zero, the program jumps to win_game.

The win routine draws a horizontal line at:

```text
Y = 62
```

It draws pixels from X = 12 through X = 51.

After drawing the win marker, execution proceeds to game_over.

### 14.2 Game Over

The game_over routine executes:

```asm
HLT
```

This stops the TARA16 program.

### 14.3 Life Management: Current Implementation Limitation

The initialization code sets the lives variable to 3.

The source also contains a lose_life routine that:

1. Decreases the lives count.
2. Checks whether the lives count has reached zero.
3. Erases the previous ball position.
4. Resets the ball to (32,18).
5. Resets the ball direction to (1,1).
6. Draws the ball again.
7. Returns to the main loop.

However, the current bottom-boundary collision path jumps directly to game_over when the ball moves below Y = 5.

It does not call lose_life.

Therefore, the three-life mechanism is present in the source but is not connected to the current bottom-boundary game flow.

This should be corrected in a future revision if the intended design is to provide three playable lives.

---

## 15. Frame Delay

The program contains a frame_delay subroutine.

It initializes R3 to 40 and repeatedly decrements it until it reaches zero.

The routine uses:

* ADDI
* BZ
* JMP
* RET

The delay is called after the ball is updated and during the ball-reset routine.

Its purpose is to slow down execution so that the game does not update too quickly.

The delay value can be adjusted to change the apparent game speed.

---

## 16. Pixel Manipulation Subroutines

The program contains three important pixel routines.

### 16.1 set_px

Purpose: Turn on an individual pixel.

Inputs:

```text
R0 = X coordinate
R1 = Y coordinate
```

Operation:

1. Calculate the framebuffer byte address.
2. Calculate the pixel bit position.
3. Read the corresponding mask.
4. Read the framebuffer byte.
5. Apply bitwise OR.
6. Write the updated byte.

### 16.2 clr_px

Purpose: Turn off an individual pixel.

Inputs:

```text
R0 = X coordinate
R1 = Y coordinate
```

Operation:

1. Calculate the framebuffer address.
2. Calculate the pixel bit position.
3. Read the corresponding mask.
4. Invert the mask.
5. Apply bitwise AND.
6. Write the updated byte.

### 16.3 test_px

Purpose: Check whether a particular pixel is lit.

Inputs:

```text
R0 = X coordinate
R1 = Y coordinate
```

The routine reads the framebuffer byte and applies bitwise AND with the selected pixel mask.

The result is returned in R2.

If the selected pixel is not lit, R2 becomes zero.

If it is lit, R2 contains a nonzero bit mask.

---

## 17. Important TARA16 Instructions Used

| Instruction | Purpose in the project                |
| ----------- | ------------------------------------- |
| LIL         | Load lower immediate bits             |
| LIH         | Load higher immediate bits            |
| MOV         | Copy register values                  |
| ADD         | Add register values                   |
| ADDI        | Add an immediate value                |
| SUB         | Subtract register values              |
| AND         | Perform bitwise AND                   |
| OR          | Perform bitwise OR                    |
| NOT         | Invert bits                           |
| SHL         | Shift bits left                       |
| SHR         | Shift bits right                      |
| LDB         | Load a byte from memory               |
| STB         | Store a byte in memory                |
| LDW         | Load a word from memory               |
| STW         | Store a word in memory                |
| SLT         | Compare values using signed less-than |
| BZ          | Branch when the tested value is zero  |
| JMP         | Jump to a program label               |
| CALL        | Call a subroutine                     |
| RET         | Return from a subroutine              |
| HLT         | Halt program execution                |

These instructions form the foundation of the game implementation.

---

## 18. Testing and Verification

The source code was assembled using the TARA16 Python assembler.

The reported assembly result was:

| Parameter         | Result             |
| ----------------- | ------------------ |
| Source file       | brick_breaker.tara |
| Assembly status   | Successful         |
| Instruction words | 468                |
| Labels            | 33                 |
| Assembly errors   | 0                  |

An initial CPU simulation was also performed.

The reported simulation result was:

| Parameter             | Result               |
| --------------------- | -------------------- |
| Instructions executed | 10,000               |
| CPU error             | None                 |
| CPU halted            | No                   |
| Simulation limit      | 10,000 steps reached |

The program did not halt within the simulation limit, which is consistent with its continuous main loop.

However, this test alone does not verify the complete gameplay. The display, keyboard input, paddle movement, collision behavior, scoring, and winning condition require further functional testing.

---

## 19. Current Limitations and Future Improvements

The current implementation provides the basic game structure and gameplay operations.

The following improvements can be considered:

1. Connect the lose_life routine to the bottom-boundary collision path.
2. Display the current score on the screen.
3. Display the remaining lives.
4. Add a visible game-over message.
5. Add a more descriptive win screen.
6. Improve collision handling near screen boundaries.
7. Add a controlled restart mechanism.
8. Adjust the frame delay for smoother gameplay.
9. Add additional levels with different target arrangements.
10. Perform functional testing with real keyboard input and framebuffer output.

These are possible future improvements, not features that should be assumed to exist in the current source.

---

## 20. Conclusion

The Brick Breaker project demonstrates how a small interactive game can be implemented using the TARA16 instruction set architecture.

The project applies fundamental processor concepts such as register operations, memory addressing, arithmetic instructions, logical operations, conditional branching, loops, and subroutine calls.

It also demonstrates how low-level assembly instructions can be used to control a framebuffer, process keyboard input, update game state, and implement collision detection.

The project provides practical experience in assembly programming and helps connect instruction-set architecture concepts with an interactive application.

## Project Source

The complete source code is maintained in the GitHub repository under:

`02_Games/Brick_Breaker/Source/brick_breaker.tara`
