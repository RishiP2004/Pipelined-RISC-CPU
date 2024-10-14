## Pipelined-RISC-CPU
This project implements a RISC (Reduced Instruction Set Computing) 16-bit CPU architecture using Verilog on Quartus and tested on ModelSIM. It consists of multiple stages including instruction fetch, decode, execution, memory access, and write-back. The design incorporates pipelining to enhance instruction throughput.

# Table of Contents
[Features](#features)

[Architecture](#architecture)

[Modules](#modules)

[Testbenches](#testbenches)

[Usage](#usage)

[Installation](#installation)

# Features
Pipelined architecture for efficient instruction processing
Support for basic arithmetic and load/store instructions
Verilog testbench for simulation and validation

# Architecture
The CPU architecture consists of the following stages:

- Instruction Fetch Stage (IF)
- Instruction Decode Stage (ID)
- Execution Stage (EX)
- Memory Stage (MEM)
- Write-Back Stage (WB)

# Modules
- InstructionFetchStage: Retrieves instructions from the Instruction Memory, incrementing the program counter for the next instruction.
- InstructionDecodeStage: Decodes the fetched instruction, extracts opcode and operands, and reads the required register values from the Register File.
- ExecutionStage: Processes the decoded instruction and operands, utilizing the ALU to perform computations.
- MemoryStage: Manages load and store operations, accessing data from Memory based on addresses provided.
- WriteBackStage: Writes results back to the Register File, updating specified registers according to control signals and addresses.
  
- InstructionMemory: Stores the set of instructions that the CPU will execute, allowing for instruction fetch operations.
- RegisterFile: Contains internal registers for storing data, enabling read and write operations based on register addresses.
- Intermediate Registers: General registers that facilitate data transfer between various stages of the CPU pipeline (ex. InstructionFetch to InstructionDecode).
- ALU: Performs arithmetic and logic operations on the operands, producing the required result for execution.
  
# Testbench
A testbench is included to simulate the operation of the RISC CPU and validate its functionality.

# Usage
Install a Verilog simulator (e.g., ModelSim, Vivado).
Compile the Verilog files.
Run the testbench to observe the simulation results.

# Installation
Clone the repository:

bash
Copy code
git clone https://github.com/RishiP2004/Pipelined-RISC-CPU.git
cd Pipelined-RISC-CPU
