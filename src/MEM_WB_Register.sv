typedef struct packed{
    logic RegWriteM;
    logic [1:0] ResultSrcM;
    logic [31:0] ALUResultM;
    logic [31:0] ReadDataDataMemM;
    logic [31:0] PCPlus4M;
    logic [4:0] ReadDestinationM;

} MEM_WB;



module MEM_WB_Register(
    input logic Clk,
    input logic RegWriteM,
    input logic [1:0] ResultSrcM,
    input logic [31:0] ALUResultM,
    input logic [31:0] ReadDataDataMemM,
    input logic [31:0] PCPlus4M,
    input logic [4:0] ReadDestinationM,
    output MEM_WB MEM_WB_OUT
);

always_ff @(posedge Clk) begin
    MEM_WB_OUT.RegWriteM <= RegWriteM;
    MEM_WB_OUT.ResultSrcM <= ResultSrcM;
    MEM_WB_OUT.ALUResultM <= ALUResultM;
    MEM_WB_OUT.ReadDataDataMemM <= ReadDataDataMemM;
    MEM_WB_OUT.PCPlus4M <= PCPlus4M;
    MEM_WB_OUT.ReadDestinationM <= ReadDestinationM;
end

endmodule
