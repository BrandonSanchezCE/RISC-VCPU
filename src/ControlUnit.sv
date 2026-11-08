module ControlUnit(
    input [6:0] Op,
    input [2:0] Funct3,
    input Funct7b5,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output Jump,
    output JumpR,
    output Branch,
    output [1:0]ResultSrc,
    output [2:0] ImmSrc,
    output [3:0]ALUControl,
    output Halt
);
wire [1:0] ALUOp;

mainDecoder instance1(
    .Op(Op),
    .Branch(Branch),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .ResultSrc(ResultSrc),
    .ALUOp(ALUOp),
    .Jump(Jump),
    .JumpR(JumpR)
    );

ALUDecoder instance2(
    .ALUOp(ALUOp),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Opb5(Op[5]),
    .ALUControl(ALUControl)
);

assign Halt = (Op == 7'b1110011);

endmodule
