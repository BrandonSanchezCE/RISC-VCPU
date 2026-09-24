module Load(
    input [2:0] Funct3,
    input [1:0] ByteOffset,
    input [31:0] MemReadData, 
    output reg [31:0] LoadData

);

always @(*) begin
    case(Funct3)

    3'b000 : begin //Signed bytes
        case (ByteOffset)
        2'b00: LoadData = {{24{MemReadData[7]}}, MemReadData[7:0]};
        2'b01: LoadData = {{24{MemReadData[15]}}, MemReadData[15:8]};
        2'b10: LoadData = {{24{MemReadData[23]}}, MemReadData[23:16]};
        2'b11: LoadData = {{24{MemReadData[31]}}, MemReadData[31:24]};
        endcase
    end


    3'b001: begin //Signed half words
        if(!ByteOffset[1])
            LoadData = {{16{MemReadData[15]}}, MemReadData[15:0]};
        else
            LoadData = {{16{MemReadData[31]}}, MemReadData[31:16]};
    end
    3'b010: LoadData = MemReadData; //Whole Words
    3'b100: begin //Unsigned Bytes
        case (ByteOffset)
            2'b00 : LoadData = {24'b0, MemReadData[7:0]};
            2'b01 : LoadData = {24'b0, MemReadData[15:8]};
            2'b10 : LoadData = {24'b0, MemReadData[23:16]};
            2'b11 : LoadData = {24'b0, MemReadData[31:24]};
        endcase
    end
    3'b101: begin //Unsigned halfwords
        if(!ByteOffset[1])
            LoadData = {16'b0, MemReadData[15:0]};
        else
            LoadData = {16'b0, MemReadData[31:16]};
    end

    default: LoadData = 0;
    endcase
end


endmodule
