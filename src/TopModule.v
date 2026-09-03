module TopModule(
    input CLK100MHZ,
    input Reset
    //input [15:0] sw,
   // output [15:0] LED
);

wire ALUSrc, MemWrite, Zero, Funct7b5, RegWrite, SlowClock, Halt;
wire[1:0] ResultSrc, PCSrc;
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
    .PCSrc(PCSrc),
    .Reset(Reset),
    .RegWrite(RegWrite),
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .Clk(CLK100MHZ),
    .Halt(Halt),
    //.sw(sw),
    //.LED(LED),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2)
);

ControlUnit instance2(
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Op(Op),
    .Funct3(Funct3),
    .Funct7b5(Funct7b5),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .PCSrc(PCSrc),
    .ResultSrc(ResultSrc),
    .Halt(Halt)
);


endmodule
