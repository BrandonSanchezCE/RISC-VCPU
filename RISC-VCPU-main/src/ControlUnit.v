module ControlUnit(
    input Zero,
    input [6:0] Op,
    input [2:0] Funct3,
    input Funct7b5,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output reg [1:0] PCSrc,
    output [1:0]ResultSrc,
    output [2:0] ImmSrc,
    output [3:0]ALUControl
);
wire [1:0] ALUOp;
wire branch, jump, jumpR;
mainDecoder instance1(
    .Op(Op),
    .Branch(branch),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ResultSrc(ResultSrc),
    .ALUOp(ALUOp),
    .Jump(jump),
    .JumpR(jumpR)
    );

ALUDecoder instance2(
    .ALUOp(ALUOp),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Opb5(Op[5]),
    .ALUControl(ALUControl)
);

always @(*) begin
    PCSrc[0] = jump | (branch & Zero);
    PCSrc[1] = jumpR;
end

endmodule
