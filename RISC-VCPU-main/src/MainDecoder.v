module mainDecoder(
    input [6:0] Op,
    output reg RegWrite,
    output reg ALUSrc,
    output reg MemWrite,
    output reg [1:0]ResultSrc,
    output reg Branch,
    output reg [2:0] ImmSrc,
    output reg [1:0] ALUOp,
    output reg Jump,
    output reg JumpR,
    output reg Halt
);

always @(*) begin
    case (Op)
        7'b0000011 : begin //loadwrite I-Type
                       RegWrite = 1;
                       ImmSrc = 3'b000;
                       ALUSrc = 1;
                       MemWrite = 0;
                       ResultSrc = 2'b01;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b0100011 : begin //savewrite S-Type
                       RegWrite = 0;
                       ImmSrc = 3'b001;
                       ALUSrc = 1;
                       MemWrite = 1;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b0110011 : begin //R-type Instruction
                       RegWrite = 1;
                       ImmSrc = 3'b000;
                       ALUSrc = 0;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b10;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b1100011 : begin // Branch B-Type
                       RegWrite = 0;
                       ImmSrc = 3'b010;
                       ALUSrc = 0;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 1;
                       ALUOp = 2'b01;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b0010011 : begin //I-Type ALU
                       RegWrite = 1;
                       ImmSrc = 3'b000;
                       ALUSrc = 1;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b10;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b1101111 : begin //Jump J-Type
                       RegWrite = 1;
                       ImmSrc = 3'b011;
                       ALUSrc = 0;
                       MemWrite = 0;
                       ResultSrc = 2'b10;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 1;
                       JumpR = 0;
                       Halt = 0;
        end
        7'b0110111 : begin //LoadUpper
                       RegWrite = 1;
                       ImmSrc = 3'b100;
                       ALUSrc = 1;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b11;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;            
        end
        7'b0010111 : begin // AddUpperImm to PC
                       RegWrite = 1;
                       ImmSrc = 3'b100;
                       ALUSrc = 1;
                       MemWrite = 0;
                       ResultSrc = 2'b11;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 0;            
        end
        7'b1100111 : begin // Jump register
                       RegWrite = 1;
                       ImmSrc = 3'b000;
                       ALUSrc = 1;
                       MemWrite = 0;
                       ResultSrc = 2'b10;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       JumpR = 1;
                       Halt = 0;            
        end
        7'b1110011 : begin // ecall Halt
                       RegWrite = 0;
                       ImmSrc = 3'b000;
                       ALUSrc = 0;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       JumpR = 0;
                       Halt = 1;            
        end
        default : begin
                       RegWrite = 0;
                       ImmSrc = 3'b000;
                       ALUSrc = 0;
                       MemWrite = 0;
                       ResultSrc = 2'b00;
                       Branch = 0;
                       ALUOp = 2'b00;
                       Jump = 0;
                       Halt = 1;
        end
    endcase
end
endmodule