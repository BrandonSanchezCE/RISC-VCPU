module PC(
    input [31:0] PCNext,
    input Clk,
    input Reset,
    input Halt,
    output reg [31:0] PC

);

always @(posedge Clk, posedge Reset) begin
    if (Reset)
        PC <= 31'h00000000;
    else if (!Halt)
        PC <= PCNext;
    end


endmodule

