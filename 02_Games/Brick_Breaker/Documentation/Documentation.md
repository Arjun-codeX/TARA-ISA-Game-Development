# Chapter 12: Brick Breaker Game

## 12.1 Introduction

Brick Breaker is a classic arcade game in which the player controls a paddle to bounce a ball and destroy bricks.

The player moves the paddle horizontally to prevent the ball from falling below the playing area. When the ball hits a brick, the brick is removed or damaged, depending on the game design.

The main objective is to destroy all the bricks while keeping the ball inside the playing area.

Developing Brick Breaker using the TARA16 instruction set demonstrates how a custom ISA can support an interactive game application.

The game involves arithmetic operations, conditional branching, collision detection, memory management, and repeated execution.

## 12.2 Objective of the Game

The main objective is to destroy all the bricks using a bouncing ball.

The player controls the paddle to change the ball's direction and keep it moving inside the game area.

The basic objectives are:

1. Control the paddle.
2. Keep the ball inside the playing area.
3. Hit the bricks using the ball.
4. Destroy the bricks.
5. Continue playing until the game-ending condition is reached.

The player must carefully position the paddle to hit the ball and target the remaining bricks.

## 12.3 Game Components

A typical Brick Breaker game contains the following components:

| Component    | Description                                               |
| ------------ | --------------------------------------------------------- |
| Ball         | Moves around the playing area                             |
| Paddle       | Controlled by the player                                  |
| Bricks       | Objects that must be destroyed                            |
| Playing area | Defines the game boundaries                               |
| Score        | Tracks the player's performance                           |
| Lives        | Represents the number of allowed failures, if implemented |
| Game status  | Stores whether the game is running, won, or lost          |

Each component plays an important role in the game.

## 12.4 Game Layout

The playing area contains the ball, paddle, bricks, and boundaries.

A conceptual layout is shown below:

```text
+--------------------------------------+
|                                      |
|       [BRICK] [BRICK] [BRICK]        |
|       [BRICK] [BRICK] [BRICK]        |
|       [BRICK] [BRICK] [BRICK]        |
|                                      |
|                  O                   |
|                                      |
|                                      |
|             __________               |
|               PADDLE                 |
|                                      |
+--------------------------------------+
```

The ball moves within the playing area.

The paddle is controlled by the player and is generally positioned near the bottom of the screen.

The bricks are arranged in rows near the top.

## 12.5 Ball Movement

Ball movement is one of the most important parts of Brick Breaker.

The ball moves continuously in a particular direction.

Its position is represented using two coordinates:

* X-coordinate: Horizontal position.
* Y-coordinate: Vertical position.

The movement of the ball can be represented mathematically as:

```text
New X Position = Current X Position + X Velocity

New Y Position = Current Y Position + Y Velocity
```

For example:

```text
Current X = 20
X Velocity = 2

New X = 20 + 2 = 22
```

The ball moves two position units horizontally.

Similarly, vertical movement is calculated using the Y-coordinate and Y-velocity.

The direction of movement changes when the ball collides with boundaries, the paddle, or bricks.

## 12.6 Paddle Control

The paddle allows the player to control the ball.

The player can move the paddle horizontally.

The paddle must remain inside the playing area.

A typical paddle-control algorithm is:

```text
Read Player Input

If Move Left:
    Decrease Paddle X Position

If Move Right:
    Increase Paddle X Position

Check Left Boundary

Check Right Boundary

Update Paddle Position
```

The paddle should not move outside the game boundaries.

The actual input method depends on the game implementation.

## 12.7 Collision Detection

Collision detection determines whether two game objects have touched or overlapped.

In Brick Breaker, the main collision checks involve:

1. Ball and left boundary.
2. Ball and right boundary.
3. Ball and top boundary.
4. Ball and paddle.
5. Ball and bricks.

Collision detection is important because it controls the movement of the ball and the destruction of bricks.

### 12.7.1 Boundary Collision

When the ball touches the left or right boundary, its horizontal direction changes.

Conceptually:

```text
If Ball Reaches Left Boundary:
    Reverse Horizontal Direction

If Ball Reaches Right Boundary:
    Reverse Horizontal Direction
```

The ball should remain inside the playing area.

### 12.7.2 Top Boundary Collision

When the ball reaches the top boundary, its vertical direction changes.

Conceptually:

```text
If Ball Reaches Top Boundary:
    Reverse Vertical Direction
```

This causes the ball to move downward.

### 12.7.3 Paddle Collision

When the ball collides with the paddle, its vertical direction changes.

The paddle may also influence the horizontal direction, depending on the game design.

Conceptually:

