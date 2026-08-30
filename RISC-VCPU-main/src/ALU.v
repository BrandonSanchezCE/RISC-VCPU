module ALU(
    input [31:0]SrcA,
    input [31:0]SrcB,
    input [3:0] ALUControl,
    output reg [31:0] ALUResult,
    output reg Zero
);

wire [4:0] shift = SrcB[4:0];

always @(*) begin
    case (ALUControl)
        4'b0000 : ALUResult = SrcA + SrcB; 
        4'b0001: ALUResult = SrcA - SrcB;
        4'b0010 : ALUResult = SrcA & SrcB;
        4'b0011: ALUResult = SrcA | SrcB;
        4'b0101 : ALUResult = {31'b0, ($signed(SrcA) < $signed(SrcB))}; //A less than B
        4'b0110 : ALUResult = SrcA << shift; //shiftleft
        4'b0111 : ALUResult = SrcA >> shift; //shiftright
        4'b1000 : ALUResult = $signed(SrcA) >>> shift;
        4'b1001 : ALUResult = SrcA  ^ SrcB;
        4'b1010 : ALUResult = {31'b0, (SrcA < SrcB)};
        default : ALUResult = 32'd0;
    endcase

    if (ALUResult == 0)
        Zero = 1;
    else
         Zero = 0;
    if (ALUControl == 4'b1111) begin
        $display ("Invalid ALUControl");
    end
end

//Zero latch caught during testing







endmodule
//1100100
//0110010