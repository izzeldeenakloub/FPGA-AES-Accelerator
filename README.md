# AES-128 Encryption in Verilog

This project implements the **AES-128 encryption algorithm** in **Verilog/SystemVerilog** and verifies it on the **Intel/Altera DE10-Lite FPGA board**.

AES, or Advanced Encryption Standard, is a symmetric block cipher that encrypts a **128-bit plaintext block** using a **128-bit secret key**. This project focuses on the encryption path of AES-128 and implements the main AES transformations in hardware.

---

## Project Overview

The goal of this project is to design, simulate, synthesize, and verify a hardware implementation of AES-128 encryption.

The design takes:

* 128-bit plaintext input
* 128-bit encryption key input

And produces:

* 128-bit ciphertext output

The implementation follows the standard AES-128 encryption flow:

1. Initial AddRoundKey
2. 9 main AES rounds
3. Final AES round without MixColumns

---

## AES-128 Algorithm

AES-128 operates on a 128-bit block arranged as a 4×4 byte matrix called the **state matrix**.

For AES-128:

* Block size: 128 bits
* Key size: 128 bits
* Number of rounds: 10
* State size: 4×4 bytes
* Round keys: 11 round keys, each 128 bits

---

## AES Encryption Rounds

### Initial Round

The plaintext is XORed with the original key using the AddRoundKey operation.

```text
State = Plaintext XOR Key
```

### Main Rounds

Rounds 1 to 9 contain four transformations:

```text
SubBytes
ShiftRows
MixColumns
AddRoundKey
```

### Final Round

Round 10 contains only three transformations:

```text
SubBytes
ShiftRows
AddRoundKey
```

MixColumns is not applied in the final AES round.

---

## Implemented AES Modules

The design is divided into multiple hardware modules to make the implementation easier to understand, test, and maintain.

### SubBytes

The SubBytes stage replaces each byte in the state matrix with another byte using the AES S-Box lookup table.

This step provides non-linearity to the AES algorithm.

### ShiftRows

The ShiftRows stage cyclically shifts the rows of the state matrix.

The row shifts are:

```text
Row 0: No shift
Row 1: Shift left by 1 byte
Row 2: Shift left by 2 bytes
Row 3: Shift left by 3 bytes
```

### MixColumns

The MixColumns stage mixes each column of the state matrix using multiplication over the finite field GF(2^8).

Each column is multiplied by the fixed AES matrix:

```text
02 03 01 01
01 02 03 01
01 01 02 03
03 01 01 02
```

This step provides diffusion by spreading byte changes across the column.

### AddRoundKey

The AddRoundKey stage XORs the current state with the round key.

```text
state_out = state_in XOR round_key
```

### Key Expansion

The AES-128 key expansion generates 11 round keys from the original 128-bit key.

These round keys are used in the initial round, the 9 main rounds, and the final round.

---

## Repository Structure

```text
AES/
├── rtl/
│   ├── AES.sv
│   ├── subBytes.sv
│   ├── shiftRows.sv
│   ├── mixColumns.sv
│   ├── addRoundKey.sv
│   ├── keyExpansion.sv
│   └── sbox.sv
│
├── dv/
│   ├── tv_AES.sv
│   ├── tv_subBytes.sv
│   ├── tv_shiftRows.sv
│   ├── tv_mixColumns.sv
│   └── tv_keyExpansion.sv
│
├── docs/
│   ├── screenshots/
│   └── reports/
│
├── simulation/
│   └── modelsim/
│
├── output_files/
│
├── AES.qpf
├── AES.qsf
└── README.md
```

> The exact file names may vary depending on the current version of the project.

---

## Hardware Platform

The design was synthesized and verified using the:

**Terasic DE10-Lite FPGA Board**

Main board specifications:

* FPGA: Intel MAX 10
* Device family: MAX 10
* Board: DE10-Lite
* Development tool: Intel Quartus Prime
* Simulation tool: ModelSim / Questa Intel FPGA Edition

---

## Tools Used

* Verilog/SystemVerilog
* Intel Quartus Prime
* ModelSim / Questa Intel FPGA Edition
* DE10-Lite FPGA board
* Git and GitHub

---

## Simulation and Verification

The design was verified using testbenches for individual AES stages and the complete AES encryption module.

Verification was performed for:

* SubBytes transformation
* ShiftRows transformation
* MixColumns transformation
* AddRoundKey transformation
* Key expansion
* Full AES-128 encryption flow

The testbenches compare the generated output with expected AES results.

---

## Example AES Test Vector

A common AES-128 test vector can be used to verify the full encryption result.

### Plaintext

```text
00112233445566778899aabbccddeeff
```

### Key

```text
000102030405060708090a0b0c0d0e0f
```

### Expected Ciphertext

```text
69c4e0d86a7b0430d8cdb78070b4c55a
```

If the design produces this ciphertext, the AES encryption path is working correctly for this standard test case.

---

## FPGA Verification on DE10-Lite

After simulation, the design was synthesized and programmed on the DE10-Lite board.

The FPGA verification confirms that the AES encryption logic can be implemented in hardware and mapped successfully to the target FPGA device.

The verification process included:

1. Compiling the design in Quartus Prime
2. Checking synthesis and fitting reports
3. Programming the DE10-Lite board
4. Testing the AES encryption output
5. Comparing hardware output with the expected ciphertext

---

## How to Run the Project

### 1. Clone the Repository

```bash
git clone https://github.com/izzeldeenakloub/FPGA-AES-Accelerator
cd AES
```

### 2. Open the Project in Quartus Prime

Open the Quartus project file:

```text
AES.qpf
```

### 3. Compile the Design

In Quartus Prime:

```text
Processing → Start Compilation
```

### 4. Run Simulation

Open ModelSim / Questa Intel FPGA Edition and run the desired testbench.

Example:

```tcl
vlog rtl/*.sv dv/tv_AES.sv
vsim work.tv_AES
run -all
```

### 5. Program the DE10-Lite Board

After successful compilation:

```text
Tools → Programmer → Start
```

Make sure the DE10-Lite board is connected and the correct `.sof` file is selected.

---

## Design Status

| Feature             | Status    |
| ------------------- | --------- |
| AES-128 encryption  | Completed |
| SubBytes            | Completed |
| ShiftRows           | Completed |
| MixColumns          | Completed |
| AddRoundKey         | Completed |
| Key Expansion       | Completed |
| Full AES simulation | Verified  |
| FPGA synthesis      | Verified  |
| DE10-Lite testing   | Verified  |

---

## Notes

This project implements AES-128 encryption only.

The following features are not included in the current version:

* AES decryption
* AES-192
* AES-256
* Pipelined AES architecture
* AXI or memory-mapped interface
* UART or external communication interface

These features can be added in future versions.

---

## Future Improvements

Possible future improvements include:

* Add AES decryption support
* Add pipelining for higher throughput
* Add a UART interface for sending plaintext and key values
* Add a memory-mapped interface
* Optimize area and timing
* Add more automated test vectors
* Display encryption results using seven-segment displays or LEDs
* Compare different AES hardware architectures

---

## Learning Outcomes

This project helped demonstrate:

* How AES encryption works internally
* How cryptographic algorithms can be implemented in hardware
* How to write modular Verilog/SystemVerilog code
* How to verify hardware modules using testbenches
* How to synthesize and program a design on the DE10-Lite FPGA board
* How FPGA implementation differs from software implementation

---

## Author

**Izzeldeen Al-kloub**

Computer Engineer
NexiomTech

---

## License

This project is intended for academic and educational purposes.

You may use or modify it for learning, experimentation, and university projects.
