module DATAM_tb();

reg [31:0] a, wD;
reg wE, clk;
wire [31:0] rD;
DATAM instance1(.address(a), .writeData(wD), .writeEnable(wE), .clk(clk), .readData(rD));


initial clk = 0;
always #5 clk = !clk;

initial begin
@(negedge clk);
    instance1.data[10] = 0;
    wE = 1;
    a= 32'd80;
    wD = 32'd100;
@(posedge clk);
#1;
    if(rD!==32'd100)
        $display("FAIL: data is %d", instance1.data[20]);
    else
        $display("PASS: data is %d", rD);

@(negedge clk);
    wE = 0;
    a = 32'd40;
@(posedge clk);
#1;

    if(rD !== 0)
        $display("FAIL: data changes to %d", instance1.data[10]);
    else
        $display("PASS: data remains %d", rD);
end




endmodule
