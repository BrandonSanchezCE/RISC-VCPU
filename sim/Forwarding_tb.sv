`timescale 1ns/1ps

module Forwarding_tb();

logic [4:0] Rs1D, Rs2D, Rs1E, Rs2E;
logic [4:0] ReadDestinationE, ReadDestinationM, ReadDestinationW;
logic RegWriteE, RegWriteM, RegWriteW;
logic PCSrcE;
logic [1:0] ResultSrcE;
logic [1:0] ForwardAE, ForwardBE;
logic StallF, StallD, FlushE, FlushD;

HazardUnit DUT(
    .Rs1D(Rs1D),
    .Rs2D(Rs2D),
    .Rs1E(Rs1E),
    .Rs2E(Rs2E),
    .ReadDestinationE(ReadDestinationE),
    .ReadDestinationM(ReadDestinationM),
    .ReadDestinationW(ReadDestinationW),
    .RegWriteE(RegWriteE),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .PCSrcE(PCSrcE),
    .ResultSrcE(ResultSrcE),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushE(FlushE),
    .FlushD(FlushD)
);

initial begin
    Rs1D = 0; Rs2D = 0;
    Rs1E = 0; Rs2E = 0;
    ReadDestinationE = 0; ReadDestinationM = 0; ReadDestinationW = 0;
    RegWriteE = 0; RegWriteM = 0; RegWriteW = 0;
    PCSrcE = 0; ResultSrcE = 0;

    Rs1E = 5'd5;
    Rs2E = 5'd6;
    ReadDestinationM = 5'd7;
    ReadDestinationW = 5'd8;
    RegWriteM = 1;
    RegWriteW = 1;
    #10;
    assert(ForwardAE == 2'b00 && ForwardBE == 2'b00) 
        $display("TEST 1 PASSED: No Forwarding");
    else $error("TEST 1 FAILED: No Forwarding");

    ReadDestinationM = 5'd5;
    #10;
    assert(ForwardAE == 2'b10 && ForwardBE == 2'b00) 
        $display("TEST 2 PASSED: Forward from EX/MEM to SrcA");
    else $error("TEST 2 FAILED: Forward from EX/MEM to SrcA");

    ReadDestinationM = 5'd0;
    ReadDestinationW = 5'd6;
    #10;
    assert(ForwardAE == 2'b00 && ForwardBE == 2'b01) 
        $display("TEST 3 PASSED: Forward from MEM/WB to SrcB");
    else $error("TEST 3 FAILED: Forward from MEM/WB to SrcB");

    ReadDestinationM = 5'd5;
    #10;
    assert(ForwardAE == 2'b10 && ForwardBE == 2'b01) 
        $display("TEST 4 PASSED: Simultaneous Forwarding (MEM->A, WB->B)");
    else $error("TEST 4 FAILED: Simultaneous Forwarding (MEM->A, WB->B)");

    Rs1E = 5'd5;
    ReadDestinationM = 5'd5;
    ReadDestinationW = 5'd5;
    RegWriteM = 1;
    RegWriteW = 1;
    #10;
    assert(ForwardAE == 2'b10) 
        $display("TEST 5 PASSED: Producer Priority (MEM wins over WB)");
    else $error("TEST 5 FAILED: Producer Priority (MEM wins over WB)");

    Rs1E = 5'd0;
    Rs2E = 5'd0;
    ReadDestinationM = 5'd0;
    ReadDestinationW = 5'd0;
    #10;
    assert(ForwardAE == 2'b00 && ForwardBE == 2'b00) 
        $display("TEST 6 PASSED: R0 Forwarding Prevention");
    else $error("TEST 6 FAILED: R0 Forwarding Prevention");

    RegWriteM = 0;
    RegWriteW = 0;
    Rs1E = 5'd5;
    ReadDestinationM = 5'd5;
    ReadDestinationW = 5'd5;
    #10;
    assert(ForwardAE == 2'b00 && ForwardBE == 2'b00) 
        $display("TEST 7 PASSED: No Forwarding if RegWrite is 0");
    else $error("TEST 7 FAILED: No Forwarding if RegWrite is 0");

    #10;
    $display("ALL FORWARDING TESTS FINISHED");
    $finish;
end

endmodule