// tb_nn_accelerator.v - Simple testbench for NN accelerator
// Author: Madhav Kaushik

`timescale 1ns / 1ps

module tb_nn_accelerator;

reg clock;
reg reset;
reg [31:0] input_vector [0:3];
reg [31:0] weight_matrix [0:3][0:3];
wire [31:0] output_vector [0:3];

// Instantiate the accelerator
nn_accelerator uut (
    .clock(clock),
    .reset(reset),
    .input_vector(input_vector),
    .weight_matrix(weight_matrix),
    .output_vector(output_vector)
);

// Clock generation
initial begin
    clock = 0;
    forever #5 clock = ~clock;
end

// Test sequence
initial begin
    reset = 1;
    for (int i = 0; i < 4; i = i + 1) begin
        input_vector[i] = 0;
        for (int j = 0; j < 4; j = j + 1)
            weight_matrix[i][j] = 0;
    end
    #10;
    reset = 0;
    input_vector[0] = 2;
    input_vector[1] = 3;
    input_vector[2] = 4;
    input_vector[3] = 5;
    for (int i = 0; i < 4; i = i + 1)
        for (int j = 0; j < 4; j = j + 1)
            weight_matrix[i][j] = 1;
    #100;
    $finish;
end

endmodule
