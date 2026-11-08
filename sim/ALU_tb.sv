module ALU_tb();

logic [31:0] SrcA;
logic [31:0] SrcB;
logic [3:0] ALUControl;
logic [31:0] ALUResult;

ALU DUT(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult)
);

initial begin
    ALUControl = 4'b0000;
    SrcA = 32'd100;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 200)
    $display("TEST 1 PASSED: ADD");
    else $error("TEST 1 FAILED: ADD");
    
    #5
    ALUControl = 4'b0001;
    SrcA = 32'd100;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 0)
    $display("TEST 2 PASSED: Subtract");
    else $error("TEST 2 FAILED: Subtract");
    
    #5
    ALUControl = 4'b0010;
    SrcA = 32'd100;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 100)
    $display("TEST 3 PASSED: AND");
    else $error("TEST 3 FAILED: AND");
    
    #5
    ALUControl = 4'b0011;
    SrcA = 32'd100;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 100)
    $display("TEST 4 PASSED: OR");
    else $error("TEST 4 FAILED: OR");
    
    #5
    ALUControl = 4'b0101;
    SrcA = 32'd99;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 1)
    $display("TEST 5 PASSED: SLT Signed (True)");
    else $error("TEST 5 FAILED: SLT Signed (True)");
    
    #5
    ALUControl = 4'b0110;
    SrcA = 32'd1;
    SrcB = 32'd2;
    #5
    assert(ALUResult == 4)
    $display("TEST 6 PASSED: SLL");
    else $error("TEST 6 FAILED: SLL");
    
    #5
    ALUControl = 4'b0111;
    SrcA = 32'd100;
    SrcB = 32'd2;
    #5
    assert(ALUResult == 25)
    $display("TEST 7 PASSED: SRL");
    else $error("TEST 7 FAILED: SRL");
    
    #5
    ALUControl = 4'b1000;
    SrcA = -32'd100;
    SrcB = 32'd2;
    #5
    assert(ALUResult == -32'd25)
    $display("TEST 8 PASSED: SRA");
    else $error("TEST 8 FAILED: SRA");
    
    #5
    ALUControl = 4'b1001;
    SrcA = 32'd170;
    SrcB = 32'd85;
    #5
    assert(ALUResult == 255)
    $display("TEST 9 PASSED: XOR");
    else $error("TEST 9 FAILED: XOR");
    
    #5
    ALUControl = 4'b1010;
    SrcA = 32'd50;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 1)
    $display("TEST 10 PASSED: SLTU (True)");
    else $error("TEST 10 FAILED: SLTU (True)");
    
    #5
    ALUControl = 4'b1110;
    SrcA = 32'd10;
    SrcB = 32'd77;
    #5
    assert(ALUResult == 77)
    $display("TEST 11 PASSED: Pass SrcB");
    else $error("TEST 11 FAILED: Pass SrcB");
    
    #5
    ALUControl = 4'b1111;
    SrcA = 32'd100;
    SrcB = 32'd100;
    #5
    assert(ALUResult == 0)
    $display("TEST 12 PASSED: Default / Invalid");
    else $error("TEST 12 FAILED: Default / Invalid");
    
    #5;
end

endmodule