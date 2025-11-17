// tb_axi_interface.v - Simple testbench for AXI interface
// Author: Madhav Kaushik

`timescale 1ns / 1ps

module tb_axi_interface;

reg clock;
reg reset;
reg [31:0] write_address;
reg write_valid;
wire write_ready;
reg [31:0] write_data;
reg write_data_valid;
wire write_data_ready;
wire [31:0] write_response;
wire write_response_valid;
reg write_response_ready;
reg [31:0] read_address;
reg read_valid;
wire read_ready;
wire [31:0] read_data;
wire [31:0] read_response;
wire read_response_valid;
reg read_response_ready;

// Instantiate the AXI interface
axi_interface uut (
    .clock(clock),
    .reset(reset),
    .write_address(write_address),
    .write_valid(write_valid),
    .write_ready(write_ready),
    .write_data(write_data),
    .write_data_valid(write_data_valid),
    .write_data_ready(write_data_ready),
    .write_response(write_response),
    .write_response_valid(write_response_valid),
    .write_response_ready(write_response_ready),
    .read_address(read_address),
    .read_valid(read_valid),
    .read_ready(read_ready),
    .read_data(read_data),
    .read_response(read_response),
    .read_response_valid(read_response_valid),
    .read_response_ready(read_response_ready)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock;
end

// Test sequence
initial begin
    reset = 1;
    write_address = 0;
    write_valid = 0;
    write_data = 0;
    write_data_valid = 0;
    write_response_ready = 0;
    read_address = 0;
    read_valid = 0;
    read_response_ready = 0;
    #10;
    reset = 0;
    #10;
    write_address = 10;
    write_valid = 1;
    write_data = 1234;
    write_data_valid = 1;
    #10;
    write_valid = 0;
    write_data_valid = 0;
    #10;
    read_address = 10;
    read_valid = 1;
    #10;
    read_valid = 0;
    #100;
    $finish;
end

endmodule
