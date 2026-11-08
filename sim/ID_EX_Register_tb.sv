`timescale 1ns/1ps
`include "C:/Users/wwwbr/Projects/Pipelined-RISC-V/src/CPU_Types.sv"

module ID_EX_tb();

logic Clk;
logic Reset;
logic [2:0] Funct3D;
logic AUIPCD;
logic RegWriteD;
logic MemWriteD;
logic BranchD;
logic [1:0] PCSrcD;
logic AluSrcD;
logic [3:0] AluControlD;
logic [1:0] ResultSrcD;
logic [31:0] ReadData1D;
logic [31:0] ReadData2D;
logic [31:0] ImmExtD;
logic [31:0] PcD;
logic [31:0] PCPlus4D;
logic [4:0] ReadDestinationD;
logic [4:0] Rs1D;
logic [4:0] Rs2D;
logic FlushD;
logic StallD;
ID_EX ID_EX_OUT;

ID_EX_Register DUT (
    .Clk(Clk),
    .Reset(Reset),
    .Funct3D(Funct3D),
    .AUIPCD(AUIPCD),
    .RegWriteD(RegWriteD),
    .MemWriteD(MemWriteD),
    .BranchD(BranchD),
    .JumpD(JumpD),
    .JumpRD(JumpRD),
    .AluSrcD(AluSrcD),
    .AluControlD(AluControlD),
    .ResultSrcD(ResultSrcD),
    .ReadData1D(ReadData1D),
    .ReadData2D(ReadData2D),
    .ImmExtD(ImmExtD),
    .PcD(PcD),
    .PCPlus4D(PCPlus4D),
    .ReadDestinationD(ReadDestinationD),
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .FlushD(FlushD),
    .StallD(StallD),
    .ID_EX_OUT(ID_EX_OUT)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    Reset = 1;
    FlushD = 0;
    StallD = 0;
    Funct3D = 3'b010;
    AUIPCD = 1'b1;
    RegWriteD = 1'b1;
    MemWriteD = 1'b0;
    BranchD = 1'b0;
    PCSrcD = 2'b01;
    AluSrcD = 1'b1;
    AluControlD = 4'b1010;
    ResultSrcD = 2'b11;
    ReadData1D = 32'hAAAAAAAA;
    ReadData2D = 32'hBBBBBBBB;
    ImmExtD = 32'hCCCCCCCC;
    PcD = 32'h00000010;
    PCPlus4D = 32'h00000014;
    ReadDestinationD = 5'd15;
    Rs1D = 5'd10;
    Rs2D = 5'd11;

    #10;
    assert(ID_EX_OUT.ReadData1D == 0 && ID_EX_OUT.AluControlD == 0) $display("TEST 1 PASSED: Reset clears outputs");
    else $error("TEST 1 FAILED");

    Reset = 0;
    #10;
    assert(ID_EX_OUT.ReadData1D == 32'hAAAAAAAA && ID_EX_OUT.AluControlD == 4'b1010 && ID_EX_OUT.Rs1D == 5'd10) 
        $display("TEST 2 PASSED: Normal Latch passes all signals");
    else $error("TEST 2 FAILED");

    FlushD = 1;
    #10;
    assert(ID_EX_OUT.ReadData1D == 0 && ID_EX_OUT.RegWriteD == 0) $display("TEST 3 PASSED: FlushD clears outputs");
    else $error("TEST 3 FAILED");

    FlushD = 0;
    #10;
    assert(ID_EX_OUT.ReadData2D == 32'hBBBBBBBB) $display("TEST 4 PASSED: Recovery after Flush");
    else $error("TEST 4 FAILED");

    #10;
    $display("ALL ID_EX TESTS FINISHED");
    $finish;
end

endmodule