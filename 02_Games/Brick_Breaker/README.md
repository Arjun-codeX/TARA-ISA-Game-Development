# TARA16 Brick Breaker Game

## 1. Project Introduction

Brick Breaker is a classic arcade game implemented using the TARA16 instruction set architecture.

The player controls a paddle to keep a moving ball inside the playing area. The ball bounces off boundaries and destroys targets when it makes contact with them.

The complete game is written in TARA16 assembly language. It demonstrates how low-level assembly instructions can be used to develop an interactive game.

## 2. Project Objectives

* Understand TARA16 assembly language programming.
* Implement ball movement and paddle control.
* Develop wall and paddle collision detection.
* Implement target detection and scoring.
* Understand framebuffer-based graphics.
* Process keyboard input.
* Practice memory operations, arithmetic, loops, and subroutines.

## 3. Project Specifications

| Parameter               | Implementation       |
| ----------------------- | -------------------- |
| Architecture            | TARA16               |
| Programming language    | TARA16 Assembly      |
| Display resolution      | 64 × 64 pixels       |
| Display type            | Monochrome           |
| Framebuffer             | 0x0600–0x07FF        |
| Keyboard input          | 0x05FF               |
| Total targets           | 200                  |
| Target arrangement      | 20 columns × 10 rows |
| Initial score           | 0                    |
| Initial lives           | 3                    |
| Points per target       | 10                   |
| Initial ball position   | (32, 18)             |
| Initial paddle position | X = 26, Y = 4        |

## 4. Game Objective

The objective is to destroy all 200 targets using the moving ball.

The player moves the paddle horizontally to prevent the ball from leaving the playing area.

Each destroyed target increases the score by 10 points.

The game contains a winning condition when all targets have been destroyed.

## 5. Keyboard Controls

| Control | Function          |
| ------- | ----------------- |
| LEFT    | Move paddle left  |
| RIGHT   | Move paddle right |
| QUIT    | Stop the game     |

Keyboard input is read from memory address `0x05FF`.

The input bits are:

* Bit 2: LEFT
* Bit 3: RIGHT
* Bit 4: QUIT

## 6. Game Architecture

The program contains the following major operations:

1. Initialize registers and game variables.
2. Clear the framebuffer.
3. Initialize the pixel mask table.
4. Generate 200 targets.
5. Initialize the paddle and ball.
6. Read keyboard input.
7. Update paddle position.
8. Calculate ball movement.
9. Detect wall collisions.
10. Detect paddle collisions.
11. Detect target collisions.
12. Update the score and remaining-target count.
13. Update the framebuffer.
14. Repeat the game loop.

## 7. Ball Movement

The ball is represented by a single pixel.

Its initial position is:

```text
X = 32
Y = 18
```

Its initial direction is:

```text
DX = 1
DY = 1
```

The program updates the ball coordinates using its horizontal and vertical direction values.

When a collision occurs, the appropriate direction is reversed.

## 8. Paddle Control

The paddle is positioned near the lower part of the display.

The player can move it horizontally using LEFT and RIGHT keyboard inputs.

The program checks the ball's horizontal position to determine whether it lands within the paddle's range.

## 9. Collision Detection

The game implements different collision checks:

* Left and right screen boundaries.
* Top screen boundary.
* Paddle collision.
* Target collision.

When the ball hits a target, the target pixel is removed and the score is updated.

## 10. Target Management and Scoring

The game contains 200 targets arranged in 20 columns and 10 rows.

Each target is represented by a framebuffer pixel.

When a target is destroyed:

* Its pixel is cleared.
* The score increases by 10.
* The remaining-target counter decreases by one.

When the remaining-target counter reaches zero, the program executes the winning routine.

## 11. Display and Framebuffer

The game uses a 64 × 64 monochrome display.

Framebuffer memory:

```text
Start address: 0x0600
End address:   0x07FF
Size:          512 bytes
```

Each pixel requires one bit.

The program uses memory addressing and bitwise operations to set, clear, and test individual pixels.

## 12. Important TARA16 Assembly Instructions

The project uses instructions for:

* Register operations.
* Immediate value loading.
* Arithmetic calculations.
* Bitwise operations.
* Memory access.
* Conditional branching.
* Loops and jumps.
* Subroutine calls and returns.
* Program termination.

These instructions are used to implement game logic and framebuffer operations.

## 13. Source Code

Main source file:

`Source/brick_breaker.tara`

The source contains the complete assembly implementation, including initialization, target generation, paddle movement, ball movement, collision detection, scoring, and pixel manipulation routines.

## 14. Build and Simulation

The source was assembled using the TARA16 Python assembler.

Observed assembly results:

| Parameter         | Result     |
| ----------------- | ---------- |
| Assembly status   | Successful |
| Instruction words | 468        |
| Labels            | 33         |
| Assembly errors   | 0          |

An initial CPU simulation was performed for 10,000 instructions.

Observed results:

| Parameter             | Result  |
| --------------------- | ------- |
| Instructions executed | 10,000  |
| CPU error             | None    |
| CPU halted            | No      |
| Simulation limit      | Reached |

The simulation confirms that the program executed without a reported CPU error for the tested instruction count. Complete gameplay still requires functional testing.

## 15. Current Limitations

The source initializes three lives and contains a `lose_life` routine.

However, the current bottom-boundary collision path jumps directly to `game_over` instead of calling `lose_life`.

Therefore, the three-life mechanism is not fully connected to the current game flow.

Other possible improvements include:

* Displaying the score.
* Displaying remaining lives.
* Adding a visible game-over screen.
* Improving collision handling.
* Adding a restart mechanism.
* Testing with actual keyboard input and framebuffer output.

## 16. Project Structure

```text
Brick_Breaker/
│
├── README.md
│
├── Source/
│   └── brick_breaker.tara
│
├── Documentation/
│   └── Documentation.md
│
└── Screenshots/
```

## 17. Conclusion

The TARA16 Brick Breaker project demonstrates how assembly language can be used to implement an interactive arcade game.

It provides practical experience with processor instructions, memory management, keyboard input, framebuffer graphics, ball movement, collision detection, and scoring.

The project also provides a foundation for implementing additional gameplay features and improving the overall game experience.

