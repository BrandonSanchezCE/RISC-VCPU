
module INSTRM(
    input [31:0] Address,
    output reg  [31:0] ReadData

);

reg [31:0] Instruction [0:255];

always @(*) begin
        ReadData = Instruction[Address[9:2]];
   end
/*
initial begin
        Instruction[0]  = 32'h40000093; // addi x1, x0, 1024
        Instruction[1]  = 32'h001080B3; // add  x1, x1, x1
        Instruction[2]  = 32'h001080B3; // add  x1, x1, x1    (x1 = 0x1000, LED address)
        Instruction[3]  = 32'h00408113; // addi x2, x1, 4     (x2 = 0x1004, SW address)
        Instruction[4]  = 32'h001082B3; // add  x5, x1, x1    (8192)
        Instruction[5]  = 32'h005282B3; // add  x5, x5, x5    (16384)
        Instruction[6]  = 32'h005282B3; // add  x5, x5, x5    (x5 = 32768, SW[15] value)
        Instruction[7]  = 32'h0D900193; // addi x3, x0, 217   (Base password)
        Instruction[8]  = 32'h005181B3; // add  x3, x3, x5    (x3 = 32985, the target value)
        Instruction[9]  = 32'h00012203; // lw   x4, 0(x2)     (Read current switches into x4)
        Instruction[10] = 32'h00320863; // beq  x4, x3, 16    (If switches == 32985, jump to Success)
        Instruction[11] = 32'h000003B3; // add  x7, x0, x0    (Zero)
        Instruction[12] = 32'h0070A023; // sw   x7, 0(x1)     (Turn LEDs off)
        Instruction[13] = 32'hFE0008E3; // beq  x0, x0, -16   (Loop back to PC = 9)
        Instruction[14] = 32'hFFF00393; // addi x7, x0, -1    (All 1s)
        Instruction[15] = 32'h0070A023; // sw   x7, 0(x1)     (Turn LEDs on)
        Instruction[16] = 32'hFE0002E3; // beq  x0, x0, -28   (Loop back to PC = 9)
    end
*/
endmodule
