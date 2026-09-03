module regfile_tb(

);
reg [4:0] a1, a2, a3;
reg [31:0] wD3;
reg wE3, clk;
wire [31:0] rD1, rD2;


    regfile instance1(
        .address1(a1),
        .address2(a2),
        .address3(a3),
        .writeData3(wD3),
        .writeEnable3(wE3),
        .clk(clk),
        .readData1(rD1),
        .readData2(rD2)
    );

initial clk = 0;
always #5 clk = ~clk;


initial begin
    @(negedge clk);
    instance1.register[3] = 32'd17;
    instance1.register[7] = 32'd29;
    wE3 = 1;
    a3 = 5'd0;
    wD3 = 32'd100;
    instance1.register[10] = 0; //To detect whether it changes or not when testing
    instance1.register[0] = 0; //To have a clean answer on the simulation
    @(posedge clk);
    #1;
    if (instance1.register[0] !== 0)
        $display ("FAIL: register is %d", instance1.register[0]);
    else
        $display ("PASS: register is still 0");
    //Check whether attempting to write into register 0 will do anything
    @(negedge clk);
    a1 = 5'd3;
    a2 = 5'd7;
    @(posedge clk);
    #1;
    if ((rD1!== 32'd17)||(rD2 !== 32'd29))
        $display("FAIL: rD1 is %d", rD1, "and rD2 is %d", rD2);
    else
        $display("PASS: rD1 and rD2 are correct");
        //Check whether rD1 and rD2 are displaying correctly
    @(negedge clk);
    a3 = 5'd26;
    @(posedge clk);
    #1;
    if(instance1.register[26] !== 32'd100)
        $display("FAIL: register is %d", instance1.register[26]);
    else
        $display("PASS: register is correct");
        //Check whether writeData properly transfers to the register at a3
    @(negedge clk);
    wE3 = 0;
    a3 = 5'd10;
    @(posedge clk);
    #1;

    if(instance1.register[10] !== 0)
        $display("FAIL: register is not 0, instead is %d", instance1.register[10]);
    else
        $display("PASS: register is still 0");
        //Check whether turning writeEnable3 off will prevent data from being written into address3
    @(negedge clk);
    instance1.register[0] = 32'd20;
    a1 = 0;
    a2 = 0;
    @(posedge clk);
    #1;
    if ((rD1 !== 0) | (rD2 !== 0))
        $display("FAIL: rD1 displayed %d", rD1, "and rD2 displayed %d", rD2);
    else
        $display("PASS: rD1 and rD2 both displayed 0");
        //check whether rD1 and rD2 will display 0 if there is a value in register0 for any reason

end



endmodule


