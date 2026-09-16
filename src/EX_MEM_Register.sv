`timescale 1ns/1ps
`include "CPU_Types.sv"

module EX_MEM_Register(
    input logic Clk,
    input logic RegWriteE,
    input logic Reset,
    input logic MemWriteE,
    input logic [1:0] ResultSrcE,
    input logic [4:0] ReadDestinationE,
    input logic [31:0] ALUResultE,
    input logic [31:0] WriteDataE,
    input logic [31:0] PCPlus4E,
    output EX_MEM EX_MEM_OUT
);

always_ff @(posedge Clk) begin
    if (!Reset) begin
    EX_MEM_OUT.RegWriteE <= RegWriteE;
    EX_MEM_OUT.MemWriteE <= MemWriteE;
    EX_MEM_OUT.ResultSrcE <= ResultSrcE;
    EX_MEM_OUT.ReadDestinationE <= ReadDestinationE;
    EX_MEM_OUT.ALUResultE <= ALUResultE;
    EX_MEM_OUT.WriteDataE <= WriteDataE;
    EX_MEM_OUT.PCPlus4E <= PCPlus4E;
    end
else begin
    EX_MEM_OUT.RegWriteE <= 0;
    EX_MEM_OUT.MemWriteE <= 0;
    EX_MEM_OUT.ResultSrcE <= 0;
    EX_MEM_OUT.ReadDestinationE <= 0;
    EX_MEM_OUT.ALUResultE <= 0;
    EX_MEM_OUT.WriteDataE <= 0;
    EX_MEM_OUT.PCPlus4E <= 0;
    end
end




endmodule
