
module BranchingCompare(
    input [31:0] SrcA,
    input [31:0] SrcB,
    input [2:0] Funct3,
    output reg Branch
);
wire Eq, Lt, LtU;
assign Eq = (SrcA == SrcB);
assign Lt = ($signed(SrcA) < $signed(SrcB));
assign LtU = (SrcA < SrcB);

always @(*) begin
    case (Funct3)
        3'b000: Branch = Eq;
        3'b001: Branch = ~Eq;
        3'b100: Branch = Lt;
        3'b101: Branch = ~Lt;
        3'b110: Branch = LtU;
        3'b111: Branch = ~LtU;
        default: Branch = 0;
    endcase
end

endmodule