`timescale 1ns/1ps

module PipelineSingleInstr_tb();

logic Clk;
logic Reset;

TopModule DUT(
    .Clk(Clk),
    .Reset(Reset)
);

always #5 Clk = ~Clk;

integer i;

task clear_state;
begin
    Reset = 1;
    for (i = 0; i < 32; i = i + 1) begin
        DUT.instance1.instance2.Instruction[i] = 32'h00000013; 
        DUT.instance1.instance3.Register[i] = 0;
    end
    #10;
    Reset = 0;
end
endtask

initial begin
    Clk = 0;

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00A00093;
    #100;
    assert(DUT.instance1.instance3.Register[1] == 10) 
        $display("TEST 1 PASSED: ADDI");
    else $error("TEST 1 FAILED: ADDI");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00A00093;
    DUT.instance1.instance2.Instruction[4] = 32'h01400113;
    DUT.instance1.instance2.Instruction[8] = 32'h002081B3;
    #150;
    assert(DUT.instance1.instance3.Register[3] == 30) 
        $display("TEST 2 PASSED: ADD");
    else $error("TEST 2 FAILED: ADD");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00A00093;
    DUT.instance1.instance2.Instruction[4] = 32'h01400113;
    DUT.instance1.instance2.Instruction[8] = 32'h40110233;
    #150;
    assert(DUT.instance1.instance3.Register[4] == 10) 
        $display("TEST 3 PASSED: SUB");
    else $error("TEST 3 FAILED: SUB");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00300093;
    DUT.instance1.instance2.Instruction[4] = 32'h00600113;
    DUT.instance1.instance2.Instruction[8] = 32'h0020F2B3;
    #150;
    assert(DUT.instance1.instance3.Register[5] == 2) 
        $display("TEST 4 PASSED: AND");
    else $error("TEST 4 FAILED: AND");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00300093;
    DUT.instance1.instance2.Instruction[4] = 32'h00600113;
    DUT.instance1.instance2.Instruction[8] = 32'h0020E333;
    #150;
    assert(DUT.instance1.instance3.Register[6] == 7) 
        $display("TEST 5 PASSED: OR");
    else $error("TEST 5 FAILED: OR");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00300093;
    DUT.instance1.instance2.Instruction[4] = 32'h00600113;
    DUT.instance1.instance2.Instruction[8] = 32'h0020A3B3;
    #150;
    assert(DUT.instance1.instance3.Register[7] == 1) 
        $display("TEST 6 PASSED: SLT");
    else $error("TEST 6 FAILED: SLT");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00A00093;
    DUT.instance1.instance2.Instruction[4] = 32'h00800113;
    DUT.instance1.instance2.Instruction[8] = 32'h00112023;
    DUT.instance1.instance2.Instruction[12] = 32'h00012403;
    #200;
    assert(DUT.instance1.instance3.Register[8] == 10) 
        $display("TEST 7 PASSED: SW and LW");
    else $error("TEST 7 FAILED: SW and LW");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00500093;
    DUT.instance1.instance2.Instruction[4] = 32'h00500113;
    DUT.instance1.instance2.Instruction[8] = 32'h00208463;
    DUT.instance1.instance2.Instruction[11] = 32'h00100193;
    DUT.instance1.instance2.Instruction[12] = 32'h00100213;
    #200;
    assert(DUT.instance1.instance3.Register[4] == 1 && DUT.instance1.instance3.Register[3] == 0) 
        $display("TEST 8 PASSED: BEQ Taken");
    else $error("TEST 8 FAILED: BEQ Taken");

    clear_state();
    DUT.instance1.instance2.Instruction[0] = 32'h00500093;
    DUT.instance1.instance2.Instruction[4] = 32'h00600113;
    DUT.instance1.instance2.Instruction[8] = 32'h00208463;
    DUT.instance1.instance2.Instruction[11] = 32'h00100193;
    DUT.instance1.instance2.Instruction[12] = 32'h00100213;
    #200;
    assert(DUT.instance1.instance3.Register[4] == 1 && DUT.instance1.instance3.Register[3] == 1) 
        $display("TEST 9 PASSED: BEQ Not Taken");
    else $error("TEST 9 FAILED: BEQ Not Taken");

    clear_state();
    DUT.instance1.instance2.Instruction[8] = 32'h0100046F;
    DUT.instance1.instance2.Instruction[11] = 32'h00100193;
    DUT.instance1.instance2.Instruction[12] = 32'h00100213;
    #200;
    assert(DUT.instance1.instance3.Register[8] == 36 && DUT.instance1.instance3.Register[4] == 1 && DUT.instance1.instance3.Register[3] == 0) 
        $display("TEST 10 PASSED: JAL");
    else $error("TEST 10 FAILED: JAL");

    #20;
    $display("ALL SINGLE-INSTRUCTION PIPELINE TESTS FINISHED");
    $finish;
end

endmodule