```text
Check Ball and Paddle Collision

If Collision Detected:
    Reverse Vertical Direction
    Update Ball Direction
```

This allows the player to control the ball using paddle positioning.

### 12.7.4 Brick Collision

When the ball hits a brick, the game detects the collision.

A typical brick collision process is:

1. Identify the brick.
2. Check whether the brick is active.
3. Detect the collision.
4. Update the ball direction.
5. Remove or damage the brick.
6. Update the score, if scoring is implemented.

The collision algorithm must avoid repeatedly registering the same collision while the ball remains inside a brick.

The exact collision-response method depends on the implementation.

## 12.8 Brick Management

Bricks are the main targets in the game.

Each brick can be represented by information such as:

* Horizontal position.
* Vertical position.
* Width.
* Height.
* Active or destroyed status.

A brick can be represented conceptually as:

```text
Brick:
    X Position
    Y Position
    Width
    Height
    Status
```

The status indicates whether the brick is still present.

For example:

```text
Status = 1  -> Brick Active
Status = 0  -> Brick Destroyed
```

This is an illustrative representation. The actual data structure depends on the source code.

The game checks active bricks during collision detection.

When all required bricks are destroyed, the player wins.

## 12.9 Score Management

A scoring system can be used to measure the player's performance.

When a brick is successfully destroyed, the score can be increased.

For example:

```text
Initial Score = 0

Brick Destroyed:
    Score = Score + 10
```

If ten bricks are destroyed and each brick gives 10 points:

```text
Final Score = 10 × 10

Final Score = 100
```

The actual scoring value and whether the game includes a scoring system must be confirmed from the source implementation.

## 12.10 Game States

Game-state management controls the different stages of the application.

A typical Brick Breaker implementation may contain the following states:

| State   | Description                                 |
| ------- | ------------------------------------------- |
| Start   | Initializes the game                        |
| Ready   | Waits for the game to begin                 |
| Playing | Ball and paddle are active                  |
| Paused  | Temporarily stops gameplay, if supported    |
| Won     | All required bricks have been destroyed     |
| Lost    | The player has reached the losing condition |

The game state determines which operations should be performed.

For example, ball movement should occur during active gameplay rather than during initialization.

## 12.11 Losing Condition

A common Brick Breaker rule is that the player loses a life when the ball falls below the paddle.

If the game supports multiple lives, the remaining life count is reduced.

Conceptually:

```text
If Ball Falls Below Paddle:
    Reduce Remaining Lives

    If Lives == 0:
        Game Over
    Else:
        Reset Ball Position
```

The exact number of lives, reset behavior, and losing condition must be confirmed from the actual game implementation.

## 12.12 Winning Condition

The player wins when all required bricks have been destroyed.

The game checks the status of the bricks.

Conceptually:

```text
Check All Bricks

If No Active Bricks Remain:
    Declare Player Winner
    Stop Gameplay
```

The winning condition provides a clear endpoint for the game.

## 12.13 Game Execution Flow

The following flowchart explains the general execution sequence.

```text
+--------------------------+
|       Start Game         |
+------------+-------------+
             |
             v
+--------------------------+
| Initialize Game Objects  |
+------------+-------------+
             |
             v
+--------------------------+
| Initialize Ball/Paddle  |
+------------+-------------+
             |
             v
+--------------------------+
| Read Player Input        |
+------------+-------------+
             |
             v
+--------------------------+
| Update Paddle Position   |
+------------+-------------+
             |
             v
+--------------------------+
| Update Ball Position     |
+------------+-------------+
             |
             v
+--------------------------+
| Check Boundary Collision |
+------------+-------------+
             |
             v
+--------------------------+
| Check Paddle Collision   |
+------------+-------------+
             |
             v
+--------------------------+
| Check Brick Collision    |
+------------+-------------+
             |
             v
+--------------------------+
| Update Brick and Score   |
+------------+-------------+
             |
             v
+--------------------------+
| Check Winning Condition  |
+------------+-------------+
             |
       +-----+-----+
       |           |
      Yes          No
       |           |
       v           v
+-------------+  +------------------+
| Game Won    |  | Check Losing      |
+-------------+  | Condition         |
                 +--------+---------+
                          |
                     +----+----+
                     |         |
                    Yes        No
                     |         |
                     v         v
                +---------+  +----------------+
                | Game    |  | Continue Game  |
                | Over    |  +-------+--------+
                +---------+          |
                                     |
                                     +----> Repeat
```

This flowchart represents a general game structure. The actual source may use a different sequence or combine several operations.

## 12.14 Algorithms Used in the Game

### 12.14.1 Ball Position Update

The ball's position is updated using its velocity.

