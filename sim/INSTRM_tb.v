 module INSTRM_tb(


);

reg [31:0] in;
wire [31:0] out;

INSTRM instance1(.address(in), .readData(out));



initial begin
instance1.instruction[0] = 32'd101;
instance1.instruction[20] = 32'd429;
instance1.instruction[255] = 32'd9;
 in = 32'd0;
 #10;
 if (out !== 32'd101)
    $display("FAIL: out is %d", out);
else
    $display("PASS: out is correct");
#10;

in = 32'd80; //Using bytes so it's index of instruction * 4
#10;
if (out!== 32'd429)
    $display("FAILL: out is %d", out);
else
    $display("PASS: out is correct");
#10;
in = 32'd1020;
#10;
if(out!== 32'd9)
    $display("FAIL: out is %d", out);
else
    $display("PASS: out is correct");

end
//All are checking to see if the instructions at any byte address are displaying correctly


endmodule
