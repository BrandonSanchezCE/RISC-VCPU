`timescale 1ns/1ps

module PCLogic_tb();

logic [31:0] ReadData1;
logic [31:0] ReadData2;
logic [6:0] Op;
logic [2:0] Funct3;
logic Funct7b5;
logic MemWrite;
logic ALUSrc;
logic RegWrite;
logic [1:0] PCSrc;
logic [1:0] ResultSrc;
logic [2:0] ImmSrc;
logic [3:0] ALUControl;
logic Halt;

ControlUnit DUT(
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .Halt(Halt)
);

initial begin
    ReadData1 = 0;
    ReadData2 = 0;
    Funct3 = 0;
    Funct7b5 = 0;
    
    Op = 7'b0110011; 
    #5;
    assert(PCSrc == 2'b00) $display("TEST 1 PASSED: Normal Instruction (PC+4)");
    else $error("TEST 1 FAILED");

    Op = 7'b1100011; 
    Funct3 = 3'b000; 
    ReadData1 = 32'd10;
    ReadData2 = 32'd20;
    #5;
    assert(PCSrc == 2'b00) $display("TEST 2 PASSED: Branch Not Taken");
    else $error("TEST 2 FAILED");

    Op = 7'b1100011; 
    Funct3 = 3'b000; 
    ReadData1 = 32'd10;
    ReadData2 = 32'd10;
    #5;
    assert(PCSrc == 2'b01) $display("TEST 3 PASSED: Branch Taken");
    else $error("TEST 3 FAILED");

    Op = 7'b1101111; 
    #5;
    assert(PCSrc == 2'b01) $display("TEST 4 PASSED: Jump (JAL)");
    else $error("TEST 4 FAILED");

    Op = 7'b1100111; 
    #5;
    assert(PCSrc == 2'b10) $display("TEST 5 PASSED: Jump Register (JALR)");
    else $error("TEST 5 FAILED");

    #5;
    $display("ALL CONTROL UNIT PC LOGIC TESTS FINISHED");
    $finish;
end

endmodule