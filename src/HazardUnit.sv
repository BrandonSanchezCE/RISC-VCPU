module HazardUnit(
    input logic [4:0] Rs1D,
    input logic [4:0] Rs2D,
    input logic [4:0] Rs1E,
    input logic [4:0] Rs2E,
    input logic [4:0] ReadDestinationE,
    input logic [4:0] ReadDestinationM,
    input logic [4:0] ReadDestinationW,
    input logic RegWriteE,
    input logic RegWriteM,
    input logic RegWriteW,
    input logic PCSrcE,
    input logic [1:0] ResultSrcE,
    output logic [1:0] ForwardAE,
    output logic [1:0] ForwardBE,
    output logic StallF,
    output logic StallD,
    output logic FlushE,
    output logic FlushD 

);

always_comb begin
    ForwardAE = 2'b00;
    ForwardBE = 2'b00;

    if (RegWriteM && (ReadDestinationM != 5'd0) && (ReadDestinationM == Rs1E))
        ForwardAE = 2'b10;
    else if (RegWriteW && (ReadDestinationW != 5'd0) && (ReadDestinationW == Rs1E))
        ForwardAE = 2'b01;

    if (RegWriteM && (ReadDestinationM != 5'd0) && (ReadDestinationM == Rs2E))
        ForwardBE = 2'b10;
    else if (RegWriteW && (ReadDestinationW != 5'd0) && (ReadDestinationW == Rs2E))
        ForwardBE = 2'b01;
end

logic lwStall;
assign lwStall = (ResultSrcE == 2'b01) && ((ReadDestinationE == Rs1D) || (ReadDestinationE == Rs2D));
assign StallF = lwStall;
assign StallD = lwStall;
assign FlushE = lwStall || PCSrcE;
assign FlushD = PCSrcE;
endmodule