module DataPath(
    input [2:0]ImmSrc,
    input Clk,
    input ALUSrc,
    input MemWrite,
    input [1:0]PCSrc,
    input Reset,
    input RegWrite,
    input [3:0]ALUControl,
    input [1:0] ResultSrc,
    input [15:0] sw,
    output [15:0] LED,
    output Zero,
    output [6:0] Op,
    output [2:0]Funct3,
    output Funct7b5
);
wire [31:0] PC, ReadData,
ReadData1, ReadData2, ImmExt, ALUResult, ReadDataDataMem
, PCPlus4, PCTarget;
reg [31:0] PCNext;
reg [31:0] WriteData3;
reg [31:0] SrcB;
PC instance1(
    .PCNext(PCNext),
    .Reset(Reset),
    .Clk(Clk),
    .PC(PC)
);
INSTRM instance2(
    .Address(PC),
    .ReadData(ReadData)
);

RegFile instance3(
    .Address1(ReadData[19:15]),
    .Address2(ReadData[24:20]),
    .Address3(ReadData[11:7]),
    .WriteData3(WriteData3),
    .WriteEnable3(RegWrite),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Clk(Clk)
);

Extend instance4(
    .In(ReadData),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);


always @(*) begin
    if (ALUSrc)
        SrcB = ImmExt;
    else 
        SrcB = ReadData2;
end

ALU instance5(
    .SrcA(ReadData1),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .Zero(Zero),
    .ALUResult(ALUResult)
);

DATAM instance6(
    .Address(ALUResult),
    .Clk(Clk),
    .WriteEnable(MemWrite),
    .ReadData(ReadDataDataMem),
    .WriteData(ReadData2),
    .Leds(LED),
    .Switches(sw)
);

PCPlus4 instance7(
    .PC(PC),
    .PCPlus4(PCPlus4)
);

PCTarget instance8(
    .PC(PC),
    .ImmExt(ImmExt),
    .PCTarget(PCTarget)
);

always @(*) begin
    if(PCSrc[1])
        PCNext = (ReadData1 + ImmExt) & ~32'h1;
    else if (PCSrc[0])
        PCNext = PCTarget;
    else 
        PCNext = PCPlus4;
end 

always @(*) begin
    case(ResultSrc)
        2'b00 : WriteData3 = ALUResult;
        2'b01 : WriteData3 = ReadDataDataMem;
        2'b10 : WriteData3 = PCPlus4;
        2'b11 : WriteData3 = ImmExt;
        default : WriteData3 = 0;
    endcase

end

assign Op = ReadData[6:0];
assign Funct3 = ReadData[14:12];
assign Funct7b5 = ReadData[29];

 
endmodule

//TopModule Testing caught that Funct7b5 was ReadData[30] instead of ReadData[29]