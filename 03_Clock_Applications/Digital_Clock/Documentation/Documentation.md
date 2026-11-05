# Chapter 13: Digital Clock

## 13.1 Introduction

A digital clock is an electronic application that displays time using numerical digits instead of traditional clock hands.

It displays time in hours, minutes, and seconds.

A digital clock generally follows the 24-hour or 12-hour time format. In this project, the clock is intended to demonstrate how a TARA16 program can maintain time values, update them continuously, and display them in a readable format.

The application uses arithmetic operations, conditional branching, memory management, and repeated execution.

Developing a digital clock using TARA16 helps demonstrate how a custom instruction set can be used to implement a time-based application.

## 13.2 Objective of the Digital Clock

The main objective is to develop a clock application that displays the current time in digital format.

The application should perform the following operations:

1. Initialize the time values.
2. Maintain hours, minutes, and seconds.
3. Update the seconds value.
4. Update minutes when seconds reach their limit.
5. Update hours when minutes reach their limit.
6. Reset the time values when the maximum time is reached.
7. Display the updated time.

The clock must repeat these operations continuously to maintain the time display.

## 13.3 Digital Clock Display

A digital clock generally displays time using the following format:

```text id="5i9y2r"
        DIGITAL CLOCK

             10:30:45

          HH : MM : SS
```

The display contains three main components:

| Component | Meaning | Valid Range in 24-hour Format |
| --------- | ------- | ----------------------------- |
| HH        | Hours   | 00–23                         |
| MM        | Minutes | 00–59                         |
| SS        | Seconds | 00–59                         |

For example:

```text id="9s4k6b"
09:15:30
```

This represents:

* 9 hours.
* 15 minutes.
* 30 seconds.

The colon symbols separate the three time components.

## 13.4 Time Representation

A digital clock maintains three primary values:

* Hours.
* Minutes.
* Seconds.

These values are updated according to the passage of time.

For example:

```text id="v0x9nj"
Hours   = 10
Minutes = 30
Seconds = 45
```

The displayed time is:

```text id="0x5q2e"
10:30:45
```

Each time component has a specific range.

### 13.4.1 Seconds

Seconds range from 0 to 59.

After reaching 59, the seconds value returns to zero, and the minutes value increases by one.

Example:

```text id="fpx7ac"
10:30:58
10:30:59
10:31:00
```

### 13.4.2 Minutes

Minutes range from 0 to 59.

After reaching 59, the minutes value returns to zero, and the hours value increases by one.

Example:

```text id="h1e0a2"
10:59:58
10:59:59
11:00:00
```

### 13.4.3 Hours

In a 24-hour clock, hours range from 0 to 23.

After reaching 23:59:59, the clock returns to 00:00:00.

Example:

```text id="j7r2q4"
23:59:58
23:59:59
00:00:00
```

This process creates a continuous 24-hour time cycle.

## 13.5 Working Principle

The digital clock follows a repeated update process.

First, the clock initializes its time values.

The seconds value is then increased at regular intervals.

Whenever seconds reach 60, they are reset to zero, and minutes are increased.

Similarly, when minutes reach 60, they are reset to zero, and hours are increased.

When hours reach 24, they are reset to zero.

The general process is:

```text id="k8y9rw"
Initialize Time
      |
      v
Increase Seconds
      |
      v
Seconds >= 60?
      |
      +---- Yes ----> Reset Seconds
      |                    |
      |                    v
      |               Increase Minutes
      |                    |
      |                    v
      |               Minutes >= 60?
      |                    |
      |                    +---- Yes ----> Reset Minutes
      |                    |                    |
      |                    |                    v
      |                    |               Increase Hours
      |                    |                    |
      |                    |                    v
      |                    |               Hours >= 24?
      |                    |                    |
      |                    |                    +---- Yes
      |                    |                         |
      |                    |                         v
      |                    |                    Reset Hours
      |                    |
      +--------------------+
                           |
                           v
                    Update Display
                           |
                           v
                    Repeat Process
```

The update process continues while the clock is running.

## 13.6 Time Update Algorithm

The clock uses a hierarchical update mechanism.

One second update may eventually cause a minute update, and one minute update may cause an hour update.

The conceptual algorithm is:

```text id="m0j5cv"
Initialize Hours
Initialize Minutes
Initialize Seconds

Repeat:

    Increase Seconds

    If Seconds >= 60:
        Seconds = 0
        Increase Minutes

    If Minutes >= 60:
        Minutes = 0
        Increase Hours

    If Hours >= 24:
        Hours = 0

    Display Time
```

This algorithm demonstrates the relationship between seconds, minutes, and hours.

The actual program may use a different timing mechanism or update sequence.

## 13.7 Time Initialization

Initialization establishes the starting values of the clock.

For example:

```text id="4v2g9p"
Hours   = 10
Minutes = 30
Seconds = 00
```

The initial display becomes:

```text id="6j2n5p"
10:30:00
```

The starting time may be fixed or loaded from another source.

A software clock that initializes fixed values does not automatically represent the actual local time.

## 13.8 Time Overflow Handling

Overflow occurs when a time component reaches its maximum value.

The clock must handle overflow correctly to maintain valid time.

### Seconds Overflow

Condition:

```text id="0v4r7p"
If Seconds == 60:
    Seconds = 0
    Minutes = Minutes + 1
```

### Minutes Overflow

Condition:

```text id="5j3v8n"
If Minutes == 60:
    Minutes = 0
    Hours = Hours + 1
```

### Hours Overflow

Condition:

```text id="u8w3r5"
If Hours == 24:
    Hours = 0
```

