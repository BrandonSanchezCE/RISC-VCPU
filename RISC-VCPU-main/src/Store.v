module Store(
 input [2:0] Funct3,
 input [1:0] ByteOffset,
 input MemWrite,
 input [31:0] DataIn,
 output [3:0] WriteEnable,
output reg[31:0] StoreData
);
reg [3:0]WriteMask;
always @(*) begin
    case (Funct3)
        3'b000: begin //Store a byte
            case(ByteOffset)
                2'b00:  begin
                        WriteMask = 4'b0001;
                        StoreData = {24'b0, DataIn[7:0]};
                end
                2'b01: begin 
                       WriteMask = 4'b0010;
                       StoreData = {16'b0, DataIn[7:0], 8'b0};
                end
                2'b10: begin 
                       WriteMask = 4'b0100;
                       StoreData = {8'b0, DataIn[7:0], 16'b0};
                end
                2'b11: begin 
                       WriteMask = 4'b1000;
                       StoreData = {DataIn[7:0], 24'b0};
                end
            endcase
        end
    3'b001: begin //Store halfword
        if (!(ByteOffset[1])) begin
            WriteMask = 4'b0011;
            StoreData = {16'b0, DataIn[15:0]};
        end
        else begin
            WriteMask = 4'b1100;
            StoreData = {DataIn[15:0], 16'b0};
        end
    end
    3'b010: begin //SW
        WriteMask = 4'b1111;
        StoreData = DataIn;
    end

    default: begin 
        WriteMask = 4'b0000;
        StoreData = DataIn;
    end
    endcase

end
assign WriteEnable = WriteMask & {4{MemWrite}};

endmodule
