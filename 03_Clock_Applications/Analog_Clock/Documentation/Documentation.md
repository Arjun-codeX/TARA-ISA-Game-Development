# Chapter 14: Analog Clock

## 14.1 Introduction

An analog clock is a time-display application that represents time using rotating hands instead of numerical digits.

A traditional analog clock contains three hands:

1. Hour hand
2. Minute hand
3. Second hand

These hands rotate around a common center point on the clock face.

The hour hand indicates the current hour, the minute hand indicates the minutes, and the second hand indicates the seconds.

In this project, an analog clock is implemented using the TARA16 instruction set. The program demonstrates how arithmetic operations, conditional branching, loops, and display updates can be combined to create a graphical clock application.

Unlike a digital clock, which displays numerical values, an analog clock represents time through the positions of its hands.

## 14.2 Objective of the Analog Clock

The main objective is to develop an analog clock that displays time using three moving hands.

The application should:

1. Create a clock face.
2. Display the hour, minute, and second hands.
3. Maintain the current time.
4. Update the second hand continuously.
5. Update the minute hand when required.
6. Update the hour hand according to the passage of time.
7. Maintain the correct relative positions of all three hands.
8. Refresh the display when the hands move.

This project demonstrates how a custom ISA can be used to implement a graphical application.

## 14.3 Components of an Analog Clock

An analog clock consists of several important components.

| Component      | Purpose                                     |
| -------------- | ------------------------------------------- |
| Clock face     | Provides the background for displaying time |
| Center point   | Common rotation point of all hands          |
| Hour hand      | Indicates the hour                          |
| Minute hand    | Indicates the minutes                       |
| Second hand    | Indicates the seconds                       |
| Clock markings | Represent time positions                    |
| Display area   | Shows the complete clock                    |

Each hand has a different length and moves at a different speed.

The second hand moves fastest, followed by the minute hand and then the hour hand.

## 14.4 Clock Face Organization

The clock face is generally circular.

It contains twelve main hour positions, numbered from 1 to 12.

These positions are equally spaced around the circle.

The clock face can also contain sixty smaller positions representing individual seconds and minutes.

The main positions are:

```text
                  12
            11          1

        10                  2

      9          CENTER       3

         8                4

             7        5
                  6
```

The clock center acts as the reference point for all three hands.

In the TARA16 analog clock implementation, the clock face uses fixed outer dots and separate positions for the moving hands.

## 14.5 Hour Hand

The hour hand is the shortest hand on the clock.

It indicates the current hour.

For example, when the clock displays 10:00, the hour hand points towards 10.

The hour hand moves slowly because it takes twelve hours to complete one full revolution.

Its position changes gradually as the minutes pass.

## 14.6 Minute Hand

The minute hand is longer than the hour hand.

It indicates the current minute.

The minute hand completes one full revolution every sixty minutes.

Each minute corresponds to one of the sixty positions around the clock face.

For example:

* At 12:00, it points towards 12.
* At 12:15, it points towards 3.
* At 12:30, it points towards 6.
* At 12:45, it points towards 9.

The minute hand moves faster than the hour hand.

## 14.7 Second Hand

The second hand is generally the longest hand.

It indicates the current seconds.

It completes one full revolution every sixty seconds.

Each second corresponds to one position around the clock face.

For example:

```text
Seconds = 0   -> Position 0
Seconds = 15  -> Position 15
Seconds = 30  -> Position 30
Seconds = 45  -> Position 45
```

The second hand moves faster than the other two hands.

## 14.8 Clock Hand Lengths

The three hands have different lengths so that they can be distinguished easily.

The previously discussed TARA16 analog clock implementation uses approximately the following dimensions:

| Hand        | Approximate Length |
| ----------- | -----------------: |
| Second hand |           24 units |
| Minute hand |           18 units |
| Hour hand   |            9 units |

The second hand is the longest, while the hour hand is the shortest.

These dimensions help distinguish the hands visually.

The exact pixel or display-unit interpretation depends on the graphics implementation.

## 14.9 Time Representation

The clock maintains three primary time values:

* Hours
* Minutes
* Seconds

For example:

```text
Hours   = 10
Minutes = 10
Seconds = 00
```

The displayed time is:

```text
10:10:00
```

Each time value determines the position of its corresponding hand.

The initial time used in the previously discussed TARA16 analog clock program is 10:10:00.

This starting time separates the three hands visually and makes their positions easier to observe.

## 14.10 Hand Position Calculation

The TARA16 Analog Clock uses a lookup-table-based method to calculate the positions of the clock hands.

Instead of calculating sine and cosine values using multiplication and trigonometric functions, the program stores predefined coordinate vectors in memory.

The clock uses a 64 × 64 monochrome display.

The centre of the clock is:

* Centre X = 32
* Centre Y = 32

The coordinate vectors are stored starting at memory address `0x0440`.

