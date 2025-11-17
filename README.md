# RiscV-with-Neural-Network-AcceleratorRISC-V Processor with Neural Network Accelerator
This project is a Verilog implementation of a RISC-V processor, a neural network accelerator, and an AXI memory interface. It was developed as part of my training at the Academy of Skill Development, focusing on VLSI design and hardware acceleration.

What’s Inside:

1)RISC-V Core: A 5-stage pipeline processor supporting basic RV32I instructions.

2)Neural Network Accelerator: A systolic array for matrix multiplication, useful for simple neural network operations.

3)AXI Memory Interface: A simple AXI4 Lite slave interface for memory access.

How to Use:

Clone this repository.
Open the Verilog files in your preferred simulator (like ModelSim or Vivado).
Run the testbench (tb_system.v) to simulate the entire system.
Check the waveforms to see how the modules interact.

Project Structure:

project-root/
├── riscv_core.v          # RISC-V processor
├── nn_accelerator.v      # Neural network accelerator
├── axi_interface.v       # AXI memory interface
├── tb_system.v           # System-level testbench
├── README.md             # This file
└── testbench/            # Individual testbenches (optional)

Credits
This project was developed by Madhav Kaushik during an internship at the Academy of Skill Development. Special thanks to the mentors and team for their guidance and support.
