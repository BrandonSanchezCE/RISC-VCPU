typedef struct packed {
    logic RegWriteD;
    logic MemWriteD;
    logic JumpD;
    logic BranchD;
    logic JumpRD;
    logic AluSrcD;
    logic [2:0] AluControlD;
    logic [1:0] ResultSrcD;
    logic [31:0]ReadData1D;
    logic [31:0]ReadData2D;
    logic [31:0]ImmExtD;
    logic [31:0]PcD;
    logic [31:0] PCPlus4D;
    logic [4:0] ReadDestinationD;
    
} ID_EX;

module DecodeRegister(
    input logic Clk,
    input logic RegWriteD,
    input logic MemWriteD,
    input logic JumpD,
    input logic BranchD,
    input logic JumpRD,
    input logic AluSrcD,
    input logic [2:0] AluControlD,
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
    ID_EX_OUT.ReadData1D <= ReadData1D;
    ID_EX_OUT.ReadData2D <= ReadData2D;
    ID_EX_OUT.ImmExtD<= ImmExtD;
    ID_EX_OUT.PcD <= PcD;
    ID_EX_OUT.RegWriteD <= RegWriteD;
    ID_EX_OUT.MemWriteD <= MemWriteD;
    ID_EX_OUT.JumpD <= JumpD;
    ID_EX_OUT.AluSrcD <= AluSrcD;
    ID_EX_OUT.ResultSrcD <= ResultSrcD;
    ID_EX_OUT.ReadDestinationD <= ReadDestinationD;
    ID_EX_OUT.PCPlus4D <= PCPlus4D;
    ID_EX_OUT.JumpRD <= JumpRD;
    ID_EX_OUT.BranchD <= BranchD;
    ID_EX_OUT.AluControlD <= AluControlD;

end
endmodule 

