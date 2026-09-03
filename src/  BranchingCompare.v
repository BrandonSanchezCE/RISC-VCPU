
module BranchingCompare(
    input [31:0] ReadData1,
    input [31:0] ReadData2,
    input [2:0] Funct3,
    output reg BranchCondition
);
wire Eq, Lt, LtU;
assign Eq = (ReadData1 == ReadData2);
assign Lt = ($signed(ReadData1) < $signed(ReadData2));
assign LtU = (ReadData1 < ReadData2);

always @(*) begin
    case (Funct3)
        3'b000: BranchCondition = Eq;
        3'b001: BranchCondition = ~Eq;
        3'b100: BranchCondition = Lt;
        3'b101: BranchCondition = ~Lt;
        3'b110: BranchCondition = LtU;
        3'b111: BranchCondition = ~LtU;
        default: BranchCondition = 0;
    endcase
end

endmodule