module TopModule(
    input CLK100MHZ,
    input Reset,
    input [15:0] sw,
    output [15:0] LED
);

wire ALUSrc, MemWrite, Zero, Funct7b5, RegWrite, SlowClock;
wire[1:0] ResultSrc, PCSrc;
wire[2:0] Funct3, ImmSrc;
wire [3:0] ALUControl;
wire [6:0] Op;

ClockDivider instance3(
.CLK100MHZ(CLK100MHZ),
.Reset(Reset),
.SlowClock(SlowClock)
);

DataPath instance1(
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .PCSrc(PCSrc),
    .Reset(Reset),
    .RegWrite(RegWrite),
    .Zero(Zero),
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Clk(SlowClock),
    .sw(sw),
    .LED(LED)
);

ControlUnit instance2(
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Zero(Zero),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc)
);


endmodule
