// riscv_core.v - RISC-V RV32I 5-stage pipeline processor
// Author: Madhav Kaushik
// Description: Implements a 5-stage pipeline (IF, ID, EX, MEM, WB) for RV32I ISA

module riscv_core (
    input clock,
    input reset,
    input [31:0] instruction_address,
    output reg [31:0] instruction_data,
    input [31:0] data_address,
    input [31:0] data_in,
    output reg [31:0] data_out,
    output reg data_read,
    output reg data_write
);

// Pipeline registers
reg [31:0] if_id_pc, if_id_instr;
reg [31:0] id_ex_pc, id_ex_instr, id_ex_reg1, id_ex_reg2;
reg [31:0] ex_mem_pc, ex_mem_instr, ex_mem_result;
reg [31:0] mem_wb_pc, mem_wb_instr, mem_wb_result, mem_wb_load;

// Register file
reg [31:0] registers [0:31];
always @(posedge clock) begin
    if (reset) begin
        for (int i = 0; i < 32; i = i + 1)
            registers[i] <= 0;
    end else begin
        if (mem_wb_instr[6:0] == 7'b0110011 || mem_wb_instr[6:0] == 7'b0010011) // R-type or I-type
            registers[mem_wb_instr[11:7]] <= mem_wb_result;
        else if (mem_wb_instr[6:0] == 7'b0000011) // Load
            registers[mem_wb_instr[11:7]] <= mem_wb_load;
    end
end

// Instruction Fetch
always @(posedge clock or posedge reset) begin
    if (reset) begin
        if_id_pc <= 0;
        if_id_instr <= 0;
    end else begin
        if_id_pc <= instruction_address;
        if_id_instr <= instruction_data;
    end
end

// Instruction Decode
always @(posedge clock or posedge reset) begin
    if (reset) begin
        id_ex_pc <= 0;
        id_ex_instr <= 0;
        id_ex_reg1 <= 0;
        id_ex_reg2 <= 0;
    end else begin
        id_ex_pc <= if_id_pc;
        id_ex_instr <= if_id_instr;
        id_ex_reg1 <= registers[if_id_instr[19:15]];
        id_ex_reg2 <= registers[if_id_instr[24:20]];
    end
end

// Execute
wire [31:0] alu_result;
wire [31:0] alu_input1 = id_ex_reg1;
wire [31:0] alu_input2 = id_ex_reg2;
wire [6:0] opcode = id_ex_instr[6:0];
wire [2:0] funct3 = id_ex_instr[14:12];
wire [6:0] funct7 = id_ex_instr[31:25];

// ALU logic (simplified for ADD, SUB, AND, OR, XOR, SLT)
always @(*) begin
    case ({opcode, funct3, funct7})
        {7'b0110011, 3'b000, 7'b0000000}: alu_result = alu_input1 + alu_input2; // ADD
        {7'b0110011, 3'b000, 7'b0100000}: alu_result = alu_input1 - alu_input2; // SUB
        {7'b0110011, 3'b111, 7'b0000000}: alu_result = alu_input1 & alu_input2; // AND
        {7'b0110011, 3'b110, 7'b0000000}: alu_result = alu_input1 | alu_input2; // OR
        {7'b0110011, 3'b100, 7'b0000000}: alu_result = alu_input1 ^ alu_input2; // XOR
        {7'b0110011, 3'b010, 7'b0000000}: alu_result = (alu_input1 < alu_input2) ? 32'h1 : 32'h0; // SLT
        default: alu_result = 0;
    endcase
end

always @(posedge clock or posedge reset) begin
    if (reset) begin
        ex_mem_pc <= 0;
        ex_mem_instr <= 0;
        ex_mem_result <= 0;
    end else begin
        ex_mem_pc <= id_ex_pc;
        ex_mem_instr <= id_ex_instr;
        ex_mem_result <= alu_result;
    end
end

// Memory Access
always @(posedge clock or posedge reset) begin
    if (reset) begin
        mem_wb_pc <= 0;
        mem_wb_instr <= 0;
        mem_wb_result <= 0;
        mem_wb_load <= 0;
        data_read <= 0;
        data_write <= 0;
        data_out <= 0;
    end else begin
        mem_wb_pc <= ex_mem_pc;
        mem_wb_instr <= ex_mem_instr;
        mem_wb_result <= ex_mem_result;
        if (ex_mem_instr[6:0] == 7'b0000011) begin // Load
            data_read <= 1;
            data_write <= 0;
            data_out <= 0;
            mem_wb_load <= data_in;
        end else if (ex_mem_instr[6:0] == 7'b0100011) begin // Store
            data_read <= 0;
            data_write <= 1;
            data_out <= ex_mem_result;
            mem_wb_load <= 0;
        end else begin
            data_read <= 0;
            data_write <= 0;
            data_out <= 0;
            mem_wb_load <= 0;
        end
    end
end

endmodule
