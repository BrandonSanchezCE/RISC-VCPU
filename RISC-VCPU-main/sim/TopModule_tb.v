module TopModule_tb();
reg Clk, Reset;
TopModule instance1(.Clk(Clk), .Reset(Reset));

initial
Clk = 0;
always #5 Clk = !Clk;

initial begin
@(negedge Clk);
Reset <= 1;
@(posedge Clk);

    @(negedge Clk);
//TopModule -> DataPath-> INSTRM -> Instruction
instance1.instance1.instance3.Register[6] = 0; // For Branch Later
instance1.instance1.instance2.Instruction[0] = 32'h00500093; // Add 5 to register 0 and save to register1
instance1.instance1.instance2.Instruction[1] = 32'h00300113; //Add 3 into register2
instance1.instance1.instance2.Instruction[2] = 32'h002081b3; //Add register1 and register2 into register3
instance1.instance1.instance2.Instruction[3] = 32'h00302023;//Save register3 into memory0
instance1.instance1.instance2.Instruction[4] = 32'h00002203; // Load Write into memory address 0 into register address 4 
instance1.instance1.instance2.Instruction[5] = 32'h00320c63; // Branch to Instruction 11. Based on if Register 3 and 4 are the same, which they are.
instance1.instance1.instance2.Instruction[6] = 32'h00118293; //Add 1 to register 3 and save to register 5. Catch if it didn't branch
instance1.instance1.instance2.Instruction[7] = 32'h00000013;// Do Nothing Skipped
instance1.instance1.instance2.Instruction[8] = 32'h00000013;//|
instance1.instance1.instance2.Instruction[9] = 32'h00000013;//|
instance1.instance1.instance2.Instruction[10] = 32'h00000013;//|
instance1.instance1.instance2.Instruction[11] = 32'h00218293; //Add 2 to register 3 and save to register 5
instance1.instance1.instance2.Instruction[12] = 32'h00208c63; //Compare x1 and x2 and do not branch to instruction 17
instance1.instance1.instance2.Instruction[13] = 32'h018008ef;///Jump to Instruction 18. Store PC+4 into register 17
instance1.instance1.instance2.Instruction[14] = 32'h00000013;// Do Nothing Skipped
instance1.instance1.instance2.Instruction[15] = 32'h00000013;// Do Nothing Skipped
instance1.instance1.instance2.Instruction[16] = 32'h00000013;//|
instance1.instance1.instance2.Instruction[17] = 32'h00118313; // False Branch Add 1 to Register 3 and store in register 6
instance1.instance1.instance2.Instruction[19] = 32'h00218393; // Jumped Instruction Add 2 to Register 3 and store in register 7
instance1.instance1.instance2.Instruction[18] = 32'h00000013;// Do Nothing Skipped
instance1.instance1.instance2.Instruction[20] = 32'h00000013;// Do Nothing Skipped



//0000,0001,1000,0000,0000,0100,1110,1111
Reset = 0;
repeat (24)
    @(posedge Clk);
#10;
if(instance1.instance1.instance3.Register[1] !== 32'd5) begin
    $display ("FAIL: Register 1 is %d", instance1.instance1.instance3.Register[1]);
    end
    else begin
    $display ("PASS: Register 1 properly read 5");
    end 
if(instance1.instance1.instance3.Register[2] !== 32'd3) begin
    $display ("FAIL: Register 2 displayed %d", instance1.instance1.instance3.Register[2]);
    end
    else begin
    $display ("PASS: Register 2  properly read 3");
    end
if(instance1.instance1.instance3.Register[3] !== 32'd8) begin
    $display ("FAIL: Register 3  displayed %d", instance1.instance1.instance3.Register[3]);
    end
    else begin
    $display ("PASS: Register 3 properly read 8");
    end 
if(instance1.instance1.instance6.Data[0] !== 32'd8) begin
    $display ("FAIL: Data Memory 0 displayed %d", instance1.instance1.instance6.Data[0]);
    end
    else begin
    $display ("PASS: Data Memory 0 properly read 8");
    end 
if(instance1.instance1.instance3.Register[5] == 32'd9) begin
    $display ("FAIL: Register 5 displayed 9 displayed, meaning no skip happened");
    end
    else if (instance1.instance1.instance3.Register[5] !== 32'd10) begin
        $display ("FAIL: Register 5 displayed %d",instance1.instance1.instance3.Register[5]);
    end
    else begin
        $display ("PASS: Register 5 is 10");
    end
if(instance1.instance1.instance3.Register[6] !== 32'd0) begin
    $display("FAIL: Register 6 is %d",instance1.instance1.instance3.Register[6] );
end
else
    $display("PASS: Instruction was not skipped");
if (instance1.instance1.instance3.Register[7] !== 32'd10) begin
    $display("FAIL: Register 7 is %d", instance1.instance1.instance3.Register[7]);
end
else begin
    $display("PASS: Properly jumped");
end
if(instance1.instance1.instance3.Register[17] !== 32'd56) begin
    $display("FAIL: Register 17 is %d", instance1.instance1.instance3.Register[17]);
end
else begin
    $display("PASS: Register 17 saved old address + 4");
end

end


//8

endmodule