Each vector contains two values:

* X displacement
* Y displacement

The program uses quadrant rotation to generate all 60 positions from the stored coordinate vectors.

### Fixed-point representation

The coordinates use a fixed-point representation with five fractional bits.

This allows the program to maintain fractional coordinate values during hand drawing.

The initial coordinate value is `0x0410`, which represents the clock centre with half-pixel precision.

## 14.11 Second Hand Position

The second hand has 60 possible positions.

Each second corresponds to one position around the clock face.

The position index ranges from 0 to 59.

The second-hand type is represented by:

```text
R5 = 0
```

The second hand uses the original lookup-table vector without additional scaling.

Its nominal radius is 24 pixels.

Whenever the seconds counter increases, the second hand moves to the corresponding position.

After reaching 59, the next update resets the counter to zero.

## 14.12 Minute Hand Position

The minute hand also has 60 possible positions.

Its position is determined by the current minute value.

The minute-hand type is represented by:

```text
R5 = 1
```

The program scales the lookup-table vector to approximately 75% of the second-hand vector.

Therefore:

```text
Minute radius = 24 × 0.75
              = 18 pixels
```

The minute hand moves when the seconds counter completes a full cycle.

After 59 minutes, the next update resets the minute counter to zero and increments the hour counter.

## 14.13 Hour Hand Position

The hour hand has 12 main positions.

Its type is represented by:

```text
R5 = 2
```

The program converts the hour value into a 60-position index.

The conversion is:

```text
Hour index = Hour value × 5
```

Each hour position is therefore separated by five positions in the 60-position coordinate system.

The hour-hand vector is scaled to approximately 37.5% of the original vector.

Therefore:

```text
Hour radius = 24 × 0.375
            = 9 pixels
```

The program updates the hour counter after the minute counter completes its cycle.

The hour counter ranges from 0 to 11.

A stored hour value of zero represents the 12 o'clock position.

The current implementation advances the hour hand in discrete hourly steps. It does not continuously interpolate the hand position using minutes.

## 14.14 Clock Display Updating

The clock display is updated continuously using the main loop.

The main loop performs the following operations:

1. Enable pixel drawing mode.
2. Draw the hour hand.
3. Draw the minute hand.
4. Draw the second hand.
5. Execute the software delay loop.
6. Disable pixel drawing mode.
7. Erase the previous second-hand position.
8. Erase the minute hand when the seconds value reaches 59.
9. Erase the hour hand when both seconds and minutes reach 59.
10. Update the time counters.
11. Repeat the process.

The `THREE_HANDS` routine draws all three hands.

The `HAND` routine calculates the required coordinate vectors and draws the selected hand.

This approach allows the display to be updated without clearing the entire clock face on every iteration.

## 14.15 Selective Hand Erasure

Selective hand erasure prevents unwanted trails when the clock hands move.

The program uses a drawing-mode variable stored at:

```text
R7 + 24
```

The drawing modes are:

| Value | Operation   |
| ----- | ----------- |
| 1     | Set pixel   |
| 0     | Clear pixel |

The `PIXEL` routine checks this mode before modifying framebuffer memory.

When drawing mode is enabled, the pixel mask is combined with the existing framebuffer byte using a bitwise OR operation.

When drawing mode is disabled, the mask is inverted and combined with the framebuffer byte using a bitwise AND operation.

The fixed clock-face markings are not deliberately erased during normal hand updates.

## 14.16 Clock Execution Flow

The actual execution flow of the TARA16 Analog Clock is:

```text
          START
            |
            v
     Initialize R7
            |
            v
     Initialize Time
       12:00:00
            |
            v
   Build Pixel Mask Table
            |
            v
   Build Coordinate Table
            |
            v
     Clear Framebuffer
            |
            v
     Draw Clock Markings
            |
            v
       MAIN LOOP
            |
            v
    Enable Drawing Mode
            |
            v
      Draw Three Hands
            |
            v
      Software Delay
            |
            v
    Disable Drawing Mode
            |
            v
      Erase Old Hands
            |
            v
       Update Seconds
            |
            v
     Check Minute Rollover
            |
            v
      Check Hour Rollover
            |
            v
       Repeat MAIN LOOP
```

The program starts with an initial time of 12:00:00 and continuously executes the main loop.

## 14.17 TARA16 Instructions Used in the Analog Clock

The following instructions are used in the actual assembly source.

