module Store(
 input [2:0] Funct3,
 input [1:0] ByteOffset,
 input MemWrite,
 output [3:0] WriteEnable

);
reg [3:0]WriteMask;
always @(*) begin
    case (Funct3)
        3'b000: begin //Store a byte
            case(ByteOffset)
                2'b00: WriteMask = 4'b0001;
                2'b01: WriteMask = 4'b0010;
                2'b10: WriteMask = 4'b0100;
                2'b11: WriteMask = 4'b1000;
            endcase
        end
    3'b001: begin //Store halfword
        if (!(ByteOffset[1]))
            WriteMask = 4'b0011;
        else
            WriteMask = 4'b1100;
    end
    3'b010: begin //SW
        WriteMask = 4'b1111;
    end

    default: WriteMask = 4'b0000;
    endcase

end
assign WriteEnable = WriteMask & {4{MemWrite}};

endmodule
