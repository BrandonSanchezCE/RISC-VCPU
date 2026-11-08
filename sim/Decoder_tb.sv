module Decoder_tb();

logic [2:0] Funct3;
logic Funct7b5;
logic Opb5;
logic [1:0] ALUOp_in;
logic [3:0] ALUControl;

ALUDecoder ad_dut(
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Opb5(Opb5),
    .ALUOp(ALUOp_in),
    .ALUControl(ALUControl)
);

logic [6:0] Op;
logic RegWrite;
logic ALUSrc;
logic MemWrite;
logic [1:0] ResultSrc;
logic Branch;
logic [2:0] ImmSrc;
logic [1:0] ALUOp_out;
logic Jump;
logic JumpR;
logic Halt;

mainDecoder md_dut(
    .Op(Op),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp_out),
    .Jump(Jump),
    .JumpR(JumpR),
    .Halt(Halt)
);

initial begin
    ALUOp_in = 2'b00;
    Funct3 = 3'b000;
    Funct7b5 = 0;
    Opb5 = 0;
    #5
    assert(ALUControl == 4'b0000)
        $display("ALU_DEC TEST 1 PASSED: ALUOp 00 -> 0000");
    else $error("ALU_DEC TEST 1 FAILED");

    #5
    ALUOp_in = 2'b01;
    #5
    assert(ALUControl == 4'b0001)
        $display("ALU_DEC TEST 2 PASSED: ALUOp 01 -> 0001");
    else $error("ALU_DEC TEST 2 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b000;
    Opb5 = 1;
    Funct7b5 = 1;
    #5
    assert(ALUControl == 4'b0001)
        $display("ALU_DEC TEST 3 PASSED: R-Type SUB");
    else $error("ALU_DEC TEST 3 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b000;
    Opb5 = 1;
    Funct7b5 = 0;
    #5
    assert(ALUControl == 4'b0000)
        $display("ALU_DEC TEST 4 PASSED: R-Type ADD");
    else $error("ALU_DEC TEST 4 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b001;
    #5
    assert(ALUControl == 4'b0110)
        $display("ALU_DEC TEST 5 PASSED: R-Type SLL");
    else $error("ALU_DEC TEST 5 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b010;
    #5
    assert(ALUControl == 4'b0101)
        $display("ALU_DEC TEST 6 PASSED: R-Type SLT");
    else $error("ALU_DEC TEST 6 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b011;
    #5
    assert(ALUControl == 4'b1010)
        $display("ALU_DEC TEST 7 PASSED: R-Type SLTU");
    else $error("ALU_DEC TEST 7 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b100;
    #5
    assert(ALUControl == 4'b1001)
        $display("ALU_DEC TEST 8 PASSED: R-Type XOR");
    else $error("ALU_DEC TEST 8 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b101;
    Funct7b5 = 0;
    #5
    assert(ALUControl == 4'b0111)
        $display("ALU_DEC TEST 9 PASSED: R-Type SRL");
    else $error("ALU_DEC TEST 9 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b101;
    Funct7b5 = 1;
    #5
    assert(ALUControl == 4'b1000)
        $display("ALU_DEC TEST 10 PASSED: R-Type SRA");
    else $error("ALU_DEC TEST 10 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b110;
    #5
    assert(ALUControl == 4'b0011)
        $display("ALU_DEC TEST 11 PASSED: R-Type OR");
    else $error("ALU_DEC TEST 11 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b111;
    #5
    assert(ALUControl == 4'b0010)
        $display("ALU_DEC TEST 12 PASSED: R-Type AND");
    else $error("ALU_DEC TEST 12 FAILED");

    #5
    ALUOp_in = 2'b10;
    Funct3 = 3'b111; 
    #5; 
    Funct3 = 3'bxxx; 
    #5
    assert(ALUControl == 4'b1111)
        $display("ALU_DEC TEST 13 PASSED: R-Type Default");
    else $error("ALU_DEC TEST 13 FAILED");

    #5
    ALUOp_in = 2'b11;
    #5
    assert(ALUControl == 4'b1110)
        $display("ALU_DEC TEST 14 PASSED: ALUOp 11 -> 1110");
    else $error("ALU_DEC TEST 14 FAILED");

    #5
    ALUOp_in = 2'bxx;
    #5
    assert(ALUControl == 4'b1111)
        $display("ALU_DEC TEST 15 PASSED: ALUOp Default -> 1111");
    else $error("ALU_DEC TEST 15 FAILED");

    #5
    Op = 7'b0110011; 
    #5
    assert(RegWrite == 1 && ALUSrc == 0 && MemWrite == 0 && ALUOp_out == 2'b10)
        $display("MAIN_DEC TEST 1 PASSED: R-Type Instruction");
    else $error("MAIN_DEC TEST 1 FAILED");

    #5
    Op = 7'b0000011; 
    #5
    assert(RegWrite == 1 && ALUSrc == 1 && MemWrite == 0 && ResultSrc == 2'b01 && ALUOp_out == 2'b00)
        $display("MAIN_DEC TEST 2 PASSED: I-Type Load");
    else $error("MAIN_DEC TEST 2 FAILED");

    #5
    Op = 7'b0100011; 
    #5
    assert(RegWrite == 0 && ALUSrc == 1 && MemWrite == 1 && ALUOp_out == 2'b00)
        $display("MAIN_DEC TEST 3 PASSED: S-Type Store");
    else $error("MAIN_DEC TEST 3 FAILED");

    #5
    Op = 7'b1100011; 
    #5
    assert(Branch == 1 && ALUOp_out == 2'b01)
        $display("MAIN_DEC TEST 4 PASSED: B-Type Branch");
    else $error("MAIN_DEC TEST 4 FAILED");

    #5
    Op = 7'b0010011; 
    #5
    assert(RegWrite == 1 && ALUSrc == 1 && ImmSrc == 3'b000 && ALUOp_out == 2'b10)
        $display("MAIN_DEC TEST 5 PASSED: I-Type ALU");
    else $error("MAIN_DEC TEST 5 FAILED");

    #5
    Op = 7'b1101111; 
    #5
    assert(Jump == 1 && ResultSrc == 2'b10 && ImmSrc == 3'b011)
        $display("MAIN_DEC TEST 6 PASSED: J-Type JAL");
    else $error("MAIN_DEC TEST 6 FAILED");

    #5
    Op = 7'b0110111; 
    #5
    assert(RegWrite == 1 && ALUSrc == 1 && ImmSrc == 3'b100 && ALUOp_out == 2'b11)
        $display("MAIN_DEC TEST 7 PASSED: U-Type LUI");
    else $error("MAIN_DEC TEST 7 FAILED");

    #5
    Op = 7'b0010111; 
    #5
    assert(RegWrite == 1 && ResultSrc == 2'b11 && ImmSrc == 3'b100 && ALUOp_out == 2'b00)
        $display("MAIN_DEC TEST 8 PASSED: U-Type AUIPC");
    else $error("MAIN_DEC TEST 8 FAILED");

    #5
    Op = 7'b1100111; 
    #5
    assert(JumpR == 1 && ResultSrc == 2'b10 && ALUSrc == 1 && ImmSrc == 3'b000)
        $display("MAIN_DEC TEST 9 PASSED: I-Type JALR");
    else $error("MAIN_DEC TEST 9 FAILED");

    #5
    Op = 7'b1110011; 
    #5
    assert(Halt == 1 && RegWrite == 0 && MemWrite == 0)
        $display("MAIN_DEC TEST 10 PASSED: Halt (ecall)");
    else $error("MAIN_DEC TEST 10 FAILED");

    #5
    Op = 7'b0000000; 
    #5
    assert(Halt == 1 && RegWrite == 0 && MemWrite == 0)
        $display("MAIN_DEC TEST 11 PASSED: Default (Invalid Op)");
    else $error("MAIN_DEC TEST 11 FAILED");

    #5;
end

endmodule