These operations ensure that the displayed time remains within the valid range of a 24-hour clock.

## 13.9 Digital Time Display

The time values must be converted into a readable display format.

For example, three separate values:

```text id="p6t3y8"
Hours   = 10
Minutes = 5
Seconds = 9
```

Can be displayed as:

```text id="q4x9v1"
10:05:09
```

Leading zeros are used to maintain a consistent two-digit format.

A display system may use:

* Terminal output.
* Character-based display.
* Graphical display.
* Seven-segment display.

The actual display method depends on the application implementation.

## 13.10 Clock Execution Flow

The general execution flow of the digital clock is:

```text id="t5k8m2"
+--------------------------+
|       Start Clock        |
+------------+-------------+
             |
             v
+--------------------------+
| Initialize Time Values   |
+------------+-------------+
             |
             v
+--------------------------+
| Wait for Time Interval   |
+------------+-------------+
             |
             v
+--------------------------+
| Increase Seconds         |
+------------+-------------+
             |
             v
+--------------------------+
| Seconds >= 60?           |
+------------+-------------+
             |
             v
+--------------------------+
| Reset Seconds and        |
| Increase Minutes         |
+------------+-------------+
             |
             v
+--------------------------+
| Minutes >= 60?           |
+------------+-------------+
             |
             v
+--------------------------+
| Reset Minutes and        |
| Increase Hours           |
+------------+-------------+
             |
             v
+--------------------------+
| Hours >= 24?             |
+------------+-------------+
             |
             v
+--------------------------+
| Reset Hours if Required  |
+------------+-------------+
             |
             v
+--------------------------+
| Update Digital Display   |
+------------+-------------+
             |
             v
+--------------------------+
| Repeat Clock Operation   |
+--------------------------+
```

This is a conceptual flowchart. The actual program may use separate branches for each overflow condition.

## 13.11 TARA16 Instructions Used in the Digital Clock

A digital clock can demonstrate several TARA16 instruction categories.

| Instruction | Possible Application                      |
| ----------- | ----------------------------------------- |
| MOV         | Transfer time values between registers    |
| LIL         | Load immediate values                     |
| LIH         | Load upper immediate values               |
| ADD         | Increment time values                     |
| SUB         | Calculate differences                     |
| ADDI        | Increment values using immediate operands |
| AND         | Perform bitwise operations                |
| OR          | Perform bitwise operations                |
| XOR         | Perform bitwise operations                |
| NOT         | Perform bitwise complement                |
| SHL         | Shift values left                         |
| SHR         | Shift values right                        |
| SLT         | Compare values                            |
| BZ          | Check zero-related conditions             |
| BN          | Check negative-related conditions         |
| JMP         | Repeat clock operations                   |
| CALL        | Call a clock-related subroutine           |
| RET         | Return from a subroutine                  |
| LDW         | Load time-related data from memory        |
| STW         | Store time-related data in memory         |

The actual instructions used depend on the assembly source code.

## 13.12 Importance of Timing

A digital clock must update its time values at the correct intervals.

For a real-time digital clock:

* Seconds should update once every second.
* Minutes should update once every 60 seconds.
* Hours should update once every 3,600 seconds.

A software program may use a delay loop, timer interrupt, hardware timer, or an external clock source.

A simple instruction-counting loop is not automatically accurate to one real-world second. Its duration depends on the execution environment and processor timing.

Therefore, correct timekeeping requires a reliable timing source.

## 13.13 Testing the Digital Clock

Testing verifies that the clock updates its time values correctly.

The following test cases are useful:

| Test Case            | Initial Time | Expected Time After One Second |
| -------------------- | ------------ | ------------------------------ |
| Normal second update | 10:30:45     | 10:30:46                       |
| Seconds overflow     | 10:30:59     | 10:31:00                       |
| Minutes overflow     | 10:59:59     | 11:00:00                       |
| Hour update          | 11:20:59     | 11:21:00                       |
| Midnight transition  | 23:59:59     | 00:00:00                       |

Additional tests should verify:

1. Correct initialization.
2. Correct display formatting.
3. Correct leading-zero handling.
4. Continuous operation.
5. Correct overflow handling.
6. Correct time update interval.

## 13.14 Programming Concepts Demonstrated

The digital clock demonstrates several important programming concepts.

### Arithmetic Operations

Addition is used to increment seconds, minutes, and hours.

### Conditional Branching

Conditional instructions check whether a time component has reached its maximum value.

### Loops

A repeated execution loop allows the clock to update continuously.

### Memory Management

The clock must maintain the current values of hours, minutes, and seconds.

### Data Representation

The program must represent and display time in a readable format.

### Timing Control

A reliable timing mechanism is necessary to maintain accurate time.

## 13.15 Applications of Digital Clocks

Digital clocks are used in many electronic systems.

Examples include:

* Digital watches.
* Mobile phones.
* Computers.
* Electronic appliances.
* Industrial control panels.
* Microcontroller-based systems.
* Digital timers.
* Embedded monitoring systems.

A digital clock is also a useful educational project because it demonstrates counters, timing, arithmetic operations, and conditional logic.

## 13.16 Conclusion

The Digital Clock application demonstrates how the TARA16 instruction set can be used to implement a time-based program.

The application maintains hours, minutes, and seconds and updates them using arithmetic and conditional operations.

It also demonstrates loops, memory management, overflow handling, and display formatting.

Developing this application helps students understand how basic processor instructions can be combined to create a continuously running application.

It also introduces an important embedded-systems concept: the relationship between software execution and accurate real-time timing.
