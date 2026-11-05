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

The position of each hand is calculated relative to the center of the clock.

In a coordinate-based display, a point is represented using:

* X-coordinate: Horizontal position.
* Y-coordinate: Vertical position.

The clock center is represented by:

```text
Center X = CX
Center Y = CY
```

The hand endpoint is calculated using its length and angular position.

The general mathematical equations are:

```text
X = CX + R × cos(angle)

Y = CY + R × sin(angle)
```

Where:

* CX is the center X-coordinate.
* CY is the center Y-coordinate.
* R is the hand length.
* angle is the angular position.

The sign and orientation of the coordinates depend on the display coordinate system.

These equations are commonly used in graphical applications to calculate points along a circle.

For an implementation using a lookup table or predefined positions, the program may obtain the coordinates directly instead of calculating trigonometric functions.

## 14.11 Second Hand Position

The second hand has sixty possible positions.

Each second changes its angular position by six degrees.

The relationship is:

```text
360 degrees / 60 seconds = 6 degrees
```

Therefore:

```text
Second Angle = Seconds × 6 degrees
```

For example:

| Seconds | Angular Position |
| ------- | ---------------: |
| 0       |               0° |
| 15      |              90° |
| 30      |             180° |
| 45      |             270° |
| 59      |             354° |

After the sixtieth position, the second hand returns to its starting position.

The TARA16 implementation previously discussed uses sixty second positions.

## 14.12 Minute Hand Position

The minute hand also has sixty positions.

Each minute changes its angular position by six degrees.

The relationship is:

```text
360 degrees / 60 minutes = 6 degrees
```

Therefore:

```text
Minute Angle = Minutes × 6 degrees
```

For example:

| Minutes | Angular Position |
| ------- | ---------------: |
| 0       |               0° |
| 15      |              90° |
| 30      |             180° |
| 45      |             270° |
| 59      |             354° |

The minute hand completes one revolution every sixty minutes.

## 14.13 Hour Hand Position

The hour hand has twelve main positions.

Each hour position corresponds to thirty degrees.

The relationship is:

```text
360 degrees / 12 hours = 30 degrees
```

Therefore:

```text
Hour Angle = Hours × 30 degrees
```

For a traditional clock, the hour hand also moves gradually as the minutes pass.

A more accurate angular relationship is:

```text
Hour Angle = (Hours mod 12 × 30) + (Minutes × 0.5)
```

For example, at 10:30:

```text
Hour Angle = (10 × 30) + (30 × 0.5)

Hour Angle = 300 + 15

Hour Angle = 315 degrees
```

This means the hour hand moves halfway between the 10 and 11 positions.

The exact calculation used in the TARA16 program should be confirmed from its source.

## 14.14 Clock Display Updating

An analog clock must update the positions of its hands whenever the time changes.

When the second hand moves, its previous position must be erased before its new position is displayed.

Otherwise, the clock will show unwanted trails.

A general display-update process is:

1. Store the previous hand positions.
2. Erase the previous hand graphics.
3. Update the time values.
4. Calculate or retrieve the new hand positions.
5. Draw the hour hand.
6. Draw the minute hand.
7. Draw the second hand.
8. Repeat the process.

The clock face markings should remain visible while the hands move.

The previously discussed TARA16 analog clock implementation uses selective hand erasure and fixed outer dots.

This approach helps preserve the clock face while updating the moving hands.

## 14.15 Selective Hand Erasure

Selective hand erasure is important for maintaining a clean clock display.

When a hand moves, its previous drawing must be removed.

However, erasing the entire clock face would also remove the fixed clock markings.

Therefore, the program must remove only the pixels or display positions occupied by the previous hand.

The general process is:

```text
Store Previous Hand Position

Erase Previous Hand

Calculate New Hand Position

Draw New Hand
```

This operation is repeated whenever the hand moves.

In the previously discussed implementation, selective erasure is used instead of repeatedly clearing the complete clock face.

## 14.16 Clock Execution Flow

The general execution flow of an analog clock is:

```text
+--------------------------+
|       Start Clock        |
+------------+-------------+
             |
             v
+--------------------------+
| Initialize Clock Face    |
+------------+-------------+
             |
             v
+--------------------------+
| Initialize Time Values   |
+------------+-------------+
             |
             v
+--------------------------+
| Draw Fixed Clock Markings|
+------------+-------------+
             |
             v
+--------------------------+
| Draw Three Clock Hands   |
+------------+-------------+
             |
             v
+--------------------------+
| Wait for Next Time Update|
+------------+-------------+
             |
             v
+--------------------------+
| Erase Previous Hands     |
+------------+-------------+
             |
             v
+--------------------------+
| Update Time Values       |
+------------+-------------+
             |
             v
+--------------------------+
| Calculate New Positions  |
+------------+-------------+
             |
             v
+--------------------------+
| Draw Updated Hands       |
+------------+-------------+
             |
             v
+--------------------------+
| Repeat Clock Operation   |
+--------------------------+
```

