`include "CPU_Types.sv"

module DataPath(
    input logic [2:0]ImmSrc,
    input logic Clk,
    input logic ALUSrc,
    input logic MemWrite,
    input logic Halt,
    input logic Reset,
    input logic RegWrite,
    input logic [3:0]ALUControl,
    input logic [1:0] ResultSrc,
    input logic [15:0] sw,
    output logic [15:0] LED,
    output logic [6:0] Op,
    output logic [2:0]Funct3,
    output logic Funct7b5,
    output logic [31:0] ReadData1,
    output logic [31:0] ReadData2,
    input logic [1:0] PCSrc
);
wire [31:0] PC, ReadData, ImmExt, ALUResult, ReadDataDataMem
, PCPlus4, PCTarget, ProcessedLoadData, StoredData;
reg [31:0] PCNext;
reg [31:0] WriteData3;
wire [3:0] WriteEnable;
reg [31:0] SrcB, SrcA;
logic AUIPC;
logic [1:0] ForwardAE, ForwardBE;
logic [31:0] ForwardedA, ForwardedB;
logic StallF, StallD, FlushE, FlushD;

IF_ID IF_ID_OUT;
ID_EX ID_EX_OUT;
EX_MEM EX_MEM_OUT;
MEM_WB MEM_WB_OUT;

PC instance1(
    .PCNext(PCNext),
    .Reset(Reset),
    .Clk(Clk),
    .Halt(Halt),
    .PC(PC),
    .StallF(StallF)
);
INSTRM instance2(
    .Address(PC),
    .ReadData(ReadData)
);

IF_ID_Register Fetch(
    .Clk(Clk),
    .Reset(Reset),
    .PcF(PC),
    .InstrF(ReadData),
    .PCPlus4F(PCPlus4),
    .StallD(StallD),
    .FlushD(FlushD),
    .IF_ID_OUT(IF_ID_OUT)
);

RegFile instance3(
    .Address1(IF_ID_OUT.InstrF[19:15]),
    .Address2(IF_ID_OUT.InstrF[24:20]),
    .Address3(MEM_WB_OUT.ReadDestinationM),
    .WriteData3(WriteData3),
    .WriteEnable3(MEM_WB_OUT.RegWriteM),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .Clk(Clk)
);
assign AUIPC = (Op == 7'b0010111);
Extend instance4(
    .In(IF_ID_OUT.InstrF),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);

ID_EX_Register Decode(
    .Clk(Clk),
    .Reset(Reset),
    .AUIPCD(AUIPC),
    .FlushD(FlushE),
    .Funct3D(IF_ID_OUT.InstrF[14:12]),
    .Rs1D(IF_ID_OUT.InstrF[19:15]),
    .Rs2D(IF_ID_OUT.InstrF[24:20]),
    .RegWriteD(RegWrite),
    .MemWriteD(MemWrite),
    .PCSrcD(PCSrc),
    .AluSrcD(ALUSrc),
    .AluControlD(ALUControl),
    .ResultSrcD(ResultSrc),
    .ReadData1D(ReadData1),
    .ReadData2D(ReadData2),
    .ImmExtD(ImmExt),
    .PcD(IF_ID_OUT.PcF),
    .PCPlus4D(IF_ID_OUT.PCPlus4F),
    .ReadDestinationD(IF_ID_OUT.InstrF[11:7]),
    .ID_EX_OUT(ID_EX_OUT)
);
always_comb begin
    case (ForwardAE)
    2'b00: ForwardedA = ID_EX_OUT.ReadData1D;
    2'b01: ForwardedA = WriteData3;
    2'b10: ForwardedA = EX_MEM_OUT.ALUResultE;
    default: ForwardedA = ID_EX_OUT.ReadData1D;
    endcase

    case (ForwardBE)
        2'b00: ForwardedB = ID_EX_OUT.ReadData2D;
        2'b01: ForwardedB = WriteData3;
        2'b10: ForwardedB = EX_MEM_OUT.ALUResultE;
        default: ForwardedB = ID_EX_OUT.ReadData2D;
    endcase
end
always @(*) begin
    if (ID_EX_OUT.AluSrcD)
        SrcB = ID_EX_OUT.ImmExtD;
    else 
        SrcB = ForwardedB;
end

always @(*) begin
    if (ID_EX_OUT.AUIPCD) begin
        SrcA = ID_EX_OUT.PcD;
    end
    else begin
        SrcA = ForwardedA;
    end
end
ALU instance5(
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUControl(ID_EX_OUT.AluControlD),
    .ALUResult(ALUResult)
);

EX_MEM_Register Execute(
    .Clk(Clk),
    .Reset(Reset),
    .Funct3E(ID_EX_OUT.Funct3D),
    .RegWriteE(ID_EX_OUT.RegWriteD),
    .MemWriteE(ID_EX_OUT.MemWriteD),
    .ResultSrcE(ID_EX_OUT.ResultSrcD),
    .ReadDestinationE(ID_EX_OUT.ReadDestinationD),
    .ALUResultE(ALUResult),
    .WriteDataE(ForwardedB),
    .PCPlus4E(ID_EX_OUT.PCPlus4D),
    .EX_MEM_OUT(EX_MEM_OUT),
    .FlushE(FlushE),
    .StallE(1'b0)
);

Store FindBytes(
    .Funct3(EX_MEM_OUT.Funct3E),
    .ByteOffset(EX_MEM_OUT.ALUResultE[1:0]),
    .MemWrite(EX_MEM_OUT.MemWriteE),
    .WriteEnable(WriteEnable),
    .DataIn(EX_MEM_OUT.WriteDataE),
    .StoreData(StoredData)
);

DATAM instance6(
    .Address(EX_MEM_OUT.ALUResultE),
    .Clk(Clk),
    .WriteEnable(WriteEnable),
    .ReadData(ReadDataDataMem),
    .WriteData(StoredData),
    .Leds(LED),
    .Switches(sw)
);

Load loadedData(
    .Funct3(EX_MEM_OUT.Funct3E),
    .ByteOffset(EX_MEM_OUT.ALUResultE[1:0]),
    .MemReadData(ReadDataDataMem),
    .LoadData(ProcessedLoadData)
);

MEM_WB_Register Memory(
    .Clk(Clk),
    .Reset(Reset),
    .RegWriteM(EX_MEM_OUT.RegWriteE),
    .ResultSrcM(EX_MEM_OUT.ResultSrcE),
    .ALUResultM(EX_MEM_OUT.ALUResultE),
    .ReadDataDataMemM(ProcessedLoadData),
    .PCPlus4M(EX_MEM_OUT.PCPlus4E),
    .ReadDestinationM(EX_MEM_OUT.ReadDestinationE),
    .MEM_WB_OUT(MEM_WB_OUT)
);

PCPlus4 instance7(
    .PC(PC),
    .PCPlus4(PCPlus4)
);

PCTarget instance8(
    .PC(ID_EX_OUT.PcD),
    .ImmExt(ID_EX_OUT.ImmExtD),
    .PCTarget(PCTarget)
);

HazardUnit HazardControl(
    .Rs1D(IF_ID_OUT.InstrF[19:15]),
    .Rs2D(IF_ID_OUT.InstrF[24:20]),
    .Rs1E(ID_EX_OUT.Rs1D),
    .Rs2E(ID_EX_OUT.Rs2D),
    .ReadDestinationE(ID_EX_OUT.ReadDestinationD),
    .ReadDestinationM(EX_MEM_OUT.ReadDestinationE),
    .ReadDestinationW(MEM_WB_OUT.ReadDestinationM),
    .RegWriteE(ID_EX_OUT.RegWriteD),
    .RegWriteM(EX_MEM_OUT.RegWriteE),
    .RegWriteW(MEM_WB_OUT.RegWriteM),
    .PCSrcE(|ID_EX_OUT.PCSrcD),
    .ResultSrcE(ID_EX_OUT.ResultSrcD),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .StallF(StallF),
    .StallD(StallD),
    .FlushE(FlushE),
    .FlushD(FlushD)  
);

always @(*) begin
    if(ID_EX_OUT.PCSrcD[1])
        PCNext = ALUResult & ~32'h1;
    else if (ID_EX_OUT.PCSrcD[0])
        PCNext = PCTarget;
    else 
        PCNext = PCPlus4;
end 

always @(*) begin
    case(MEM_WB_OUT.ResultSrcM)
        2'b00 : WriteData3 = MEM_WB_OUT.ALUResultM;
        2'b01 : WriteData3 = MEM_WB_OUT.ReadDataDataMemM;
        2'b10 : WriteData3 = MEM_WB_OUT.PCPlus4M;
        2'b11 : WriteData3 = MEM_WB_OUT.ALUResultM;
        default : WriteData3 = 0;
    endcase

end

assign Op = IF_ID_OUT.InstrF[6:0];
assign Funct3 = IF_ID_OUT.InstrF[14:12];
assign Funct7b5 = IF_ID_OUT.InstrF[30];

 
endmodule

