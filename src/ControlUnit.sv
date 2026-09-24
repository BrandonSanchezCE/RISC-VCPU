module ControlUnit(
    input [31:0]ReadData1,
    input [31:0]ReadData2,
    input [6:0] Op,
    input [2:0] Funct3,
    input Funct7b5,
    output MemWrite,
    output ALUSrc,
    output RegWrite,
    output reg [1:0] PCSrc,
    output [1:0]ResultSrc,
    output [2:0] ImmSrc,
    output [3:0]ALUControl,
    output Halt
);
wire [1:0] ALUOp;
wire branch, jump, jumpR, branchCondition;

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

BranchingCompare BranchCalc(
    .Funct3(Funct3),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .BranchCondition(BranchCondition)
);
always @(*) begin
    PCSrc[0] = jump | (branch & BranchCondition);
    PCSrc[1] = jumpR;
end

assign Halt = (Op == 7'b1110011);

endmodule
