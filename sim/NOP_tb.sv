`timescale 1ns/1ps

module PipelineNopPadded_tb();

logic Clk;
logic Reset;

TopModule DUT(
    .Clk(Clk),
    .Reset(Reset)
);

always #5 Clk = ~Clk;

integer i;

task load_padded_program;
begin
    Reset = 1;
    for (i = 0; i < 1024; i = i + 1) begin
        DUT.instance1.instance2.Instruction[i] = 32'h00000013;
    end
    
    DUT.instance1.instance2.Instruction[0] = 32'h00500093; 
    DUT.instance1.instance2.Instruction[4] = 32'h00000113; 
    DUT.instance1.instance2.Instruction[8] = 32'h01400193; 
    
    DUT.instance1.instance2.Instruction[12] = 32'h0001A203; 
    DUT.instance1.instance2.Instruction[16] = 32'h00120213; 
    DUT.instance1.instance2.Instruction[20] = 32'h0041A023; 
    DUT.instance1.instance2.Instruction[24] = 32'h00110113; 
    DUT.instance1.instance2.Instruction[28] = 32'hFC1140E3; 
    
    DUT.instance1.instance2.Instruction[32] = 32'h00000073;

    for (i = 0; i < 256; i = i + 1) begin
        DUT.instance1.instance6.Data[i] = 0;
    end
    
    for (i = 0; i < 32; i = i + 1) begin
        DUT.instance1.instance3.Register[i] = 0;
    end
    
    #10;
    Reset = 0;
end
endtask

initial begin
    Clk = 0;
    load_padded_program();
    
    #1500;
    
    assert(DUT.instance1.instance3.Register[2] == 5)
        $display("TEST 1 PASSED: Loop counter (x2) reached 5");
    else $error("TEST 1 FAILED: Loop counter (x2) is %d", DUT.instance1.instance3.Register[2]);
    
    assert(DUT.instance1.instance6.Data[5] == 32'd5)
        $display("TEST 2 PASSED: Memory at address 20 reached 5 via round-trip");
    else $error("TEST 2 FAILED: Memory is %d", DUT.instance1.instance6.Data[5]);

    #10;
    $display("ALL NOP-PADDED PIPELINE TESTS FINISHED");
    $finish;
end

endmodule