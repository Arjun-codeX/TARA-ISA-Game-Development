import sys
from pathlib import Path

# Load the installed TARA16 package
sys.path.insert(
    0,
    "/home/vsduser/tara_project/tara_env/lib/python3.10/site-packages"
)

from src.assembler.asm import assemble
from src.simulation.cpu import TaraCPU


# TARA16 assembly equivalent of the current TLV logic
tara_code = """
; Eleven Towers - TARA16
; Output memory map:
; 0x0100 = Pairing 0 score
; 0x0102 = Pairing 1 score
; 0x0104 = Pairing 2 score
; 0x0106 = Pairing 0 priority
; 0x0108 = Pairing 1 priority
; 0x010A = Pairing 2 priority
; 0x010C = End turn

LIL R0, 0
LIH R0, 1

; All three pairing scores = 0
LIL R1, 0
STW R1, 0(R0)
STW R1, 2(R0)
STW R1, 4(R0)

; All three priority values = 0
STW R1, 6(R0)
STW R1, 8(R0)
STW R1, 10(R0)

; End turn = 1
LIL R1, 1
STW R1, 12(R0)

HLT
"""

# Save the TARA16 assembly file
Path("eleven_towers.tara").write_text(tara_code)

print("TARA16 assembly file created: eleven_towers.tara")

# Assemble the TARA16 program
words, listing, errors, labels = assemble(tara_code)

if errors:
    print("Assembly errors:")
    print(errors)
    sys.exit(1)

print("Assembly successful.")

# Execute the assembled program
cpu = TaraCPU()
cpu.load_program([word for _, word in words])

while cpu.step(record_history=False):
    pass

print("\nSimulation completed.")
print("Registers:", cpu.reg)
print("Instructions executed:", cpu.instr_count)
print("CPU error:", cpu.error)
print("\nOutput memory locations:")
print("0x0100-0x0104: Pairing scores = 0")
print("0x0106-0x010A: Priority values = 0")
print("0x010C: End turn = 1")
