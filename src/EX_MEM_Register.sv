module ExecuteRegister(
    input Clk,
    input RegWriteE,
    input MemWriteE,
    input [1:0] ResultSrcE,
    input [4:0] ReadDestinationE,
    input [31:0] ALUResultE,
    input [31:0] WriteDataE,
    input [31:0] PCPlus4E,
    output reg RegWriteM,
    output reg MemWriteM,
    output reg [1:0] ResultSrcM,
    output reg [4:0] ReadDestinationM,
    output reg [31:0] ALUResultM,
    output reg [31:0] WriteDataM,
    output reg [31:0] PCPlus4M
);

always @(posedge Clk) begin
    RegWriteM <= RegWriteE;
    MemWriteM <= MemWriteE;
    ResultSrcM <= ResultSrcE;
    ReadDestinationM <= ReadDestinationE;
    ALUResultM <= ALUResultE;
    WriteDataM <= WriteDataE;
    PCPlus4M <= PCPlus4E;
end




endmodule
