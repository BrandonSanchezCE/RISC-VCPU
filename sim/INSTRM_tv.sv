`timescale 1ns/1ps

module INSTRM_tb();

logic [31:0] Address;
logic [31:0] ReadData;

INSTRM DUT(
    .Address(Address),
    .ReadData(ReadData)
);

initial begin
    Address = 32'd0;
    #5;
    assert(ReadData == 32'h40000093) $display("TEST 1 PASSED: Read Index 0");
    else $error("TEST 1 FAILED");

    Address = 32'd4;
    #5;
    assert(ReadData == 32'h001080B3) $display("TEST 2 PASSED: Read Index 1");
    else $error("TEST 2 FAILED");

    Address = 32'd36;
    #5;
    assert(ReadData == 32'h00012203) $display("TEST 3 PASSED: Read Index 9");
    else $error("TEST 3 FAILED");

    Address = 32'h00200000;
    #5;
    assert(ReadData == 32'h00000013) $display("TEST 4 PASSED: Out of Bounds reads NOP");
    else $error("TEST 4 FAILED");

    #5;
    $display("ALL INSTRM TESTS FINISHED");
    $finish;
end

endmodule