`timescale 1ns/1ps

module DATAM_tb();

logic [31:0] Address;
logic [31:0] WriteData;
logic Clk;
logic [3:0] WriteEnable;
logic [15:0] Switches;
logic [15:0] Leds;
logic [31:0] ReadData;

DATAM DUT(
    .Address(Address),
    .WriteData(WriteData),
    .Clk(Clk),
    .WriteEnable(WriteEnable),
    .Switches(Switches),
    .Leds(Leds),
    .ReadData(ReadData)
);

always #5 Clk = ~Clk;

initial begin
    Clk = 0;
    WriteEnable = 4'b0000;
    Address = 0;
    WriteData = 0;
    Switches = 16'hABCD;

    #10;
    Address = 32'h00001004; 
    #10;
    assert(ReadData == 32'h0000ABCD) $display("TEST 1 PASSED: Read Switches");
    else $error("TEST 1 FAILED");

    Address = 32'h00001000;
    WriteData = 32'h0000FFFF;
    WriteEnable = 4'b0011; 
    #10;
    WriteEnable = 4'b0000;
    #10;
    assert(Leds == 16'hFFFF) $display("TEST 2 PASSED: Write LEDs");
    else $error("TEST 2 FAILED");

    Address = 32'd20;
    WriteData = 32'hDEADBEEF;
    WriteEnable = 4'b1111;
    #10;
    WriteEnable = 4'b0000;
    #10;
    assert(ReadData == 32'hDEADBEEF) $display("TEST 3 PASSED: Standard Word Write/Read");
    else $error("TEST 3 FAILED");

    Address = 32'd24;
    WriteData = 32'h11223344;
    WriteEnable = 4'b0001; 
    #10;
    WriteEnable = 4'b0000;
    #10;
    assert(ReadData == 32'h00000044) $display("TEST 4 PASSED: Standard Byte Write/Read");
    else $error("TEST 4 FAILED");

    #10;
    $display("ALL DATAM TESTS FINISHED");
    $finish;
end

endmodule