`timescale 1ns/1ps

module BranchingCompare_tb();

logic [31:0] ReadData1;
logic [31:0] ReadData2;
logic [2:0] Funct3;
logic BranchCondition;

BranchingCompare DUT(
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Funct3(Funct3),
    .BranchCondition(BranchCondition)
);

initial begin
    Funct3 = 3'b000;
    ReadData1 = 32'd100;
    ReadData2 = 32'd100;
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 1A PASSED: BEQ Equal");
    else $error("TEST 1A FAILED: BEQ Equal");

    ReadData1 = 32'd100;
    ReadData2 = 32'd99;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 1B PASSED: BEQ Not Equal");
    else $error("TEST 1B FAILED: BEQ Not Equal");

    Funct3 = 3'b001;
    ReadData1 = 32'd50;
    ReadData2 = 32'd51;
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 2A PASSED: BNE Not Equal");
    else $error("TEST 2A FAILED: BNE Not Equal");

    ReadData1 = 32'd50;
    ReadData2 = 32'd50;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 2B PASSED: BNE Equal");
    else $error("TEST 2B FAILED: BNE Equal");

    Funct3 = 3'b100;
    ReadData1 = -32'd5;
    ReadData2 = 32'd5;  
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 3A PASSED: BLT Signed (-5 < 5)");
    else $error("TEST 3A FAILED: BLT Signed (-5 < 5)");

    ReadData1 = 32'd5;
    ReadData2 = -32'd5;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 3B PASSED: BLT Signed (5 < -5 is False)");
    else $error("TEST 3B FAILED: BLT Signed (5 < -5 is False)");

    Funct3 = 3'b101;
    ReadData1 = 32'd5;
    ReadData2 = -32'd5;
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 4A PASSED: BGE Signed (5 >= -5)");
    else $error("TEST 4A FAILED: BGE Signed (5 >= -5)");

    ReadData1 = -32'd5;
    ReadData2 = -32'd5;
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 4B PASSED: BGE Signed (-5 >= -5)");
    else $error("TEST 4B FAILED: BGE Signed (-5 >= -5)");

    ReadData1 = -32'd10;
    ReadData2 = -32'd5;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 4C PASSED: BGE Signed (-10 >= -5 is False)");
    else $error("TEST 4C FAILED: BGE Signed (-10 >= -5 is False)");

    Funct3 = 3'b110;
    ReadData1 = 32'd5;
    ReadData2 = -32'd5; 
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 5A PASSED: BLTU Unsigned (5 < 0xFFFFFFFB)");
    else $error("TEST 5A FAILED: BLTU Unsigned (5 < 0xFFFFFFFB)");

    ReadData1 = -32'd5;
    ReadData2 = 32'd5;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 5B PASSED: BLTU Unsigned (0xFFFFFFFB < 5 is False)");
    else $error("TEST 5B FAILED: BLTU Unsigned (0xFFFFFFFB < 5 is False)");

    Funct3 = 3'b111;
    ReadData1 = -32'd5; 
    ReadData2 = 32'd5;
    #5;
    assert(BranchCondition == 1'b1) $display("TEST 6A PASSED: BGEU Unsigned (0xFFFFFFFB >= 5)");
    else $error("TEST 6A FAILED: BGEU Unsigned (0xFFFFFFFB >= 5)");

    ReadData1 = 32'd5;
    ReadData2 = -32'd5;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 6B PASSED: BGEU Unsigned (5 >= 0xFFFFFFFB is False)");
    else $error("TEST 6B FAILED: BGEU Unsigned (5 >= 0xFFFFFFFB is False)");
    
    Funct3 = 3'b010; 
    ReadData1 = 32'd10;
    ReadData2 = 32'd10;
    #5;
    assert(BranchCondition == 1'b0) $display("TEST 7 PASSED: Default unused Funct3 returns 0");
    else $error("TEST 7 FAILED: Default unused Funct3 returns 0");

    #5;
    $display("ALL BRANCHING COMPARE TESTS FINISHED");
    $finish;
end

endmodule