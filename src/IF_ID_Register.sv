typedef struct packed{
    logic [31:0] PcF;
    logic [31:0] InstrF;
    logic [31:0] PCPlus4F;
} IF_ID;


module IF_ID_Register(
    input  logic Clk,
    input logic [31:0] PcF,
    input logic [31:0] InstrF,
    input logic [31:0] PCPlus4F,
    output IF_ID         IF_ID_OUT
);

always_ff @(posedge Clk) begin
    IF_ID_OUT.PcF <= PcF;
    IF_ID_OUT.InstrF <= InstrF;
    IF_ID_OUT.PCPlus4F <= PCPlus4F;
end






endmodule
