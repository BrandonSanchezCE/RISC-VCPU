`timescale 1ns/1ps

module Pipeline_Hazard_tb();

logic Clk;
logic Reset;

TopModule DUT(
    .Clk(Clk),
    .Reset(Reset)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    Reset = 1;
    
    force DUT.instance1.sw = 16'h0000;
    
    #20;
    Reset = 0;
    
    #300;
    
    assert(DUT.instance1.LED == 16'h0000)
        $display("TEST 1 PASSED: Incorrect switches -> LEDs OFF");
    else $error("TEST 1 FAILED: LEDs are not OFF");

    force DUT.instance1.sw = 16'h80D9;
    
    #200;

    assert(DUT.instance1.LED == 16'hFFFF)
        $display("TEST 2 PASSED: Correct switches -> LEDs ON");
    else $error("TEST 2 FAILED: LEDs are not ON, value is %h", DUT.instance1.LED);
    
    assert(DUT.instance1.instance3.Register[1] == 32'h00001000)
        $display("TEST 3 PASSED: x1 initialized correctly (Forwarding success)");
    else $error("TEST 3 FAILED: x1 = %h", DUT.instance1.instance3.Register[1]);
    
    assert(DUT.instance1.instance3.Register[3] == 32'd32985)
        $display("TEST 4 PASSED: x3 initialized correctly (Forwarding success)");
    else $error("TEST 4 FAILED: x3 = %d", DUT.instance1.instance3.Register[3]);

    #10;
    $display("ALL FULL PIPELINE + HAZARD TESTS FINISHED");
    $finish;
end

endmodule