```text
Read Current Ball Position

Calculate New X Position

Calculate New Y Position

Update Ball Coordinates
```

### 12.14.2 Paddle Movement

The paddle position is updated according to player input.

```text
Read Input

If Left:
    Move Paddle Left

If Right:
    Move Paddle Right

Check Game Boundaries

Update Paddle
```

### 12.14.3 Collision Detection

The game checks whether the ball overlaps with another object.

For rectangular objects, collision can be checked using their coordinate ranges.

For example, two rectangular objects overlap when their horizontal and vertical ranges intersect.

The exact collision equations depend on how the ball and game objects are represented.

### 12.14.4 Brick Destruction

```text
Check Ball and Brick Collision

If Brick Is Active:
    Update Ball Direction
    Mark Brick Destroyed
    Update Score
```

### 12.14.5 Game Completion

```text
Check Remaining Bricks

If All Required Bricks Are Destroyed:
    Set Game Status to Won
```

## 12.15 TARA16 Instructions Used in the Game

The Brick Breaker application can demonstrate several categories of TARA16 instructions.

| Instruction | Possible Application                    |
| ----------- | --------------------------------------- |
| MOV         | Transfer game values between registers  |
| LIL         | Load immediate values                   |
| LIH         | Load upper immediate values             |
| ADD         | Update ball and paddle coordinates      |
| SUB         | Calculate coordinate differences        |
| ADDI        | Update positions using immediate values |
| MUL         | Perform multiplication when required    |
| AND         | Perform bitwise operations              |
| OR          | Perform bitwise operations              |
| XOR         | Perform bitwise operations              |
| NOT         | Perform bitwise complement              |
| SHL         | Shift values left                       |
| SHR         | Shift values right                      |
| SLT         | Compare values                          |
| BZ          | Implement zero-related conditions       |
| BN          | Implement negative-related conditions   |
| JMP         | Repeat game operations                  |
| CALL        | Execute a subroutine                    |
| RET         | Return from a subroutine                |
| LDW         | Load game data from memory              |
| STW         | Store game data in memory               |

These are possible uses based on the recorded instruction set. The actual instruction sequence must be identified from the Brick Breaker source code.

## 12.16 Programming Concepts Demonstrated

The Brick Breaker application demonstrates several important programming concepts.

### Arithmetic Operations

Arithmetic instructions are used to update ball and paddle positions.

### Conditional Branching

Conditional operations are required to detect collisions, check boundaries, and evaluate game-ending conditions.

### Loops

The game repeatedly updates the ball, paddle, and game state until the game ends.

### Memory Management

The program must maintain information about game objects, coordinates, brick status, and other game data.

### Collision Detection

Collision detection uses coordinate comparisons to determine whether objects have touched or overlapped.

### State Management

The game maintains information about whether it is running, paused, won, or lost.

### Subroutines

Separate routines can be used for movement, collision detection, score updates, and game-state checking.

## 12.17 Testing the Game

Testing is required to verify that the game behaves correctly.

The following test cases can be used:

| Test Case                   | Expected Result                        |
| --------------------------- | -------------------------------------- |
| Start the game              | Game objects are initialized           |
| Move paddle left            | Paddle moves left within the boundary  |
| Move paddle right           | Paddle moves right within the boundary |
| Ball reaches left boundary  | Horizontal direction changes           |
| Ball reaches right boundary | Horizontal direction changes           |
| Ball reaches top boundary   | Vertical direction changes             |
| Ball hits paddle            | Ball changes direction                 |
| Ball hits a brick           | Brick collision is processed           |
| Brick is destroyed          | Brick status is updated                |
| Ball falls below paddle     | Losing condition is processed          |
| All bricks are destroyed    | Winning condition is activated         |

The actual expected results should be adjusted to match the implemented game rules.

## 12.18 Importance of Brick Breaker in TARA16

Brick Breaker is useful for demonstrating how an instruction set can support an interactive application.

Unlike a simple arithmetic program, this game requires repeated calculations and decisions.

The application combines:

* Coordinate calculations.
* Conditional branching.
* Collision detection.
* Memory operations.
* Repeated execution.
* Game-state management.

It provides an example of how basic processor instructions can be combined to implement a more complex program.

## 12.19 Conclusion

The Brick Breaker game demonstrates the use of arithmetic, logical, memory, and control-flow operations in an interactive application.

The program must continuously update the ball and paddle positions, detect collisions, manage bricks, and check the winning or losing conditions.

Developing this application using TARA16 helps students understand how individual instructions work together to execute a complete program.

It also provides practical experience in algorithms, coordinate calculations, conditional branching, and application development.
