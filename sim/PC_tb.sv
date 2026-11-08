`timescale 1ns/1ps

module PC_tb();

logic [31:0] PCNext;
logic Clk;
logic Reset;
logic Halt;
logic StallF;
logic [31:0] PC;

PC DUT(
    .PCNext(PCNext),
    .Clk(Clk),
    .Reset(Reset),
    .Halt(Halt),
    .StallF(StallF),
    .PC(PC)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    Reset = 1;
    Halt = 0;
    StallF = 0;
    PCNext = 32'h00000004;

    #10;
    assert(PC == 32'h00000000) $display("TEST 1 PASSED: Initial Reset");
    else $error("TEST 1 FAILED");

    Reset = 0;
    #10;
    assert(PC == 32'h00000004) $display("TEST 2 PASSED: Normal Update");
    else $error("TEST 2 FAILED");

    PCNext = 32'h00000008;
    #10;
    assert(PC == 32'h00000008) $display("TEST 3 PASSED: Normal Update 2");
    else $error("TEST 3 FAILED");

    Halt = 1;
    PCNext = 32'h0000000C;
    #10;
    assert(PC == 32'h00000008) $display("TEST 4 PASSED: Halt Condition");
    else $error("TEST 4 FAILED");

    Halt = 0;
    StallF = 1;
    PCNext = 32'h0000000C;
    #10;
    assert(PC == 32'h00000008) $display("TEST 5 PASSED: StallF Condition");
    else $error("TEST 5 FAILED");

    StallF = 0;
    PCNext = 32'h0000000C;
    #10;
    assert(PC == 32'h0000000C) $display("TEST 6 PASSED: Resume after Stall");
    else $error("TEST 6 FAILED");

    #2;
    Reset = 1;
    #1;
    assert(PC == 32'h00000000) $display("TEST 7 PASSED: Mid-run Async Reset");
    else $error("TEST 7 FAILED");

    #20;
    $display("ALL PC TESTS FINISHED");
    $finish;
end

endmodule