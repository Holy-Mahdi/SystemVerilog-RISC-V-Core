# SystemVerilog RISC-V CORE

## RV32I

[RISC-V Green Card (PDF)](https://www.cl.cam.ac.uk/teaching/1617/ECAD+Arch/files/docs/RISCVGreenCardv8-20151013.pdf)

### R-Type

| 7 bits | 5 bits | 5 bits | 3 bits | 5 bits | 7 bits |
| funct7 | rs2    | rs1    | funct3 | rd     | opcode |
| 31-25  | 24-20  | 19-15  | 14-12  | 11-7   | 6-0    |

opcode : 0110011

#### ADD

- funct7 : 7'b0000000
- funct3 : 3'b000

#### SUB

- funct7 : 7'b0100000
- funct3 : 3'b000

#### SLL

- funct7 : 7'b0000000
- funct3 : 3'b001

#### SLT

- funct7 : 7'b0000000
- funct3 : 3'b010

#### SLTU

- funct7 : 7'b0000000
- funct3 : 3'b011

#### XOR

- funct7 : 7'b0000000
- funct3 : 3'b100

#### SRL

- funct7 : 7'b0000000
- funct3 : 3'b101

#### SRA

- funct7 : 7'b0100000
- funct3 : 3'b101

#### OR

- funct7 : 7'b0000000
- funct3 : 3'b110

#### AND

- funct7 : 7'b0000000
- funct3 : 3'b111

### I-Type

ADDI
ANDI
ORI
XORI
SLLI
SRLI
SRAI
SLTI
SLTIU

### Load

LB
LH
LW
LBU
LHU

### Store

SB
SH
SW

### Branch

BEQ
BNE
BLT
BGE
BLUT
BGEU

### jump

JAL
JALR

### Uper immediate

LUI
AUIPC
