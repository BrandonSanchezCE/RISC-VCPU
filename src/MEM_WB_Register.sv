`timescale 1ns/1ps
`include "CPU_Types.sv"

module MEM_WB_Register(
    input logic Clk,
    input logic RegWriteM,
    input logic Reset,
    input logic [1:0] ResultSrcM,
    input logic [31:0] ALUResultM,
    input logic [31:0] ReadDataDataMemM,
    input logic [31:0] PCPlus4M,
    input logic [4:0] ReadDestinationM,
    output MEM_WB MEM_WB_OUT
);

always_ff @(posedge Clk) begin
if (!Reset) begin 
    MEM_WB_OUT.RegWriteM <= RegWriteM;
    MEM_WB_OUT.ResultSrcM <= ResultSrcM;
    MEM_WB_OUT.ALUResultM <= ALUResultM;
    MEM_WB_OUT.ReadDataDataMemM <= ReadDataDataMemM;
    MEM_WB_OUT.PCPlus4M <= PCPlus4M;
    MEM_WB_OUT.ReadDestinationM <= ReadDestinationM;
end
else begin
    MEM_WB_OUT.RegWriteM <= 0;
    MEM_WB_OUT.ResultSrcM <= 0;
    MEM_WB_OUT.ALUResultM <= 0;
    MEM_WB_OUT.ReadDataDataMemM <= 0;
    MEM_WB_OUT.PCPlus4M <= 0;
    MEM_WB_OUT.ReadDestinationM <= 0;    
end
end
endmodule