| Instruction | Application                                        |
| ----------- | -------------------------------------------------- |
| JMP         | Transfers execution to another instruction address |
| LIL         | Loads the lower immediate value                    |
| LIH         | Loads the upper immediate value                    |
| MOV         | Copies data between registers                      |
| ADD         | Performs addition                                  |
| ADDI        | Adds an immediate value                            |
| SUB         | Performs subtraction                               |
| SHL         | Performs left shifting                             |
| SHR         | Performs right shifting                            |
| AND         | Performs bitwise AND                               |
| OR          | Performs bitwise OR                                |
| NOT         | Performs bitwise complement                        |
| BZ          | Branches when a register value is zero             |
| BN          | Branches when a register value is negative         |
| CALL        | Calls a subroutine                                 |
| RET         | Returns from a subroutine                          |
| LDW         | Loads a word from memory                           |
| STW         | Stores a word in memory                            |
| LDB         | Loads a byte from memory                           |
| STB         | Stores a byte in memory                            |

These instructions are used for time management, coordinate calculation, memory access, pixel operations, and program control.

## 14.18 Important Programming Concepts Demonstrated

### Coordinate Geometry

The clock uses X and Y coordinates to represent the positions of its hands.

### Lookup Tables

Predefined coordinate vectors are stored in memory to avoid calculating trigonometric functions during execution.

### Quadrant Rotation

The program uses quadrant-based coordinate transformation to generate positions around the complete clock face.

### Fixed-Point Arithmetic

Five fractional bits are used to maintain precision during coordinate calculations.

### Arithmetic Operations

Addition, subtraction, and shifting operations are used for vector scaling and time updates.

### Conditional Branching

Conditional branches control hand positioning, counter updates, and rollover conditions.

### Loops and Subroutines

The program uses loops and subroutines to draw pixels, generate hand positions, and continuously update the clock.

### Framebuffer Management

The framebuffer stores the graphical output of the clock.

### Selective Pixel Erasure

The program clears previous hand pixels while preserving fixed clock markings.

## 14.19 Testing the Analog Clock

The Analog Clock was assembled and executed using the TARA16 assembler and CPU simulator.

### Assembly Results

| Parameter         | Result                   |
| ----------------- | ------------------------ |
| Source file       | tara16_analog_clock.tara |
| Assembly status   | Successful               |
| Instruction words | 334                      |
| Labels            | 25                       |
| Assembly errors   | None                     |

### CPU Simulation Results

The program was executed for 100,000 instructions.

| Parameter                   | Result  |
| --------------------------- | ------- |
| Instructions executed       | 100,000 |
| CPU halted                  | No      |
| CPU error                   | None    |
| Program counter             | 0x246   |
| Seconds counter             | 15      |
| Minutes counter             | 0       |
| Hours counter               | 0       |
| Non-zero framebuffer pixels | 54      |

The observed clock state was:

```text
12:00:15
```

### Framebuffer Verification

The framebuffer was inspected by reading memory addresses from:

```text
0x0600 – 0x07FF
```

The memory contents were converted into a 64 × 64 text-based pixel representation.

The output showed clock markings and hand pixels.

This confirms that the program writes graphical data into the framebuffer.

The simulation results demonstrate successful assembly and CPU execution. They do not independently establish the correctness of every hand position.

## 14.20 Timing Accuracy

The program uses a software delay loop to control the interval between display updates.

The delay routine uses a register counter that is repeatedly decremented until it reaches zero.

The delay is implemented using instructions rather than a calibrated hardware timer.

Therefore, the simulation execution count must not be interpreted as real-world seconds.

The current implementation demonstrates time-counter updates and hand movement logic, but accurate real-time operation has not been established.

A hardware timer or calibrated timing source would be required for reliable wall-clock timing.

## 14.21 Testing and Debugging

The following checks are useful when testing the Analog Clock:

1. Verify the initial time values.
2. Check the coordinate lookup table.
3. Verify quadrant rotation.
4. Inspect the X and Y coordinates generated by the HAND routine.
5. Check the drawing-mode variable.
6. Verify framebuffer addresses.
7. Check second, minute, and hour rollover.
8. Inspect old-hand erasure.
9. Check that fixed clock markings remain visible.
10. Monitor CPU errors and program execution.

The TARA16 simulator can be used to inspect registers, memory, and program execution.

## 14.22 Applications of Analog Clocks

The concepts demonstrated in this project are useful in:

* Embedded display applications.
* Digital watch interfaces.
* Graphical user interfaces.
* FPGA-based display systems.
* Educational processor projects.
* Custom instruction-set demonstrations.

The project provides practical experience in combining processor instructions, coordinate geometry, lookup tables, and framebuffer operations.

## 14.23 Conclusion

The TARA16 Analog Clock demonstrates how a custom instruction set can be used to develop a graphical application.

The program maintains hour, minute, and second counters and converts their values into coordinate positions for three clock hands.

A lookup table and quadrant-based transformation are used to generate hand positions.

The program also demonstrates fixed-point arithmetic, memory access, subroutine calls, framebuffer management, and selective pixel erasure.

The source successfully assembled into 334 instruction words and executed for 100,000 instructions without a CPU error.

This project provides practical experience in developing graphical applications using a custom processor architecture.
