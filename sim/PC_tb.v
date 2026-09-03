module PC_tb;
    reg [31:0] in;
    reg clock;
    reg reset;
    wire [31:0] out;

    PC instance1(.PCNext(in), .clk(clock), .reset(reset), .PC(out) );
    initial clock = 0;
    always #5 clock = ~clock;

    initial begin
    reset = 1;
    #10;
   //Check to see if PC = 0;
    if (out !== 32'd0)
        $display ("FAIL: Got %d instead", out);
    else
        $display("PASS: PC reset");

    reset = 0;
    in = 32'd42;
    #10;

    //check if PCNext updates PC correctly
    if (out !== 32'd42)
        $display ("FAIL: Got %d instead", out);
    else
        $display ("PASS: PC is 42");
    end
endmodule
