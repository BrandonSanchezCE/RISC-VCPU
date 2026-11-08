`timescale 1ns/1ps
`include "C:/Users/wwwbr/Projects/Pipelined-RISC-V/src/CPU_Types.sv"

module IF_ID_tb();

logic Clk;
logic Reset;
logic StallD;
logic FlushD;
logic [31:0] PcF;
logic [31:0] InstrF;
logic [31:0] PCPlus4F;
IF_ID IF_ID_OUT;

IF_ID_Register DUT (
    .Clk(Clk),
    .Reset(Reset),
    .StallD(StallD),
    .FlushD(FlushD),
    .PcF(PcF),
    .InstrF(InstrF),
    .PCPlus4F(PCPlus4F),
    .IF_ID_OUT(IF_ID_OUT)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    Reset = 1;
    StallD = 0;
    FlushD = 0;
    PcF = 32'h00000004;
    InstrF = 32'hDEADBEEF;
    PCPlus4F = 32'h00000008;

    #10;
    assert(IF_ID_OUT.PcF == 0 && IF_ID_OUT.InstrF == 0) $display("TEST 1 PASSED: Reset");
    else $error("TEST 1 FAILED");

    Reset = 0;
    #10;
    assert(IF_ID_OUT.PcF == 32'h00000004 && IF_ID_OUT.InstrF == 32'hDEADBEEF) $display("TEST 2 PASSED: Normal Latch");
    else $error("TEST 2 FAILED");

    PcF = 32'h00000008;
    InstrF = 32'h11223344;
    StallD = 1;
    #10;
    assert(IF_ID_OUT.PcF == 32'h00000004 && IF_ID_OUT.InstrF == 32'hDEADBEEF) $display("TEST 3 PASSED: StallD preserves output");
    else $error("TEST 3 FAILED");

    StallD = 0;
    FlushD = 1;
    #10;
    assert(IF_ID_OUT.PcF == 0 && IF_ID_OUT.InstrF == 0) $display("TEST 4 PASSED: FlushD clears output");
    else $error("TEST 4 FAILED");

    #10;
    $display("ALL IF_ID TESTS FINISHED");
    $finish;
end

endmodule