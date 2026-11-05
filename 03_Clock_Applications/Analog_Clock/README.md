# Analog Clock

## 1. Project Introduction
## 2. Project Objective
## 3. Clock Face Design
## 4. Hour Hand
## 5. Minute Hand
## 6. Second Hand
## 7. Coordinate System
## 8. Hand Position Calculations
## 9. Display Updates
## 10. TARA Assembly Instructions Used
## 11. Source Code Explanation
## 12. How to Build
## 13. How to Run
## 14. Screenshots
## 15. Results

# TARA16 Analog Clock

## 1. Project Introduction

The TARA16 Analog Clock is a software-based analog clock developed using TARA16 assembly language. It displays time using three clock hands: hour, minute, and second.

The clock is drawn on a 64 × 64 monochrome framebuffer. The program uses coordinate calculations, lookup tables, bitwise operations, and pixel manipulation to display and update the clock hands.

## 2. Project Objective

The main objectives are:

* Understand TARA16 assembly language programming.
* Implement an analog clock using assembly instructions.
* Generate clock-hand positions using coordinate calculations.
* Draw and erase pixels in a framebuffer.
* Implement seconds, minutes, and hours counters.
* Understand loops, subroutines, memory operations, and conditional branching.

## 3. Features

* Analog clock face with fixed outer markers.
* Three independently drawn clock hands.
* Different lengths for hour, minute, and second hands.
* Automatic time-counter updates.
* Selective erasure of previous hand positions.
* Continuous clock operation without using HLT.
* 64 × 64 monochrome display.

## 4. Clock Face Design

The clock uses a 64 × 64 pixel display.

The framebuffer occupies memory addresses:

* Start address: `0x0600`
* End address: `0x07FF`

Each row uses 8 bytes to represent 64 horizontal pixels.

The clock uses coordinate-based pixel drawing to display its hands and outer markers.

## 5. Clock Hands

### Hour Hand

The hour hand represents the current hour and is the shortest hand.

### Minute Hand

The minute hand represents the current minute and is longer than the hour hand.

### Second Hand

The second hand represents seconds and is the longest hand.

The program calculates the position of each hand using lookup-table coordinates and quadrant rotation.

## 6. Time Representation

The clock maintains three counters:

* Seconds: 0–59
* Minutes: 0–59
* Hours: 0–11

The initial counter values are zero, representing 12:00:00.

The clock follows a 12-hour time format.

## 7. Hand Position Calculation

The program uses a coordinate lookup table to determine the direction of each hand.

The hand-position calculation includes:

1. Selecting a coordinate vector.
2. Determining the required quadrant.
3. Rotating the coordinate vector.
4. Scaling the vector according to the hand type.
5. Updating the pixel coordinates.

Fixed-point coordinates are used during hand drawing to improve coordinate precision.

## 8. Display Updates

The clock updates the display continuously.

The program first draws the current hands. It then erases their previous positions before updating the time counters and drawing the new positions.

The pixel routine uses bitwise operations to set or clear individual framebuffer bits.

## 9. TARA16 Assembly Instructions Used

Important instructions used in the project include:

| Instruction | Purpose                     |
| ----------- | --------------------------- |
| LIL         | Load immediate lower value  |
| LIH         | Load immediate higher value |
| LDW         | Load a word from memory     |
| STW         | Store a word in memory      |
| ADD         | Addition                    |
| SUB         | Subtraction                 |
| MUL         | Multiplication              |
| AND         | Bitwise AND                 |
| OR          | Bitwise OR                  |
| NOT         | Bitwise NOT                 |
| SHL         | Shift left                  |
| SHR         | Shift right                 |
| BZ          | Branch if zero              |
| BN          | Branch if negative          |
| JMP         | Unconditional jump          |
| CALL        | Call a subroutine           |
| RET         | Return from a subroutine    |

## 10. Source Code Organization

The main source file is:

`Source/tara16_analog_clock.tara`

Important routines include:

* `LOOP` – Main clock execution loop.
* `THREE_HANDS` – Draws all three hands.
* `HAND` – Calculates and draws an individual hand.
* `PIXEL` – Sets or clears a framebuffer pixel.
* `delay` – Implements a software delay.

## 11. How to Build

The source file must be assembled using the TARA16 assembler.

The assembler converts the TARA16 assembly instructions into machine instruction words.

The project was successfully assembled with:

* 334 instruction words
* 25 labels
* No assembly errors

## 12. How to Run

Run the assembled program using the TARA16 CPU simulator.

The simulator executes the instructions and updates the framebuffer in memory.

The framebuffer can then be inspected or converted into a visual representation to observe the clock display.

## 13. Testing and Results

The program was tested using the TARA16 CPU simulator.

Observed simulation results:

| Parameter                   | Result     |
| --------------------------- | ---------- |
| Assembly status             | Successful |
| Instruction words           | 334        |
| Labels                      | 25         |
| Instructions executed       | 100,000    |
| CPU halted                  | False      |
| CPU error                   | None       |
| Seconds counter             | 15         |
| Minutes counter             | 0          |
| Hours counter               | 0          |
| Non-zero framebuffer pixels | 54         |

The simulation demonstrates that the program executes continuously, updates the time counter, and writes pixel data to the framebuffer.

The observed counter values correspond to 12:00:15.

## 14. Timing Accuracy

The clock uses a software delay loop to control its update speed.

The delay is not calibrated to real-world seconds. Therefore, the simulation demonstrates clock operation and counter updates but does not establish accurate wall-clock timing.

## 15. Screenshots

Screenshots of the clock display can be added to the `Screenshots/` directory.

## 16. Project Structure

```text
Analog_Clock/
│
├── README.md
│
├── Source/
│   └── tara16_analog_clock.tara
│
├── Documentation/
│   └── Documentation.md
│
└── Screenshots/
```

## 17. Conclusion

The TARA16 Analog Clock demonstrates how an analog clock can be implemented using assembly language and framebuffer-based graphics.

The project provides practical experience with instruction execution, memory addressing, coordinate calculations, bitwise operations, subroutines, and continuous program execution.
