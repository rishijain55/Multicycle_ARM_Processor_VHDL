# 32-Bit ARM Multicycle Processor in VHDL

## Introduction
Welcome to the 32-bit ARM multicycle processor implementation project! This VHDL-based processor features a 32-bit instruction set, 32-bit data bus, and 16 registers. The processor is designed with five stages: fetch, decode, execute, memory, and writeback. For a comprehensive understanding of the processor, please refer to the documentation in the "Assignment_Problem" files. This Processor was designed as a part of the course "Computer Architecture" at IIT Delhi.

## How to Run
Follow these steps to run the processor successfully:

1. Load all the components, excluding testbenches (files starting with "testbench"), and set the processor.vhd file as the top entity.
2. Provide an external clock for the processor to operate.
3. To execute any program, initialize the data memory with the code specified in the dataMem component within the datamem.vhd file.
   - The last 64 indices (64 * 4 bytes) are reserved for user instructions.
   - The first 64 indices (64 * 4 bytes) are allocated for privileged or restricted memory.
4. Utilize the provided testbenches for testing various instructions; these are identified with the name "testbench."

## Result Verification
To verify the results:

1. Examine the values of the registers after execution.
2. Use EDA Playground with Aldec Rivera Pro and EP Wave for a detailed analysis.
3. In the EP Wave, observe the following signals:
   - `reg1Sel` and `reg2Sel`: Signals for the two read signals of the RegisterFile.
   - `dataout1` and `dataout2`: Data corresponding to the read signals.
   - Check the signals `datainput`, `writeadd`, and `write enable` in the RegisterFile.

Feel free to explore, experiment, and test various scenarios with the processor. Happy coding!
