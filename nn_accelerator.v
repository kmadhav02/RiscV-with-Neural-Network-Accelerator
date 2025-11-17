// nn_accelerator.v - Neural Network Accelerator with Systolic Array
// Author: Madhav Kaushik
// Description: Implements a 4x4 systolic array for matrix multiplication

module nn_accelerator (
    input clock,
    input reset,
    input [31:0] input_vector [0:3],
    input [31:0] weight_matrix [0:3][0:3],
    output reg [31:0] output_vector [0:3]
);

reg [31:0] mac_array [0:3][0:3];
integer row, col;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        for (row = 0; row < 4; row = row + 1)
            for (col = 0; col < 4; col = col + 1)
                mac_array[row][col] <= 0;
    end else begin
        for (row = 0; row < 4; row = row + 1)
            for (col = 0; col < 4; col = col + 1)
                mac_array[row][col] <= mac_array[row][col] + input_vector[row] * weight_matrix[row][col];
    end
end

always @(posedge clock) begin
    for (row = 0; row < 4; row = row + 1)
        output_vector[row] <= mac_array[row][row];
end

endmodule
