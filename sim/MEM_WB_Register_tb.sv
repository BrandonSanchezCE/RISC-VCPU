`timescale 1ns/1ps
`include "CPU_Types.sv"
module MEM_WB_Register_tb;

integer failures;
logic Clk;
logic Reset;

logic RegWriteM;
logic [1:0] ResultSrcM;
logic [31:0] ALUResultM;
logic [31:0] ReadDataDataMemM;
logic [31:0] PCPlus4M;
logic [4:0] ReadDestinationM;

MEM_WB MEM_WB_OUT;


MEM_WB_Register dut(
    .Clk(Clk),
    .RegWriteM(RegWriteM),
    .Reset(Reset),
    .ResultSrcM(ResultSrcM),
    .ALUResultM(ALUResultM),
    .ReadDataDataMemM(ReadDataDataMemM),
    .PCPlus4M(PCPlus4M),
    .ReadDestinationM(ReadDestinationM),
    .MEM_WB_OUT(MEM_WB_OUT)
);

initial begin
    Clk = 0;
    forever #5 Clk = ~Clk;
end

initial begin

    failures = 0;
    

    Reset = 1;

    RegWriteM = 0;
    ResultSrcM = 0;
    ALUResultM = 0;
    ReadDataDataMemM = 0;
    PCPlus4M = 0;
    ReadDestinationM = 0;


    @(posedge Clk);
    #1;

    assert (
        MEM_WB_OUT.RegWriteM == 0 &&
        MEM_WB_OUT.ResultSrcM == 0 &&
        MEM_WB_OUT.ALUResultM == 0 &&
        MEM_WB_OUT.ReadDataDataMemM == 0 &&
        MEM_WB_OUT.PCPlus4M == 0 &&
        MEM_WB_OUT.ReadDestinationM == 0
    )
    else begin
        $error("TEST 1 FAILED: Reset did not clear outputs.");
        failures = failures + 1;
    end

    $display ("TEST 1 FINISHED: Reset");


    Reset = 0;

    RegWriteM = 1;
    ResultSrcM = 2'b10;
    ALUResultM = 32'h87654321;
    ReadDataDataMemM = 32'h00001004;
    PCPlus4M = 32'h10040000;
    ReadDestinationM = 5'd10;
    
    @(posedge Clk);
    #1;

    assert(
        MEM_WB_OUT.RegWriteM == RegWriteM &&
        MEM_WB_OUT.ResultSrcM == ResultSrcM &&
        MEM_WB_OUT.ALUResultM == ALUResultM &&
        MEM_WB_OUT.ReadDataDataMemM == ReadDataDataMemM &&
        MEM_WB_OUT.PCPlus4M == PCPlus4M &&
        MEM_WB_OUT.ReadDestinationM == ReadDestinationM
    )
    else begin 
        $error("TEST 2 FAILED: Outputs did not capture inputs.");
        failures = failures + 1;
    end

    $display("TEST 2 FINISHED: Normal capture.");

    RegWriteM = 0;
    ResultSrcM = 2'b01;
    ALUResultM = 32'hABCDEF12;
    ReadDataDataMemM = 32'hFEDCBA98;
    PCPlus4M = 32'hAAAAAAAA;
    ReadDestinationM = 5'd20;

    @(posedge Clk);
    #1

     assert(
        MEM_WB_OUT.RegWriteM == RegWriteM &&
        MEM_WB_OUT.ResultSrcM == ResultSrcM &&
        MEM_WB_OUT.ALUResultM == ALUResultM &&
        MEM_WB_OUT.ReadDataDataMemM == ReadDataDataMemM &&
        MEM_WB_OUT.PCPlus4M == PCPlus4M &&
        MEM_WB_OUT.ReadDestinationM == ReadDestinationM
    )
    else begin
        $error("TEST 3 FAILED: Outputs did not update correctly.");
        failures = failures + 1;
    end

    $display("TEST 3 FINISHED: New values captured");

    Reset = 1;
    @(posedge Clk);
    #1;

     assert (
        MEM_WB_OUT.RegWriteM == 0 &&
        MEM_WB_OUT.ResultSrcM == 0 &&
        MEM_WB_OUT.ALUResultM == 0 &&
        MEM_WB_OUT.ReadDataDataMemM == 0 &&
        MEM_WB_OUT.PCPlus4M == 0 &&
        MEM_WB_OUT.ReadDestinationM == 0
    )

    else begin
        $error("TEST 3 FAILED: Reset did not clear outputs");
        failures = failures + 1;
    end
    $display("Test 3 FINISHED: Reset again");


    $display ("=============================");
    $display("ALL TESTS Finished");
    $display("FAILURES : %d", failures);
    $display("==============================");

    $finish;

end
endmodule