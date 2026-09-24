`timescale 1ns/1ps
`include "CPU_Types.sv"

module ID_EX_Register(
    input logic Clk,
    input logic Reset,
    input logic [2:0] Funct3D,
    input logic AUIPCD,
    input logic RegWriteD,
    input logic MemWriteD,
    input logic BranchD,
    input [1:0] PCSrcD,
    input logic AluSrcD,
    input logic [3:0] AluControlD,
    input logic [1:0] ResultSrcD,
    input logic [31:0]ReadData1D,
    input logic [31:0]ReadData2D,
    input logic [31:0]ImmExtD,
    input logic [31:0]PcD,
    input logic [31:0] PCPlus4D,
    input logic [4:0] ReadDestinationD,
    output ID_EX ID_EX_OUT

);

always_ff @(posedge Clk) begin
    if (!Reset) begin
        ID_EX_OUT.ReadData1D <= ReadData1D;
        ID_EX_OUT.ReadData2D <= ReadData2D;
        ID_EX_OUT.ImmExtD<= ImmExtD;
        ID_EX_OUT.PcD <= PcD;
        ID_EX_OUT.RegWriteD <= RegWriteD;
        ID_EX_OUT.MemWriteD <= MemWriteD;
        ID_EX_OUT.AluSrcD <= AluSrcD;
        ID_EX_OUT.ResultSrcD <= ResultSrcD;
        ID_EX_OUT.ReadDestinationD <= ReadDestinationD;
        ID_EX_OUT.PCPlus4D <= PCPlus4D;
        ID_EX_OUT.BranchD <= BranchD;
        ID_EX_OUT.AluControlD <= AluControlD;
        ID_EX_OUT.Funct3D <= Funct3D;
        ID_EX_OUT.PCSrcD <= PCSrcD;
    end 
    else begin
        ID_EX_OUT.ReadData1D <= 0;
        ID_EX_OUT.ReadData2D <= 0;
        ID_EX_OUT.ImmExtD<= 0;
        ID_EX_OUT.PcD <= 0;
        ID_EX_OUT.RegWriteD <= 0;
        ID_EX_OUT.MemWriteD <= 0;
        ID_EX_OUT.AluSrcD <= 0;
        ID_EX_OUT.ResultSrcD <= 0;
        ID_EX_OUT.ReadDestinationD <= 0;
        ID_EX_OUT.PCPlus4D <= 0;
        ID_EX_OUT.BranchD <= 0;
        ID_EX_OUT.AluControlD <= 0;
        ID_EX_OUT.Funct3D <= 0;
        ID_EX_OUT.PCSrcD <= 0;
    end
end
endmodule 

