# Eleven Towers – Source Files

This directory contains the source files and supporting programs for the Eleven Towers project developed using the TARA16 instruction set and TL-Verilog.

## Files

| File                      | Description                                                                                  |
| ------------------------- | -------------------------------------------------------------------------------------------- |
| `eleven_towers_full.tara` | Complete 1,233-line TARA16 assembly game implementation.                                     |
| `eleven_towers.tara`      | Smaller TARA16 demonstration program.                                                        |
| `eleven_towers.tlv`       | TL-Verilog competition template and player-control source.                                   |
| `convert.py`              | Python script that generates, assembles, and simulates a fixed TARA16 demonstration program. |
| `eleven_towers.sv`        | Generated SystemVerilog file.                                                                |
| `eleven_towers_gen.sv`    | Generated SystemVerilog file.                                                                |
| `tara_test.tara`          | TARA16 test program.                                                                         |

## Implementation Notes

The full assembly implementation and the competition player-control template are separate parts of the project.

The Python conversion script currently generates a basic TARA16 demonstration program. It does not automatically translate TL-Verilog into TARA16.

Generated SystemVerilog files are retained for reference and further development.

## Status

The source files are organized for documentation, verification, and future development.
