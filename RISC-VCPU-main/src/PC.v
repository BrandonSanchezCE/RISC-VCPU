module PC(
    input [31:0] PCNext,
    input Clk,
    input Reset,
    output reg [31:0] PC

);

always @(posedge Clk, posedge Reset) begin
    if (Reset)
        PC <= 0;
    else
        PC <= PCNext;
    end


endmodule

