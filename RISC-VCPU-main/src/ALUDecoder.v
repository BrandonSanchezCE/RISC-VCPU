
module ALUDecoder(
    input [2:0] Funct3,
    input  Funct7b5,
    input  Opb5,
    input [1:0] ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    if(ALUOp == 2'b00)
        ALUControl = 4'b0000;
    else if (ALUOp == 2'b01)
        ALUControl = 4'b0001;
    else if (ALUOp == 2'b10) begin
        if(Funct3 == 3'b000) begin
            if (!(Opb5 && Funct7b5))
                ALUControl = 4'b0000; // Add
            else
                ALUControl = 4'b0001; // Sub
               end
        else if (Funct3 == 3'b001)
            ALUControl = 4'b0110;
        else if (Funct3 == 3'b010) //Less Than
            ALUControl = 4'b0101;
        else if (Funct3 == 3'b110) //Or
            ALUControl = 4'b0011; 
        else if (Funct3 == 3'b111) // And
            ALUControl = 4'b0010;
        else if (Funct3 == 3'b101) begin //Shift Right
            if (Funct7b5)
                ALUControl = 4'b1000; //Signed
            else
                ALUControl = 4'b0111; //Unsigned
        end
        else if (Funct3 == 3'b100) // Xor
            ALUControl = 4'b1001;
        else if (Funct3 == 3'b011) //Less Than Unsigned 
            ALUControl = 4'b1010;
        else
            ALUControl = 4'b1111;
    end
    else if (ALUOp == 2'b11)
        ALUControl = 4'b1110;
    else
        ALUControl = 4'b1111;
end

endmodule

//TopModule Testing caught error at Line 17. Was 
//Originally if (!(Opb5 == 1) & !(Funct7b5 == 1))