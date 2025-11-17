 
---

````md
# RISC-V Processor with Neural Network Accelerator

A lightweight Verilog project integrating a **5-stage RISC-V RV32I processor**, a **systolic-array neural network accelerator**, and a **simple AXI4-Lite memory interface**.  
Built as part of my VLSI Design training at the **Academy of Skill Development**.

---

## 🚀 Overview

### ✔️ RISC-V Core  
- 5-stage pipelined CPU  
- Implements essential **RV32I** instructions  
- Designed for learning, clarity, and extensibility  

### ✔️ Neural Network Accelerator  
- Systolic-array architecture for fast matrix multiplication  
- Offloads MAC-heavy operations from the CPU  
- Demonstrates basic hardware acceleration  

### ✔️ AXI4-Lite Memory Interface  
- Minimal AXI4-Lite slave for memory-mapped access  
- CPU ↔ Accelerator communication through mapped registers  
- Easy to integrate and simulate  

---

## 🛠️ How to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/kmadhav02/RiscV-with-Neural-Network-Accelerator.git
````

2. Open the project in **ModelSim**, **Vivado**, or any Verilog simulator
3. Run the system testbench:

   ```text
   tb_system.v
   ```
4. Inspect waveforms to observe:

   * Instruction flow in the RISC-V CPU
   * Accelerator matrix operations
   * AXI-Lite memory transactions

---

## 📂 Project Structure

```
RiscV-with-Neural-Network-Accelerator/
├── riscv_core.v          # 5-stage RISC-V RV32I processor
├── nn_accelerator.v      # Systolic-array neural network accelerator
├── axi_interface.v       # AXI4-Lite memory interface
├── tb_system.v           # System-level testbench
├── testbench/            # Extra / optional testbenches
└── README.md             # Project documentation
```

---

## 📘 What This Project Demonstrates

* How a **CPU + Accelerator** system communicates
* Using a **systolic array** for neural workloads
* Basics of **AXI4-Lite memory mapping**
* How hardware acceleration boosts compute-heavy tasks
* Useful learning reference for **VLSI, RTL, and digital design**

---

## 🙏 Credits

Developed by **Madhav Kaushik**
Special thanks to the mentors at the **Academy of Skill Development** for their guidance and support.

---

 
 
