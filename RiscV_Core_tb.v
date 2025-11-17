// tb_riscv_core.v - Simple testbench for RISC-V core
// Author: Madhav Kaushik

`timescale 1ns / 1ps

module tb_riscv_core;

reg clock;
reg reset;
reg [31:0] instruction_address;
wire [31:0] instruction_data;
reg [31:0] data_address;
reg [31:0] data_in;
wire [31:0] data_out;
wire data_read;
wire data_write;

// Instantiate the core
riscv_core uut (
    .clock(clock),
    .reset(reset),
    .instruction_address(instruction_address),
    .instruction_data(instruction_data),
    .data_address(data_address),
    .data_in(data_in),
    .data_out(data_out),
    .data_read(data_read),
    .data_write(data_write)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock;
end

// Test sequence
initial begin
    reset = 1;
    instruction_address = 0;
    data_address = 0;
    data_in = 0;
    #10;
    reset = 0;
    #100;
    $finish;
end

endmodule
