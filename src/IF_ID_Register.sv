`timescale 1ns/1ps
`include "CPU_Types.sv"


module IF_ID_Register(
    input  logic Clk,
    input logic Reset,
    input logic [31:0] PcF,
    input logic [31:0] InstrF,
    input logic [31:0] PCPlus4F,
    output IF_ID         IF_ID_OUT
);

always_ff @(posedge Clk) begin
    if (!Reset) begin
        IF_ID_OUT.PcF <= PcF;
        IF_ID_OUT.InstrF <= InstrF;
        IF_ID_OUT.PCPlus4F <= PCPlus4F;
    end
    else begin
        IF_ID_OUT.PcF <= 0;
        IF_ID_OUT.InstrF <= 0;
        IF_ID_OUT.PCPlus4F <= 0;        
    end
end






endmodule
