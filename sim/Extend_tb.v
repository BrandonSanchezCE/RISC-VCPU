module Extend_tb();

reg [31:0] In;
reg [1:0] ImmSrc;
wire [31:0] ImmExt;
 
Extend instance1(.In(In), .ImmSrc(ImmSrc), .ImmExt(ImmExt));

initial begin

ImmSrc = 2'b00;
In = 32'b00000000101000000000000010010011; // I-Type Instruction
#1
if (ImmExt !== 32'b00000000000000000000000000001010)
    $display ("FAIL: I-Type is %b", ImmExt);
else
    $display ("PASS: I-Type is %b", ImmExt);
#1
In = 32'b00000000000000001000010100100011;
ImmSrc = 2'b01;
#1
if (ImmExt !== 32'b00000000000000000000000000001010) 
    $display ("FAIL: S-Type is %b", ImmExt);
else
    $display ("PASS: S-Type is %b", ImmExt);
#1
In = 32'b00000000000000001000010101100011;
ImmSrc = 2'b10;
#1
if (ImmExt !== 32'b00000000000000000000000000001010)
    $display ("FAIL: B-Type is %b", ImmExt);
else
    $display ("PASS: B-Type is %b", ImmExt);
#1
In = 32'b00000000101000000000000001101111;
ImmSrc = 2'b11;
#1
if (ImmExt !== 32'b00000000000000000000000000001010) 
    $display ("FAIL: J-Type is %b", ImmExt);
else
    $display ("PASS: J-Type is %b", ImmExt);
end

endmodule
