module ALU_tb();
reg [31:0] SrcA, SrcB;
wire [31:0] ALUResult;
reg [2:0] ALUControl;
wire Zero;
ALU instance1( .SrcA(SrcA), .SrcB(SrcB), .ALUControl(ALUControl), .ALUResult(ALUResult), .Zero(Zero));

initial begin

    SrcA = 32'd100;
    SrcB = 32'd50;
    ALUControl = 3'b000; //ADD
    #1;
    if (ALUResult !== 32'd150)
        $display ("FAIL: Value is %d", ALUResult);
    else 
        $display ("PASS: Value is 150 when adding");
    #1;
    ALUControl = 3'b001; //Subtract
    #1
    if (ALUResult !== 32'd50)
        $display ("FAIL: Value is %d", ALUResult);
    else 
        $display ("PASS: Value is 50 when subtracting");
    #1;
    ALUControl  = 3'b010;//AND
    #1
    if(ALUResult !== 32'd32)
        $display ("FAIL: Value is %d", ALUResult);
    else 
        $display ("PASS: Value is 32, which is AND");
    #1;
    ALUControl = 3'b011;
    #1
    if (ALUResult !== 32'd118)//OR
        $display ("FAIL: Value is %d", ALUResult);
    else                                                                 //00110010
        $display ("PASS: Value is 118, which is OR");
    #1;
    ALUControl = 3'b101;// Not Less than
    #1
    if (ALUResult !== 32'd0)
        $display ("FAIL: Value is %d", ALUResult);
    else 
        $display ("PASS: SrcA is greater than SrcB");
    if (Zero !== 1) //Check Zero
                $display ("FAIL: Zero is falsely off");
    else
        $display ("PASS: Zero is on");
    #1;
    SrcB = 32'd150;
    #1;
    if (ALUResult !== 32'd1) // Less than
        $display ("FAIL: Value is %d", ALUResult);
    else
        $display ("PASS: SrcA is less than SrcB %d", ALUResult);
     if(Zero !== 0)//Make sure zero goes back to zero
        $display ("FAIL: Zero is falsely on");
    else
        $display ("PASS: Zero is off");
end

endmodule
