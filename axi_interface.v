// axi_interface.v - AXI4 Lite Memory Interface
// Author: Madhav Kaushik
// Description: Implements a simple AXI4 Lite slave interface for memory access

module axi_interface (
    input clock,
    input reset,
    input [31:0] write_address,
    input write_valid,
    output reg write_ready,
    input [31:0] write_data,
    input write_data_valid,
    output reg write_data_ready,
    output reg [31:0] write_response,
    output reg write_response_valid,
    input write_response_ready,
    input [31:0] read_address,
    input read_valid,
    output reg read_ready,
    output reg [31:0] read_data,
    output reg [31:0] read_response,
    output reg read_response_valid,
    input read_response_ready
);

reg [31:0] memory [0:255];

always @(posedge clock or posedge reset) begin
    if (reset) begin
        write_ready <= 0;
        write_data_ready <= 0;
        write_response <= 0;
        write_response_valid <= 0;
        read_ready <= 0;
        read_data <= 0;
        read_response <= 0;
        read_response_valid <= 0;
    end else begin
        // Write address channel
        if (write_valid && !write_ready) begin
            write_ready <= 1;
        end else if (write_ready && write_valid) begin
            write_ready <= 0;
        end

        // Write data channel
        if (write_data_valid && !write_data_ready) begin
            write_data_ready <= 1;
        end else if (write_data_ready && write_data_valid) begin
            write_data_ready <= 0;
            memory[write_address[7:0]] <= write_data;
        end

        // Write response channel
        if (write_data_ready && write_data_valid && write_response_ready) begin
            write_response_valid <= 1;
            write_response <= 0;
        end else if (write_response_valid && write_response_ready) begin
            write_response_valid <= 0;
        end

        // Read address channel
        if (read_valid && !read_ready) begin
            read_ready <= 1;
        end else if (read_ready && read_valid) begin
            read_ready <= 0;
        end

        // Read data channel
        if (read_ready && read_valid && read_response_ready) begin
            read_response_valid <= 1;
            read_data <= memory[read_address[7:0]];
            read_response <= 0;
        end else if (read_response_valid && read_response_ready) begin
            read_response_valid <= 0;
        end
    end
end

endmodule