This flowchart describes the general display-update process. The actual program may use a different internal sequence.

## 14.17 TARA16 Instructions Used in the Analog Clock

The analog clock can demonstrate different categories of TARA16 instructions.

| Instruction | Possible Application                             |
| ----------- | ------------------------------------------------ |
| MOV         | Transfer coordinates and time values             |
| LIL         | Load immediate values                            |
| LIH         | Load upper immediate values                      |
| ADD         | Calculate coordinate positions                   |
| SUB         | Calculate coordinate differences                 |
| ADDI        | Increment time values                            |
| MUL         | Perform multiplication for position calculations |
| AND         | Perform bitwise operations                       |
| OR          | Perform bitwise operations                       |
| XOR         | Perform bitwise operations                       |
| NOT         | Perform bitwise complement                       |
| SHL         | Shift values left                                |
| SHR         | Shift values right                               |
| SLT         | Perform comparisons                              |
| BZ          | Implement zero-related conditions                |
| BN          | Implement negative-related conditions            |
| JMP         | Repeat clock operations                          |
| CALL        | Call a subroutine                                |
| RET         | Return from a subroutine                         |
| LDW         | Load clock-related data                          |
| STW         | Store clock-related data                         |

These are possible uses based on the recorded instruction set. The actual instruction sequence must be identified from the analog clock source code.

## 14.18 Important Programming Concepts Demonstrated

The analog clock demonstrates several programming concepts.

### Coordinate Geometry

The position of each hand is calculated relative to the clock center.

### Arithmetic Operations

Arithmetic calculations are used to determine time values and hand positions.

### Conditional Branching

Conditional operations help control time updates and position changes.

### Loops

The program continuously updates the clock display.

### Memory Management

The program maintains the current time and previous hand positions.

### Display Management

The program must erase old hand positions and draw new ones without disturbing fixed clock markings.

### Angle and Position Mapping

The relationship between time values and angular positions is used to represent time visually.

## 14.19 Testing the Analog Clock

Testing verifies whether the clock displays time correctly.

The following test cases are useful:

| Test Case                 | Expected Result                             |
| ------------------------- | ------------------------------------------- |
| Initialize clock          | Clock face and three hands are displayed    |
| Start at 10:10:00         | Hands appear at the corresponding positions |
| Update seconds            | Second hand moves to the next position      |
| Update minutes            | Minute hand moves correctly                 |
| Update hours              | Hour hand advances correctly                |
| Reach 60 seconds          | Second hand completes one revolution        |
| Reach 60 minutes          | Minute hand completes one revolution        |
| Reach 12 hours            | Hour hand completes one revolution          |
| Move a hand               | Previous hand position is erased            |
| Update display repeatedly | Fixed clock markings remain visible         |

Additional testing should verify that the hands do not leave unwanted trails and that their positions remain consistent with the stored time.

## 14.20 Timing Accuracy

An analog clock must use a suitable timing mechanism to maintain accurate time.

The second hand should advance once every real-world second.

However, a software simulation may execute much faster or slower than real time.

If the program uses simulation ticks or instruction counts, these should not automatically be interpreted as calibrated seconds.

A reliable real-time implementation requires a suitable timing source, such as:

* Hardware timer.
* Timer interrupt.
* Real-time clock module.
* Calibrated software delay.

The previously discussed TARA16 analog clock implementation uses simulation ticks that are not calibrated to wall-clock seconds.

Therefore, its displayed movement demonstrates clock-hand logic rather than guaranteed real-time accuracy.

## 14.21 Testing and Debugging

Common problems in analog clock applications include:

1. Incorrect hand positions.
2. Incorrect angular calculations.
3. Incorrect coordinate mapping.
4. Unwanted trails from previous hand positions.
5. Incorrect time updates.
6. Display overlap between hands.
7. Incorrect handling of position wraparound.

A systematic debugging process should check the stored time values, hand positions, display coordinates, and update sequence.

The program should also be checked for correct behavior when the hands overlap or cross one another.

## 14.22 Applications of Analog Clocks

Analog clock concepts are used in many systems.

Examples include:

* Traditional wall clocks.
* Wristwatches.
* Dashboard displays.
* Graphical user interfaces.
* Embedded display systems.
* Digital watch interfaces.
* Educational electronics projects.

Analog clock development is useful for understanding coordinate geometry, circular motion, display refreshing, and time representation.

## 14.23 Conclusion

The Analog Clock application demonstrates how a custom instruction set can be used to develop a graphical time-display application.

The program maintains time values and converts them into positions for the hour, minute, and second hands.

It demonstrates arithmetic operations, coordinate calculations, conditional branching, loops, and display management.

The use of selective hand erasure helps maintain a clean display while the hands move.

This project provides practical experience in combining processor instructions with graphical programming concepts.
