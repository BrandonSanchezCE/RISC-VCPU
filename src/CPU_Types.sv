`ifndef CPU_TYPES_SV
`define CPU_TYPES_SV

typedef struct packed {
    logic RegWriteE;
    logic MemWriteE;
    logic [1:0] ResultSrcE;
    logic [4:0] ReadDestinationE;
    logic [31:0] ALUResultE;
    logic [31:0] WriteDataE;
    logic [31:0] PCPlus4E;
} EX_MEM;

typedef struct packed{
    logic RegWriteM;
    logic [1:0] ResultSrcM;
    logic [31:0] ALUResultM;
    logic [31:0] ReadDataDataMemM;
    logic [31:0] PCPlus4M;
    logic [4:0] ReadDestinationM;

} MEM_WB;

typedef struct packed{
    logic [31:0] PcF;
    logic [31:0] InstrF;
    logic [31:0] PCPlus4F;
} IF_ID;

typedef struct packed {
    logic RegWriteD;
    logic MemWriteD;
    logic JumpD;
    logic BranchD;
    logic JumpRD;
    logic AluSrcD;
    logic [2:0] AluControlD;
    logic [1:0] ResultSrcD;
    logic [31:0]ReadData1D;
    logic [31:0]ReadData2D;
    logic [31:0]ImmExtD;
    logic [31:0]PcD;
    logic [31:0] PCPlus4D;
    logic [4:0] ReadDestinationD;
    
} ID_EX;

`endif