`timescale 1ns/1ps

module Flush_Stall_tb();

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

    #10;
    assert(StallF == 0 && StallD == 0 && FlushE == 0 && FlushD == 0) 
        $display("TEST 1 PASSED: Baseline No Hazards");
    else $error("TEST 1 FAILED: Baseline No Hazards");

    ResultSrcE = 2'b01;
    ReadDestinationE = 5'd10;
    Rs1D = 5'd10;
    #10;
    assert(StallF == 1 && StallD == 1 && FlushE == 1 && FlushD == 0) 
        $display("TEST 2 PASSED: Load-Use Hazard on Rs1D");
    else $error("TEST 2 FAILED: Load-Use Hazard on Rs1D");

    Rs1D = 5'd0;
    Rs2D = 5'd10;
    #10;
    assert(StallF == 1 && StallD == 1 && FlushE == 1 && FlushD == 0) 
        $display("TEST 3 PASSED: Load-Use Hazard on Rs2D");
    else $error("TEST 3 FAILED: Load-Use Hazard on Rs2D");

    ResultSrcE = 2'b00;
    Rs2D = 5'd0;
    PCSrcE = 1;
    #10;
    assert(StallF == 0 && StallD == 0 && FlushE == 1 && FlushD == 1) 
        $display("TEST 4 PASSED: Control Hazard (Branch/Jump Taken)");
    else $error("TEST 4 FAILED: Control Hazard (Branch/Jump Taken)");

    ResultSrcE = 2'b01;
    ReadDestinationE = 5'd10;
    Rs1D = 5'd10;
    PCSrcE = 1;
    #10;
    assert(StallF == 1 && StallD == 1 && FlushE == 1 && FlushD == 1) 
        $display("TEST 5 PASSED: Simultaneous Load-Use and Control Hazard");
    else $error("TEST 5 FAILED: Simultaneous Load-Use and Control Hazard");

    #10;
    $display("ALL STALL/FLUSH TESTS FINISHED");
    $finish;
end

endmodule