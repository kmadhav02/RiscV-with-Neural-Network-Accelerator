// tb_system.v - System-level testbench for RISC-V, NN accelerator, and AXI interface
// Author: Madhav Kaushik

`timescale 1ns / 1ps

module tb_system;

reg clock;
reg reset;

// RISC-V Core signals
reg [31:0] instruction_address;
wire [31:0] instruction_data;
reg [31:0] data_address;
reg [31:0] data_in;
wire [31:0] data_out;
wire data_read;
wire data_write;

// NN Accelerator signals
reg [31:0] input_vector [0:3];
reg [31:0] weight_matrix [0:3][0:3];
wire [31:0] output_vector [0:3];

// AXI Interface signals
reg [31:0] axi_write_address;
reg axi_write_valid;
wire axi_write_ready;
reg [31:0] axi_write_data;
reg axi_write_data_valid;
wire axi_write_data_ready;
wire [31:0] axi_write_response;
wire axi_write_response_valid;
reg axi_write_response_ready;
reg [31:0] axi_read_address;
reg axi_read_valid;
wire axi_read_ready;
wire [31:0] axi_read_data;
wire [31:0] axi_read_response;
wire axi_read_response_valid;
reg axi_read_response_ready;

// Instantiate modules
riscv_core uut_core (
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

nn_accelerator uut_nn (
    .clock(clock),
    .reset(reset),
    .input_vector(input_vector),
    .weight_matrix(weight_matrix),
    .output_vector(output_vector)
);

axi_interface uut_axi (
    .clock(clock),
    .reset(reset),
    .write_address(axi_write_address),
    .write_valid(axi_write_valid),
    .write_ready(axi_write_ready),
    .write_data(axi_write_data),
    .write_data_valid(axi_write_data_valid),
    .write_data_ready(axi_write_data_ready),
    .write_response(axi_write_response),
    .write_response_valid(axi_write_response_valid),
    .write_response_ready(axi_write_response_ready),
    .read_address(axi_read_address),
    .read_valid(axi_read_valid),
    .read_ready(axi_read_ready),
    .read_data(axi_read_data),
    .read_response(axi_read_response),
    .read_response_valid(axi_read_response_valid),
    .read_response_ready(axi_read_response_ready)
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
    for (int i = 0; i < 4; i = i + 1) begin
        input_vector[i] = 0;
        for (int j = 0; j < 4; j = j + 1)
            weight_matrix[i][j] = 0;
    end
    axi_write_address = 0;
    axi_write_valid = 0;
    axi_write_data = 0;
    axi_write_data_valid = 0;
    axi_write_response_ready = 0;
    axi_read_address = 0;
    axi_read_valid = 0;
    axi_read_response_ready = 0;
    #10;
    reset = 0;
    #10;

    // Test RISC-V core
    instruction_address = 100;
    data_address = 200;
    data_in = 1234;
    #20;

    // Test NN accelerator
    input_vector[0] = 2;
    input_vector[1] = 3;
    input_vector[2] = 4;
    input_vector[3] = 5;
    for (int i = 0; i < 4; i = i + 1)
        for (int j = 0; j < 4; j = j + 1)
            weight_matrix[i][j] = 1;
    #20;

    // Test AXI interface
    axi_write_address = 10;
    axi_write_valid = 1;
    axi_write_data = 1234;
    axi_write_data_valid = 1;
    #10;
    axi_write_valid = 0;
    axi_write_data_valid = 0;
    #10;
    axi_read_address = 10;
    axi_read_valid = 1;
    #10;
    axi_read_valid = 0;
    #100;
    $finish;
end

endmodule
