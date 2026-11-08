module TopModule(
    input Clk,
    input Reset
    //input [15:0] sw,
   // output [15:0] LED
);

wire ALUSrc, Branch, MemWrite, Zero, Funct7b5, RegWrite, SlowClock, Halt, Jump, JumpR;
wire[1:0] ResultSrc;
wire[2:0] Funct3, ImmSrc;
wire [3:0] ALUControl;
wire [6:0] Op;
wire[31:0] ReadData1, ReadData2;

/*ClockDivider instance3(
.CLK100MHZ(CLK100MHZ),
.Reset(Reset),
.SlowClock(SlowClock)
);  */ //For Testing

DataPath instance1(
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .Branch(Branch),
    .Jump(Jump),
    .JumpR(JumpR),
    .Reset(Reset),
    .RegWrite(RegWrite),
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Clk(Clk),
    .Halt(Halt),
    //.sw(sw),
    //.LED(LED),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

ControlUnit instance2(
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ImmSrc(ImmSrc),
    .Branch(Branch),
    .ALUControl(ALUControl),
    .Jump(Jump),
    .JumpR(JumpR),
    .ResultSrc(ResultSrc),
    .Halt(Halt)
);


endmodule
